-- 重要題: 找出每個部門薪資最低的員工
-- correlated Subquery
select ename,salary, deptno
from employee as e
where	salary=(select min(salary)
			from employee
				where deptno =e.deptno);
-- 多列資料會出現錯誤
select ename,salary, deptno
from employee as e
where	salary=(select min(salary)
				from employee
				group by deptno);
-- select作為常數值,只適用單列子查詢 :
-- 找出部門代號為100的每位員工其薪資占部門代號為100的所有員工薪資百分比
select ename,title,salary,
	round(salary*100/
			(select sum(salary) 
				from employee
                where deptno=100),1) 'Percentage %' 
from employee
where deptno =100;
-- from作為資料來源:
select ename,title,salary,
	round(salary*100/t.total,1) 'Percentage %' 
from employee, (select sum(salary) total
				from employee 	
                where deptno =100) t
where deptno =100;

-- Multiple-Row Subquey
-- Any: <Any 小於最大的 / >Any 大於最小的
-- 找出職稱不是senior engineer 且薪資比senior engineer 最高薪資來的低的員工
select ename,title,salary
from employee
where salary <Any
			(select salary 
				from employee
					where title ='senior engineer')
and title != 'senior engineer';

-- 另法: 使用max()
select ename,title,salary
from employee
where salary <(select max(salary)
				from employee 	
					where title ='senior engineer')
and  title != 'senior engineer';

-- All: <ALL 小於最小/ >ALL 大於最大
-- 找出職稱不是senior engineer且薪資比senior engineer 最低薪資來的低的員工
select ename, title, salary
from employee
where salary <All
		(select salary 
			from employee
				where title='senior engineer')
and title !='senior engineer';

-- in :找出所有是主管的員工
select e.ename
from emp e
where e.empno in
			(select distinct m.mgrno
				from emp m);
                
-- not in : 找出所有不是主管的員工
select e.ename
from emp e
where e.empno not in
				(select distinct mgrno
                 from emp
                 where mgrno is not null);
                 
-- correlated Subquery
-- (動態寫法):找出部門代號為100的每位員工其薪資占部門代號為100的所有員工薪資百分比
select e.ename,e.title,e.salary,
	round(salary*100/
		(select sum(salary)
			from employee 
		where deptno =e.deptno),1) as 'Percentage'
from employee e
where deptno=100;

-- 找出每個部門薪資最低的員工
select ename,salary,deptno
from employee e
where salary in	
				(select min(salary)
                from employee
					group by deptno
                    having deptno =e.deptno);

-- 複製表格某些資料
create table emp100 as
select empno,ename,salary*12 annualSalary,hiredate
from employee
where deptno =100;

