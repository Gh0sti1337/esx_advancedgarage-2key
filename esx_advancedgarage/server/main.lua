ESX = nil

-- owner
--   type
--     plate
--       - secondaryKey
Vehicles = {}

-- plate
--   type
--   owner
--   state
--   vehicle
--   accessors:
--     accessor1
--     accessor2
VehcilesByPlate = {}

function Dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. Dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
 end


TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Make sure all Vehicles are Stored on restart
MySQL.ready(function()
	ParkVehicles()
end)

function ParkVehicles()
	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE `stored` = @stored', {
		['@stored'] = false
	}, function(rowsChanged)
		if rowsChanged > 0 then
			print(('esx_advancedgarage: %s vehicle(s) have been stored!'):format(rowsChanged))
		end
	end)
end

function Vehicles.isTypePresentInCache(owner, _type)
	if Vehicles[owner] ~= nil and Vehicles[owner][_type] ~= nil then
		return true
	end
	return false
end

function Vehicles.isOwnerPresent(owner)
	if Vehicles[owner] ~= nil then
		return true
	end
	return false
end

function Vehicles.putOrUpdateState(record, forceCreation, fetchType)

	local plate = string.sub(record.plate, 1, 7)

	-- if the vehicle is present we just update the state for safety reasons
	if Vehicles.isTypePresentInCache(record.owner, fetchType) == true and Vehicles[record.owner][fetchType][record.plate] ~= nil then

		if VehcilesByPlate[record.plate] ~= nil then
			VehcilesByPlate[record.plate].stored = record["stored"]
			VehcilesByPlate[record.plate].vehicle = record["vehicle"]
			return
		end
	end

	local ownerPresent = Vehicles[record.owner] ~= nil

	-- if forceCreation is true or the vehicle category basically already is fetched we insert the received record
	if forceCreation == true or (ownerPresent == true and Vehicles[record.owner][fetchType] ~= nil) then
		if ownerPresent == false then
			Vehicles[record.owner] = {}
			Vehicles[record.owner][fetchType] = {}
		end

		if ownerPresent == true and Vehicles[record.owner][fetchType] == nil then
			Vehicles[record.owner][fetchType] = {}
		end

		Vehicles[record.owner][fetchType][record.plate] = {secondaryKey = record.secondaryKey}

		if (VehcilesByPlate[plate] == nil) then
			VehcilesByPlate.insert(record)
		end

	end
end

function VehcilesByPlate.insert(record)

	if (VehcilesByPlate[record.plate] == nil) then

		VehcilesByPlate[record.plate] = {}
		VehcilesByPlate[record.plate].owner = record["owner"]
		VehcilesByPlate[record.plate].type = record["type"]
		VehcilesByPlate[record.plate].stored = record["stored"]
		VehcilesByPlate[record.plate].vehicle = record["vehicle"]

		if record.accessors ~= nil then
			VehcilesByPlate[record.plate]["accessors"] = {}
			for accessor in string.gmatch(record.accessors, '([^,]+)') do
				VehcilesByPlate[record.plate]["accessors"][accessor] = true
			end
		end
	end
end

function VehcilesByPlate.remove(plate, accessor)
	if VehcilesByPlate[plate] ~= nil and VehcilesByPlate[plate]["accessors"] ~= nil then
		VehcilesByPlate[plate]["accessors"][accessor] = nil
	end

end

function VehcilesByPlate.add(plate, accessor)
	if VehcilesByPlate[plate] == nil then
		return
	end

	if VehcilesByPlate[plate]["accessors"] == nil then
		VehcilesByPlate[plate]["accessors"] = {}
	end

	VehcilesByPlate[plate]["accessors"][accessor] = true
end

function Vehicles.getByType(owner, _type, showPounded)
	local result = {}
	if Vehicles.isTypePresentInCache(owner, _type) then
		for k, v in pairs(Vehicles[owner][_type]) do

			if (v ~= nil and Vehicles[owner][_type][k] ~= nil) then
				local kk = string.sub(k, 1, 7)
				local entry = VehcilesByPlate[kk]
				local record = {owner = owner, plate = k, stored = entry.stored, vehicle = entry.vehicle, secondaryKey = v.secondaryKey}

				if showPounded == true then
					table.insert(result, record)
				elseif showPounded == false and v.stored == true then
					table.insert(result, record)
				end
			end
		end
	end
	return result
