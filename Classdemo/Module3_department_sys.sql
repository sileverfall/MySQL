-- 系統產生的table
CREATE TABLE `module3_department` (
  `deptno` decimal(3,0) NOT NULL,
  `dname` varchar(30) NOT NULL,
  `mgrno` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
