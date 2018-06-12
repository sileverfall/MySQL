create table emp1(
-- column level constraint
empno decimal(4) primary key,
ename varchar(30) not null,
hiredate date  not null,
email varchar(30) unique,
deptno decimal(3) not null,
salary int,
title varchar(20) not null default 'engineer',
-- table level constraint
constraint emp_deptno_fk foreign key (deptno)
	references department (deptno)
    );
-- explicit default
insert into dept 
values (600,'Public Relations',default);
update dept 
set cityno =default
where deptno=500;

insert into emp1 
value (1001,'李大仁','2017/05/08','lee@gmail.com',200,47000,'engineer');
insert into emp1 
value (1002,'程又青','2017/05/08','chen@gmail.com',200,47000,'engineer');

 -- 因為有emp1有部門編號200的關聯
update department set deptno=201 where deptno=200;
delete from department where deptno=201;
-- 手動改cascade(也可以用工具):為了維持資料的一致性
alter table emp1 drop foreign key emp_deptno_fk;
alter table emp1 
add constraint emp_deptno_fk foreign key (deptno)
	references department (deptno) on delete cascade on update cascade;