end

function Vehicles.getByTypeAndState(owner, _type, state)
	local result = {}
	if Vehicles.isTypePresentInCache(owner, _type) then
		for k, v in pairs(Vehicles[owner][_type]) do
			if (Vehicles[owner][_type][k] ~= nil) then
				local entry = VehcilesByPlate[k]
				if entry.stored == state then
					local record = {owner = owner, plate = k, stored = entry.stored, vehicle = entry.vehicle, secondaryKey = v.secondaryKey}
					table.insert(result, record)
				end
			end
		end
	end
	return result
end

function PreUpdatestate(vehicle, state, owner, _type)
	local plate = string.sub(vehicle.plate, 1, 7)
	if VehcilesByPlate[plate] == nil then
		return
	end

	VehcilesByPlate.updateState(vehicle, state)
end

function VehcilesByPlate.updateState(vehicle, state)
	local plate = string.sub(vehicle.plate, 1, 7)

	if VehcilesByPlate[plate] ~= nil then
		VehcilesByPlate[plate].stored = state
		VehcilesByPlate[plate].vehicle = vehicle
	end
end

function PutOrUpdateCaches(record, fetchType)
	Vehicles.putOrUpdateState(record, false, fetchType)
end

function PutSecondaryKeyIntoCache(record, fetchType)
	if Vehicles.isTypePresentInCache(record.owner, fetchType) == true then
		Vehicles.putOrUpdateState(record, true, fetchType)
	end
end

function InsertIntoCaches(record, fetchType)

	if record.stored == 0 then
		record.stored = false
	end

	VehcilesByPlate.insert(record)
	Vehicles.putOrUpdateState(record, true, fetchType)
end

function Vehicles.remove(owner, _type, plate)
	if Vehicles.isTypePresentInCache(owner, _type) == false then
		return
	end

	Vehicles[owner][_type][plate] = nil
end

function FindTypeOfPlate(owner, plate)
	if Vehicles.isOwnerPresent(owner) then
		for k in pairs(Vehicles[owner]) do
			for i in pairs(Vehicles[owner][k]) do
				if i == plate then
					return k
				end
			end
		end
	end
	return nil
end

RegisterServerEvent('esx_advancedgarage:switchOwner')
AddEventHandler('esx_advancedgarage:switchOwner', function(receiver, _plate, _type)
	local plate = string.sub(_plate, 1, 7)
	local fetchType = _type
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner_charid = xPlayer.charid
	local xReceiver = ESX.GetPlayerFromId(receiver)
	local receiver_charid = xReceiver.charid

	if fetchType == nil then
		fetchType = FindTypeOfPlate(owner_charid, plate)
	end
	
	-- add to new owner cache if fetched
	if (Vehicles.isTypePresentInCache(receiver_charid, fetchType) == true) then
		Vehicles[receiver_charid][fetchType][plate] = {secondaryKey = false}
	end

	-- if old owner has a secondary key, change access
	-- else remove it from his vehicles

	if VehcilesByPlate[plate] == nil then
		LoadIntoCache(plate, xPlayer.identifier, owner_charid)
	end

	if (VehcilesByPlate[plate]["accessors"] ~= nil and VehcilesByPlate[plate]["accessors"][owner_charid] == true) then
		Vehicles[owner_charid][fetchType][plate] = {secondaryKey = true}
	else
		Vehicles.remove(owner_charid, fetchType, plate)
	end
end)

RegisterServerEvent('esx_advancedgarage:addToCacheOrUpdateState')
AddEventHandler('esx_advancedgarage:addToCacheOrUpdateState', function(record, _fetchType)
	local fetchType = _fetchType
	local xPlayer = ESX.GetPlayerFromId(source)

	if record['owner'] == nil then
		record.owner = xPlayer.charid
	end
	if fetchType == nil then
		fetchType = FindTypeOfPlate(record.owner, record.plate)
	end

	PutOrUpdateCaches(record, fetchType)
end)

RegisterServerEvent('esx_advancedgarage:addToCache')
AddEventHandler('esx_advancedgarage:addToCache', function(record, _fetchType)
	if Vehicles.isTypePresentInCache(record.owner, _fetchType) == true then
		InsertIntoCaches(record, _fetchType)
	end
end)

