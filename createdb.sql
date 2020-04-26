CREATE TABLE `deposit` (
  `RoomType` varchar(255) NOT NULL,
  `depositprice` int(11) DEFAULT NULL,
  PRIMARY KEY (`RoomType`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `overall` (
  `YearMonthDay` date NOT NULL,
  `OverallPeople` int(100) DEFAULT NULL,
  `RoomReserved` int(100) DEFAULT NULL,
  `OverallMoneyOwn` int(100) DEFAULT NULL,
  `Profit` int(100) DEFAULT NULL,
  `VipIncreased` int(100) DEFAULT NULL,
  PRIMARY KEY (`YearMonthDay`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `permanent` (
  `customername` varchar(100) DEFAULT NULL,
  `IdentityNumber` varchar(100) NOT NULL,
  `VipStatus` varchar(11) DEFAULT NULL,
  `OwnMoney` int(100) DEFAULT NULL,
  PRIMARY KEY (`IdentityNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `room` (
  `RoomNumber` int(11) NOT NULL AUTO_INCREMENT,
  `RoomType` varchar(255) DEFAULT NULL,
  `Telephone` varchar(20) DEFAULT NULL,
  `RoomPrice` int(11) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`RoomNumber`),
  KEY `RoomType` (`RoomType`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`RoomType`) REFERENCES `deposit` (`RoomType`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8;

CREATE TABLE `reserve` (
  `RoomNumber` int(11) NOT NULL AUTO_INCREMENT,
  `IdentityNumber` varchar(100) DEFAULT NULL,
  `customername` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`RoomNumber`),
  CONSTRAINT `reserve_ibfk_1` FOREIGN KEY (`RoomNumber`) REFERENCES `room` (`RoomNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=404 DEFAULT CHARSET=utf8;

CREATE TABLE `vip` (
  `VipNumber` varchar(100) NOT NULL,
  `IdentityNumber` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`VipNumber`),
  KEY `IdentityNumber` (`IdentityNumber`),
  CONSTRAINT `vip_ibfk_1` FOREIGN KEY (`IdentityNumber`) REFERENCES `permanent` (`IdentityNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `now` (
  `IdentityNumber` varchar(100) NOT NULL,
  `RoomLiving` int(11) DEFAULT NULL,
  PRIMARY KEY (`IdentityNumber`),
  KEY `RoomLiving` (`RoomLiving`),
  CONSTRAINT `now_ibfk_1` FOREIGN KEY (`RoomLiving`) REFERENCES `room` (`RoomNumber`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `checkin` (
  `EventNumber` int(11) NOT NULL AUTO_INCREMENT,
  `IdentityNumber` varchar(100) DEFAULT NULL,
  `RoomLiving` int(11) DEFAULT NULL,
  `YearMonthDay` datetime DEFAULT NULL,
  `Gorl` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`EventNumber`),
  KEY `IdentityNumber` (`IdentityNumber`),
  KEY `RoomLiving` (`RoomLiving`),
  CONSTRAINT `checkin_ibfk_1` FOREIGN KEY (`IdentityNumber`) REFERENCES `permanent` (`IdentityNumber`),
  CONSTRAINT `checkin_ibfk_2` FOREIGN KEY (`RoomLiving`) REFERENCES `room` (`RoomNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;