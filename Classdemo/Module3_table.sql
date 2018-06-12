-- 透過sql產生的table
create table employee(
empno	decimal(4)	primary key,
ename	varchar(30)	not null,
hiredate	date	not null,
salary	int			not null,
deptno	decimal(3)	not null,
title	varchar(20)	not null
);
-- 系統產生的table
CREATE TABLE `department` (
  `deptno` decimal(3,0) NOT NULL,
  `dname` varchar(30) NOT NULL,
  `mgrno` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`deptno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
-- 查看表格狀態
show table status in db01;
-- 查看表格欄位設計
desc employee;

desc t1;
create table t1(a smallint, b varchar(20)); -- 新增一個表格t1
alter table t1 add c float; -- 新增欄位
alter table t1 modify c double; -- 調整資料型態
alter table t1 change c d int; -- 改欄位名稱
alter table t1 drop d; -- 刪除欄位
alter table t1 rename t2; -- 更改表格名稱
drop table t2; -- 刪除表格

-- 複製表格結構
create table emp like employee;
desc emp;