RegisterServerEvent('esx_advancedgarage:removeFromCacheOnly')
AddEventHandler('esx_advancedgarage:removeFromCacheOnly', function(owner, plate, _vehicleType)
	local vehicleType = _vehicleType
	if vehicleType == nil then
		vehicleType = FindTypeOfPlate(owner, plate)
	end

	Vehicles.remove(owner, vehicleType, plate)
	VehcilesByPlate.remove(plate, owner)
end)

-- Fetch Owned Aircrafts
ESX.RegisterServerCallback('esx_advancedgarage:getOwnedAircrafts', function(source, cb)
	local ownedAircrafts = {}
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier
	local owner_char = xPlayer.charid

	if Config.DontShowPoundCarsInGarage == true then
		local fromCache = Vehicles.getByType(owner_char, 'aircraft', false)

		if next(fromCache) ~= nil then
			cb(fromCache)
			return
		end

		MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job AND o.`stored` = @stored GROUP BY o.plate', {
			['@owner']  = owner,
			['@owner_charid'] = owner_char,
			['@Type']   = 'aircraft',
			['@job']    = 'null',
			['@stored'] = true
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local secondaryKey = true
				if owner == v.owner then
					secondaryKey = false
				end
				local record = {owner = owner_char, vehicle = vehicle, stored = v.stored, plate = v.plate, accessors = v.accessors, secondaryKey = secondaryKey}
				table.insert(ownedAircrafts, record)
				InsertIntoCaches(record, 'aircraft')
			end
			cb(ownedAircrafts)
		end)
	else
		local fromCache = Vehicles.getByType(owner_char, 'aircraft', true)

		if next(fromCache) ~= nil then
			cb(fromCache)
			return
		end

		MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job GROUP BY o.plate', {
			['@owner']  = owner,
			['@owner_charid'] = owner_char,
			['@Type']   = 'aircraft',
			['@job']    = 'null'
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local secondaryKey = true
				if owner == v.owner then
					secondaryKey = false
				end
				local record = {owner = owner_char, vehicle = vehicle, stored = v.stored, plate = v.plate, accessors = v.accessors, secondaryKey = secondaryKey}
				table.insert(ownedAircrafts, record)
				InsertIntoCaches(record, 'aircraft')
			end
			cb(ownedAircrafts)
		end)
	end
end)

-- Fetch Owned Boats
ESX.RegisterServerCallback('esx_advancedgarage:getOwnedBoats', function(source, cb)
	local ownedBoats = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier
	local owner_char = xPlayer.charid

	if Config.DontShowPoundCarsInGarage == true then
		local fromCache = Vehicles.getByType(owner_char, 'boat', false)

		if next(fromCache) ~= nil then
			cb(fromCache)
			return
		end

		MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job AND o.`stored` = @stored GROUP BY o.plate', {
			['@owner']  = owner,
			['@owner_charid'] = owner_char,
			['@Type']   = 'boat',
			['@job']    = 'null',
			['@stored'] = true
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local secondaryKey = true
				if owner == v.owner then
					secondaryKey = false
				end
				local record = {owner = owner_char, vehicle = vehicle, stored = v.stored, plate = v.plate, accessors = v.accessors, secondaryKey = secondaryKey}
				table.insert(ownedBoats, record)
				InsertIntoCaches(record, 'boat')
			end
			cb(ownedBoats)
		end)
	else
		local fromCache = Vehicles.getByType(owner_char, 'boat', true)

		if next(fromCache) ~= nil then
			cb(fromCache)
			return
		end
		
		MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job GROUP BY o.plate', {
			['@owner']  = owner,
			['@owner_charid'] = owner_char,
			['@Type']   = 'boat',
			['@job']    = 'null'
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local secondaryKey = true
				if owner == v.owner then
					secondaryKey = false
				end
				local record = {owner = owner_char, vehicle = vehicle, stored = v.stored, plate = v.plate, accessors = v.accessors, secondaryKey = secondaryKey}
				table.insert(ownedBoats, record)
				InsertIntoCaches(record, 'boat')
			end
			cb(ownedBoats)
		end)
	end
