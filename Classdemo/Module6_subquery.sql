-- 找出所有薪資比潘麗珍高的員工
select ename, salary
from employee 
where salary > (select salary
				from employee		
				where ename ='潘麗珍');
-- 找出所有最低薪資比部門代號為200最低薪資高的部門
select deptno,min(salary)'Minimum Salary'
from employee
group by deptno
having min(salary) > (select min(salary)
						from employee
					  where deptno =200);

-- 找出所有職稱和員工編號為1002相同且薪資比員工編號為1005高的員工
select ename,title,salary
from employee
where title=(select title
				from employee
			 where empno=1002)
and salary>(select salary
				from employee
			where empno=1005);