-- insert
insert into department (deptno,dname,mgrno)
values (400,'Research',1001);
-- 同上
insert into department
values(500,'Personal',1001);
-- 沒有賦值的資料會自動填上default或是null
insert into department(deptno,dname)
values (601,'IT');
-- 同上
insert into department
values (602,'IT',null);
-- 可以同時新增兩筆以上資料
insert department(deptno,dname,mgrno)
values (603,'HRD',1003),(604,'STK',null);
-- 新增記錄包含日期
insert into employee
values (1009,'孫悟空',sysdate(),56000,100,'senior engineer');
insert into employee
values (1010,'豬八戒','2013/11/10',89000,200,'manager');
-- 將子查詢的結果新增至指定的表格(一個已經存在的表格)
-- 目標表格相同
create table emp_copy(
empno	decimal(4)	primary key,
ename	varchar(30)	not null,
hiredate	date	not null,
salary	int			not null,
deptno	decimal(3)	not null,
title	varchar(20)	not null
);
insert into emp_copy select * from employee;
-- 目標表格不同
create table emp_copy1(
empno	decimal(4)	primary key,
ename	varchar(30)	not null,
hiredate	date	not null,
salary	int			not null,
deptno	decimal(3)	not null
);

empno	decimal(4)	primary key,
ename	varchar(30)	not null,
hiredate	date	not null,
salary	int			not null,
deptno	decimal(3)	not null,
title	varchar(20)	not null
);
insert into emp_copy1 (empno,ename,hiredate,salary,deptno)
select empno,ename,hiredate,salary,deptno
from employee
where title not like '%SA%';

-- update
-- MySQL預設不允許修改沒有where子句
set sql_safe_updates=0; -- 刪除預設條件
update emp_copy
set salary=45000
where empno=1008;

update emp_copy1
set hiredate=curdate();

-- 將子查詢的結果作為欄位值
-- 將員工編號為1007的薪資改變成員工編號1006的薪資
update emp_copy
set salary =(select salary
				from emp_copy
                where empno=1006)
where empno=1007; -- 不允許subquery 中所使用的表格與update的表格是相同的

-- 將子查詢的結果作為欄位更新的條件
-- 將所有和員工編號為1001的薪資相同的員工,其部門代號變成1003
update emp_copy
set deptno=(select deptno 	
				from employee
                where empno=1003)
where salary=(select salary
				from employee
                where empno=1001);
                
                
-- delete
delete from emp_copy where empno=1007;
set sql_safe_updates=0;
delete from emp_copy1;
delete from department 
where deptno between 601 and 604;

delete from emp_copy
where deptno=(select deptno 
				from department 
                where dname='Accounting');