end)

-- Fetch Owned Cars
ESX.RegisterServerCallback('esx_advancedgarage:getOwnedCars', function(source, cb)
	local ownedCars = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier
	local owner_char = xPlayer.charid

	if Config.DontShowPoundCarsInGarage == true then
		
		local fromCache = Vehicles.getByType(owner_char, 'car', false)

		if next(fromCache) ~= nil then
			cb(fromCache)
			return
		end
		
		MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job AND o.`stored` = @stored GROUP BY o.plate', {
			['@owner']  = owner,
			['@owner_charid'] = owner_char,
			['@Type']   = 'car',
			['@job']    = 'null',
			['@stored'] = true
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local secondaryKey = true
				if owner == v.owner then
					secondaryKey = false
				end
				local record = {owner = owner_char, vehicle = vehicle, stored = v.stored, plate = v.plate, accessors = v.accessors, secondaryKey = secondaryKey}
				table.insert(ownedCars, record)
				InsertIntoCaches(record, 'car')
			end
			cb(ownedCars)
		end)
	else
		local fromCache = Vehicles.getByType(owner_char, 'car', true)
		if next(fromCache) ~= nil then
			cb(fromCache)
			return
		end
		MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job GROUP BY o.plate', {
			['@owner']  = owner,
			['@owner_charid'] = owner_char,
			['@Type']   = 'car',
			['@job']    = 'null'
		}, function(data)
			for _,v in pairs(data) do
				local vehicle = json.decode(v.vehicle)
				local secondaryKey = true
				if owner == v.owner then
					secondaryKey = false
				end
				local record = {owner = owner_char, vehicle = vehicle, stored = v.stored, plate = v.plate, accessors = v.accessors, secondaryKey = secondaryKey}
				table.insert(ownedCars, record)
				InsertIntoCaches(record, 'car')
			end
			cb(ownedCars)
		end)
	end
end)

-- Store Vehicles
ESX.RegisterServerCallback('esx_advancedgarage:storeVehicle', function(source, cb, vehicleProps, _plate)
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier
	local owner_char = xPlayer.charid
	local vehiclemodel = vehicleProps.model
	local plate = string.sub(_plate, 1, 7)
	
	MySQL.Async.fetchAll('SELECT o.type, o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.plate = @plate GROUP BY o.plate', {
		['@owner'] = owner,
		['@owner_charid'] = owner_char,
		['@plate'] = plate
	}, function (result)

		if result[1] ~= nil then
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then

				MySQL.Async.execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@vehicle'] = json.encode(vehicleProps),
					['@plate']  = plate
				}, function (rowsChanged)
					if rowsChanged == 0 then
						print(('esx_advancedgarage: %s attempted to store an vehicle they don\'t own!'):format(owner))
					else
						PreUpdatestate(vehicleProps, true, owner_char, result[1].type)
					end
					cb(true)
				end)
			else
				if Config.KickPossibleCheaters == true then
					if Config.UseCustomKickMessage == true then
						print(('esx_advancedgarage: %s attempted to Cheat! Tried Storing: '..vehiclemodel..'. Original Vehicle: '..originalvehprops.model):format(owner))
						DropPlayer(source, _U('custom_kick'))
						cb(false)
					else
						print(('esx_advancedgarage: %s attempted to Cheat! Tried Storing: '..vehiclemodel..'. Original Vehicle: '..originalvehprops.model):format(owner))
						DropPlayer(source, 'You have been Kicked from the Server for Possible Garage Cheating!!!')
						cb(false)
					end
				else
					print(('esx_advancedgarage: %s attempted to Cheat! Tried Storing: '..vehiclemodel..'. Original Vehicle: '..originalvehprops.model):format(owner))
					cb(false)
				end
			end
		else
			print(('esx_advancedgarage: %s attempted to store an vehicle they don\'t own!'):format(owner))
			cb(false)
		end
	end)
end)

