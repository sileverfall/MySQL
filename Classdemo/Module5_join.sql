-- cross join 排列組合(資料數為列數相乘)
select ename, dname from employee,department; -- 第一個表格有8列,第二個表格有3列,所以總共會有8*3=24筆資料
select ename,dname from employee cross join department; -- ANSI Join Type

-- inner join (equal join)
/* child 表格中的FK要對應到parent 表格的PK
   兩格表格中若有相同的欄位名稱,必須加表格名稱*/
select ename, dname, salary from employee, department where employee.deptno = department.deptno;
-- ANSI Join Type
select ename, dname, salary from employee join department on employee.deptno = department.deptno;

-- 同名欄位連結
-- join using:指定表格內同名欄位作為連結條件
select ename,emp.deptno,dname
from emp join dept
using (deptno);
-- natural join: 自動找兩個表格中名稱相同的欄位作為連結條件
select ename, emp.deptno,dname
from emp natural join dept;

-- 利用 and 增加條件
select ename, dname, salary 
from employee, department 
where employee.deptno = department.deptno
and title = 'manager';

select ename,dname,salary
from employee join department
using (deptno)
where title = 'manager';

-- 使用表格別名,增進效能
select e.ename, e.deptno, d.dname
from emp e,dept d
where e.deptno = d.deptno;

-- join N 個表格,至少需要N-1個條件
select e.ename, d.dname, c.cname
from emp e, dept d, city c
where e.deptno =d.deptno
and d.cityno = c.cityno;
-- ANSI Join Type
select e.ename, d.dname, c.cname
from emp e join dep d
on e.deptno =d.deptno
join city c
on d.cityno = c.cityno;

-- non-equal join: 不使用等於=
-- 找出所有員工的姓名、薪資、薪資等級
select e.ename, e.salary,g.level
from emp e,grade g
where e.salary between g.lowest and g.highest;

-- 找出所有員工的姓名、所屬部門、薪資、薪資等級
select e.ename, d.dname, e.salary, g.level
from emp e, dept d, grade g
where e.deptno =d.deptno
and e.salary between g.lowest and g.highest;

-- outer join :顯示所有符合或不符合join條件的資料
-- Left outer join
select e.ename,d.deptno,d.dname
from emp e left outer join dept d
on e.deptno =d.deptno;
-- Right outer join
select e.ename,d.deptno,d.dname
from emp e Right outer join dept d
on e.deptno =d.deptno;
-- Full outer join :union
select e.ename,d.deptno,d.dname
from emp e left outer join dept d
on e.deptno =d.deptno
union
select e.ename,d.deptno,d.dname
from emp e Right outer join dept d
on e.deptno =d.deptno;

-- self join :同一個表格自己join自己
set sql_mode ='PIPES_AS_CONCAT';
select worker.ename||'的主管是'||manager.ename
from emp worker,emp manager -- 一定要加(有意義的)別名
where worker.mgrno=manager.empno;