-- 外顯式explicit:rollback
start transaction;
insert into department values(601,'RD',1001);
insert into department values(602,'IT',null);

select *from department;
rollback;
select *from department;

-- 外顯式explicit:commit
start transaction;
insert into department values(601,'RD',1001);
insert into department values(602,'IT',null);

select *from department;
commit;
select *from department;

-- 隱含式交易 implicit 
set autocommit=0;
insert into deparment values(603,'RD',1001);
insert into department values(604,'IT',null);

select * from department;
rollback;

select * from department;
insert into department values (605,'RD',1001);
insert into department values (606,'IT',null);
select *from department;
commit;

select* from department;
set autocommit =1;

-- 儲存點 savepoint
begin ;
select empno,ename,salary
from employee
where empno in (1001,1002,1003);

update employee set salary =60000 
where empno=1001;
savepoint A;

update employee set salary =40000 
where empno=1002;
savepoint B;

update employee set salary =80000 
where empno=1003;
rollback to A;
commit;

select empno,ename,salary
from employee
where empno in(1001,1002,1003);

-- 鎖定 lock
-- 1
begin;
select salary 
from employee
where empno=1001;

-- 3 
update employee
set salary =56000
where empno=1001;

-- 5 確認交易,解開1001鎖定
commit;

select salary 
from employee
where empno=1001;