-- Fetch Pounded Aircrafts
ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedAircrafts', function(source, cb)
	local ownedAircrafts = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier
	local owner_char = xPlayer.charid
	local fromCache = Vehicles.getByTypeAndState(owner_char, 'aircraft', false)

	if next(fromCache) ~= nil then
		cb(fromCache)
	end

	MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job AND o.`stored` = @stored GROUP BY o.plate', {
		['@owner'] = owner,
		['@owner_charid'] = owner_char,
		['@Type']   = 'aircraft',
		['@job']    = 'null',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAircrafts, vehicle)
		end
		cb(ownedAircrafts)
	end)
end)

-- Fetch Pounded Boats
ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedBoats', function(source, cb)
	local ownedBoats = {}
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier
	local owner_char = xPlayer.charid
	local fromCache = Vehicles.getByTypeAndState(owner_char, 'boat', false)

	if next(fromCache) ~= nil then
		cb(fromCache)
	end

	MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job AND o.`stored` = @stored GROUP BY o.plate', {
		['@owner'] = owner,
		['@owner_charid'] = owner_char,
		['@Type']   = 'boat',
		['@job']    = 'null',
		['@stored'] = false
	}, function(data)
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedBoats, vehicle)
		end
		cb(ownedBoats)
	end)
end)

-- Fetch Pounded Cars
ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedCars', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier
	local owner_char = xPlayer.charid
	local fromCache = Vehicles.getByTypeAndState(owner_char, 'car', false)

	if next(fromCache) ~= nil then
		cb(fromCache)
	end

	local ownedCars = {}
	MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) AND o.type = @Type AND o.job = @job AND o.`stored` = @stored GROUP BY o.plate', {
		['@owner'] = owner,
		['@owner_charid'] = owner_char,
		['@Type']   = 'car',
		['@job']    = 'null',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedCars, vehicle)
		end
		cb(ownedCars)
	end)
end)

-- Fetch Pounded Policing Vehicles
ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedPolicingCars', function(source, cb)
	local ownedPolicingCars = {}
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND `stored` = @stored', {
		['@owner'] = GetPlayerIdentifiers(source)[1],
		['@job']    = 'police',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedPolicingCars, vehicle)
		end
		cb(ownedPolicingCars)
	end)
end)

-- Fetch Pounded Ambulance Vehicles
ESX.RegisterServerCallback('esx_advancedgarage:getOutOwnedAmbulanceCars', function(source, cb)
	local ownedAmbulanceCars = {}
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND job = @job AND `stored` = @stored', {
		['@owner'] = GetPlayerIdentifiers(source)[1],
		['@job']    = 'ambulance',
		['@stored'] = false
	}, function(data) 
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(ownedAmbulanceCars, vehicle)
		end
		cb(ownedAmbulanceCars)
	end)
end)

-- Check Money for Pounded Aircrafts
ESX.RegisterServerCallback('esx_advancedgarage:checkMoneyAircrafts', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get('money') >= Config.AircraftPoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Check Money for Pounded Boats
ESX.RegisterServerCallback('esx_advancedgarage:checkMoneyBoats', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get('money') >= Config.BoatPoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Check Money for Pounded Cars
ESX.RegisterServerCallback('esx_advancedgarage:checkMoneyCars', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get('money') >= Config.CarPoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Check Money for Pounded Policing
ESX.RegisterServerCallback('esx_advancedgarage:checkMoneyPolicing', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get('money') >= Config.PolicingPoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Check Money for Pounded Ambulance
ESX.RegisterServerCallback('esx_advancedgarage:checkMoneyAmbulance', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.get('money') >= Config.AmbulancePoundPrice then
		cb(true)
	else
		cb(false)
	end
end)

-- Pay for Pounded Aircrafts
RegisterServerEvent('esx_advancedgarage:payAircraft')
AddEventHandler('esx_advancedgarage:payAircraft', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.AircraftPoundPrice)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. Config.AircraftPoundPrice)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(Config.AircraftPoundPrice)
	end)
end)

-- Pay for Pounded Boats
RegisterServerEvent('esx_advancedgarage:payBoat')
AddEventHandler('esx_advancedgarage:payBoat', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.BoatPoundPrice)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. Config.BoatPoundPrice)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(Config.BoatPoundPrice)
	end)
end)

-- Pay for Pounded Cars
RegisterServerEvent('esx_advancedgarage:payCar')
AddEventHandler('esx_advancedgarage:payCar', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.CarPoundPrice)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. Config.CarPoundPrice)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(Config.CarPoundPrice)
	end)
