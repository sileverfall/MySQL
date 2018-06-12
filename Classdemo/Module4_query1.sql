-- 顯示所有員工資料
select deptno from employee;
-- 顯示不重複的員工資料
select distinct deptno from employee;
-- 顯示組合後不重複的員工資料
select distinct deptno, title from employee; 

select * from employee;
-- where clause : 若條件是字元或日期必須使用單引號
select * from employee where deptno =100;
select * from employee where title ='engineer';
select * from employee where hiredate ='2007/07/06';
select * from employee where salary >=50000;

-- between... and...介於兩個值,包含頭尾值
select * from employee where salary between 30000 and 40000;

-- in 必須要在集合所列值的範圍中
select * from employee where title in('manager','engineer');

-- is null 是否為空值
select * from employee where title is null;

-- like 找出包含某字串的pattern
select * from employee where ename like '林%'; -- 第一個字是林
select * from employee where ename like '%生'; -- 最後一個字是生
select * from employee where ename like '_麗%'; -- 第二個字是麗
select * from employee where ename like '%麗%'; -- 所有名字有麗的人


-- 若要篩選較長的字串,可以結合substring的用法
select title, substring(ename,-2,2) from employee;
select * from employee where ename like '麗%'; -- 第二個字是麗

-- 若遇到名稱內本來就有底線 (要用斜線輔助)
select * from employee where title like '%SA\_%';
select * from employee where title like'%SA/_%' escape'/'; -- escape 可以被更動

-- and or 
select * from employee where salary >=45000 and ename like '林%';
select * from employee where salary >=45000 or ename like '林%';
-- not
select * from employee where title not in ('manager','engineer');
select * from department where mgrno is null;
select * from employee where salary not between 40000 and 60000;
select * from employee where ename not like '林%';

-- order by (asc 升冪 desc 降冪)
select * from employee order by hiredate desc;
select ename,deptno,salary from employee order by deptno, salary desc; -- 沒有指定就會是升冪(預設)
select ename, salary*12 as 'annual' from employee order by 'annual'; -- 欄位別名也可以排序
select ename, salary*12 as 'annual' from employee order by salary*12; -- 欄位運算式也可以排序
-- 欄位編號排序
select ename, deptno, salary from employee order by 3; -- ename(1) deptno(2) salary(3)

-- limit 指定回傳紀錄的數量
select * from employee limit 3; -- 只取前三筆資料
select * from employee limit 4,3; -- 跳過前四筆資料之後取前三筆資料
-- 排名: limit + order by
select * from employee order by hiredate limit 3; -- 找出最資深三位員工
select * from employee order by salary desc limit 3; -- 找出薪資最高的三位員工

-- 集合函數
-- AVG() 平均值
-- SUM() 加總
-- count() 回傳欄位總筆數
select count(deptno) from employee;
select count(distinct deptno) from employee;
-- max() min()
select max(salary) from employee;
select min(salary) from employee;
select count(*),sum(salary),avg(salary),max(salary),min(salary) from employee;
select count(mgrno) as 'Count' from department; -- 計算時不會包含null

-- group by 以某欄位為集合透過集合函數來計算
select deptno, avg(salary)'average' from employee group by deptno; -- 計算以部門編號分組的各組薪資平均
select deptno, avg(salary)'average' from employee group by deptno order by avg(salary); -- 不同部門平均薪資,並排序

-- 算出員工人數
select count(*) as 'Number' from employee;
select count(deptno) as 'Number' from employee;
-- 算出部門數量
select count(distinct deptno) as'Count' from employee;
-- 算出每個部門的員工人數
select deptno, count(*)'Count' from employee group by deptno;

-- 算出不同部門不同職稱的員工總薪資: 多個欄位的值必須完全相同才能在同一組
select deptno,title,sum(salary)as 'Total' from employee group by deptno,title;
-- 每一群組多一列統計分析資料: with rollup
select deptno,title,sum(salary)as 'Total' from employee group by deptno,title with rollup;

-- having : 集合函數 \無法使用別名
select deptno, avg(salary)average
from employee 
group by deptno
having avg(salary)>50000; -- 平均薪資超過50000的部門

-- 完整範例
/* 找出不同職稱的總薪資,
但不包含有"SA"這些字的職稱,且總薪資必須超過100000,最後結果並以總薪資排序*/
select title,sum(salary)
from employee
where title not like '%SA%'
group by title
having	sum(salary)>100000
order by 'Total'desc;