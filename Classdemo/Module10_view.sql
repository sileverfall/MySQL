-- 檢視表 view 預存查詢指令,是一種邏輯表格

-- 從表格employee中找出部門編號為1001的員工，以員工編號、員工姓名和薪資建立一名為empvu100的檢視表
create view empvu100
as select empno,ename,salary
	from employee
    where deptno=100;
-- 欄位名稱以別名的方式建立
create view salvu100
as select empno id,ename name,salary*12 annul_salary
	from employee
    where deptno=100;

-- 欄位名稱以column list方式建立
create view salvu100_1(id,name,annual_salary)
as select empno,ename,salary*12
	from employee
    where deptno=100;

-- 產生一個包含function或 group of data的view
-- 產生一個檢視表包含每個部門最低薪資、最高薪資和平均薪資
create view dept_sum_vu (name,minsal,maxsal,avgsal)
as select d.dname,min(e.salary),max(e.salary),avg(e.salary)
	from employee e, department d
    where e.deptno =d.deptno
    group by d.dname;
    
-- 透過view 可以執行DML,但其實是修改base table的資料
-- 不可以包含計算或是函式
-- 只從一個表格取得資料，不可以有join
update empvu100
set ename ='孫大聖' where empno=1009;

-- 若不在where子劇的資料也是無法修改
update empvu100
set ename='孫大聖' where empno=1003;
-- 不屬於view的欄位也無法修改
update empvu100
set title='SA' where empno=1009;
-- 透過 delete 刪除 base table 的資料
delete from empvu100 where empno=1009;
-- with check option
create view emp_sal_vw
as select empno,ename,salary
	from employee
	where salary<=40000
    with check option; -- 若沒有加此條件,不論之後的dml是否符合where限制都會執行
update emp_sal_vw
set salary =4000    