end)

-- Pay for Pounded Policing
RegisterServerEvent('esx_advancedgarage:payPolicing')
AddEventHandler('esx_advancedgarage:payPolicing', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.PolicingPoundPrice)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. Config.PolicingPoundPrice)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(Config.PolicingPoundPrice)
	end)
end)

-- Pay for Pounded Ambulance
RegisterServerEvent('esx_advancedgarage:payAmbulance')
AddEventHandler('esx_advancedgarage:payAmbulance', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(Config.AmbulancePoundPrice)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. Config.AmbulancePoundPrice)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(Config.AmbulancePoundPrice)
	end)
end)

-- Pay to Return Broken Vehicles
RegisterServerEvent('esx_advancedgarage:payhealth')
AddEventHandler('esx_advancedgarage:payhealth', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeMoney(price)
	TriggerClientEvent('esx:showNotification', source, _U('you_paid') .. price)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		account.addMoney(price)
	end)
end)

-- Modify State of Vehicles
RegisterServerEvent('esx_advancedgarage:setVehicleState')
AddEventHandler('esx_advancedgarage:setVehicleState', function(vehicle, state, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	-- if type is null it is something we do not want to cache
	if type ~= nil then
		PreUpdatestate(vehicle, state, xPlayer.charid, type)
	end

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate', {
		['@stored'] = state,
		['@plate'] = vehicle.plate
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('esx_advancedgarage: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)

-- Check if a player is owning a vehicle by its license plate
-- TODO MENDO: brauchst du das noch?
ESX.RegisterServerCallback('esx_advancedgarage:isPlayerOwningVehicleByPlate', function(source, cb, potentialOwner, _plate, type)
	local plate = string.sub(_plate, 1, 7)

	-- first check if vehicle is present in cache
	if Vehicles.isTypePresentInCache(potentialOwner, type) then
		if Vehicles[potentialOwner][type][plate] ~= nil then
			return true
		end
	end

	-- if not check the database
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE owner LIKE `%@owner%` AND plate = @plate', {
		['@owner'] = potentialOwner,
		['@plate'] = plate,
	}, function(data)
		if data ~= nil then
			cb(true)
		end
	end)
	-- no matches, player is not owning the vehicle
	cb(false)
end)

-- Give a Secondary Key
RegisterServerEvent('esx_advancedgarage:giveSecondaryKey')
AddEventHandler('esx_advancedgarage:giveSecondaryKey', function(_plate, receiver)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(receiver)
	local plate = string.sub(_plate, 1, 7)

	local _vehicle = nil
	local _stored = nil

	MySQL.Async.fetchAll('SELECT vehicle, type, `stored` FROM owned_vehicles WHERE plate = @plate and owner = @owner', {
		['@plate'] = plate,
		['@owner'] = xPlayer.identifier
	}, function(result)
		local vehicleObject = result[1]
		if vehicleObject then
			_vehicle = json.decode(vehicleObject["vehicle"])
			local type = vehicleObject["type"]

			MySQL.Async.execute('INSERT INTO accessible_vehicles (plate, accessor) VALUES (@plate, @accessor)', {
				['@plate'] = plate,
				['@accessor'] = xTarget.charid
			}, function(rowsChanged)
				if rowsChanged == 1 then
					local record = {owner = xTarget.charid, vehicle = _vehicle, stored = false, plate = plate, secondaryKey = true}
					PutSecondaryKeyIntoCache(record, type)
					VehcilesByPlate.add(plate, xTarget.charid)
					
					TriggerEvent('esx:give2ndkeys', "[" .. xPlayer.job.name .. "] " .. xPlayer.name .. " [" .. xPlayer.source .. "] hat [" .. xTarget.job.name .. "] " .. xTarget.name .. " [" .. xTarget.source .. "] einen 2t-Schlüssel für " .. plate .. " gegeben.")
					TriggerClientEvent('esx:showNotification', receiver, "Du ~g~erhälst~s~ von " .. xPlayer.name .." einen 2t-Schlüssel für: ~y~" .. plate .. "~s~")
				end
			end)

		else
			print(('esx_advancedgarage: %s tried to give away a secondary car key for a vehicle he is not owning'):format(xPlayer.identifier))
			return
		end
	end)
end)

-- Remove Accessor from accessible_vehicles
RegisterServerEvent('esx_advancedgarage:removeSecondaryKey')
AddEventHandler('esx_advancedgarage:removeSecondaryKey', function(_plate, accessor, _type, accessorSteamname)

	local plate = string.sub(_plate, 1, 7)

	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('DELETE FROM accessible_vehicles WHERE plate = @plate and accessor = @accessor', {
		['@plate'] = plate,
		['@accessor'] = accessor
	}, function(rowsChanged)
		if rowsChanged == 1 then
			VehcilesByPlate.remove(plate, accessor)
			Vehicles.remove(accessor, _type, plate)
			TriggerClientEvent('esx:showNotification', xPlayer.source, "Du hast den Schlüssel abgenommen für ~y~" .. plate .. " ~s~")
			local xTarget = ESX.GetPlayerFromCharID(accessor)
			if(xTarget ~= nil)then -- Target Online
				TriggerEvent('esx:remove2ndkeys', "[" .. xPlayer.job.name .. "] " .. xPlayer.name .. " [" .. xPlayer.source .. "] hat [" .. xTarget.job.name .. "] " .. xTarget.name .. " [" .. xTarget.source .. "] [ONLINE] einen 2t-Schlüssel für " .. plate .. " gegeben.")
				TriggerClientEvent('esx:showNotification', xTarget.source, "Der 2t-Schlüssel für ~y~" .. plate .. "~s~ wurde dir ~r~entzogen~s~.")
			else
				TriggerEvent('esx:remove2ndkeys', "[" .. xPlayer.job.name .. "] " .. xPlayer.name .. " [" .. xPlayer.source .. "] hat " .. accessorSteamname .. " [OFFLINE] den 2t-Schlüssel für " .. plate .. " abgenommen.")
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_advancedgarage:getPlayerNamesForPlateWithAccess', function(source, cb, _plate)
	local plate = string.sub(_plate, 1, 7)
	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier

	local names = {}
	MySQL.Async.fetchAll('SELECT o.owner, u.firstname, u.lastname, u.name, u.id FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate left join users as u on u.id = a.accessor where o.plate = @plate', {
		['@plate'] = plate
	}, function(data)
		if(data == nil or data[1] == nil) then
			cb(nil)
			return
		end

		if (data[1].owner ~= owner) then
			cb(false)
		end

		for _, v in pairs(data) do
			if v.name ~= nil then
				local record = {firstname = v.firstname, lastname = v.lastname, name = v.name, id = v.id}
				table.insert(names, record)
			end
		end

		cb(names)
	end)
end)

-- Check state of car
ESX.RegisterServerCallback('esx_advancedgarage:isAllowedToSpawn', function(source, cb, _plate)
	local plate = string.sub(_plate, 1, 7)

	local xPlayer = ESX.GetPlayerFromId(source)
	local owner = xPlayer.identifier
	local owner_charid = xPlayer.charid

	if VehcilesByPlate[plate] == nil then
		LoadIntoCache(plate, owner, owner_charid)
	end

	if (VehcilesByPlate[plate] ~= nil and (VehcilesByPlate[plate].stored == 1 or VehcilesByPlate[plate].stored == true)) then
		cb(true)
	else
		cb(false)
	end
end)

function LoadIntoCache(_plate, owner, owner_char)
	local plate = string.sub(_plate, 1, 7)

	MySQL.Async.fetchAll('SELECT o.owner, o.vehicle, o.`stored`, o.plate, GROUP_CONCAT(a.accessor) as accessors FROM owned_vehicles as o LEFT JOIN accessible_vehicles as a ON a.plate = o.plate WHERE (o.owner = @owner or a.accessor = @owner_charid) and o.plate = @plate GROUP BY o.plate', {
		['@owner'] = owner,
		['@owner_char'] = owner_char,
		['@plate'] = plate
	}, function(data)
		if(data == nil or data[1] == nil) then
			return
		end

		local r = data[1]
		local vehicle = json.decode(r.vehicle)

		local record = {owner = owner_char, vehicle = vehicle, stored = r.stored, plate = r.plate, accessors = r.accessors}
		VehcilesByPlate.insert(record)
	end)
end