CREATE TABLE `accessible_vehicles` (
  `plate` varchar(11) NOT NULL,
  `accessor` varchar(11) NOT NULL,
  PRIMARY KEY (`plate`,`accessor`),
  CONSTRAINT `FK_plate` FOREIGN KEY (`plate`) REFERENCES `owned_vehicles` (`plate`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;