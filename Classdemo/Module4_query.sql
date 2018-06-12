-- 取得所有的欄位
SELECT * FROM db01.employee;
select * from db01.department;

-- 取得部分的欄位
select deptno,dname from department;

-- 算術運算子 (/:有小數點, div:整除(整數結果))
select 17/4, 17%4, 17 div 4, 17 * null;-- 沒有欄位名稱
select 17/4'expr(/)', 17%4'expr(%)', 17 div 4'expr(div)', 17 * null'expr(null)';

-- 欄位別名
select ename as '員工姓名', salary*12 as '年薪' from employee;
select ename as '', salary*12 as '年薪' from employee;

-- 欄位串接
select 'Hello' || 'MySQL';
set sql_mode ='PIPES_AS_CONCAT'; -- 改變預設設定
set sql_mode = ' '; -- 還原預設設定

select ename || 'is a' || title '員工' from employee;
select ename || '  ' || title '員工' from employee; -- 空格
select ename || space(4) || title '員工' from employee; -- 加上空格函數
select concat(ename,'is a ',title) '員工' from employee; -- better than ||

-- 兩種條件的判斷: if(condition, expr1, expr2)
select empno, ename, salary,
	salary*if(salary >=50000,2,1.5) as 'bonus'
from employee;

-- 千位符號表示法
select empno, ename, format(salary, '#,###') as 'salary',
	salary*if(salary >=50000,2,1.5) as 'bonus'
from employee;

-- 多種條件的判斷: case...when...else
select empno, ename, salary,
	case
		when salary between 70000 and 100000 then  'A'
        when salary between 50000 and 69999 then  'B'
        when salary between 30000 and 49999 then  'C'
        else  'D'
	end as 'Grade'
from employee;

SET sql_mode='PIPES_AS_CONCAT';
SET sql_mode='';
-- 擷取部分字串: substring(expr,start int, lenth int)
select title || space(2) || substring(ename,1,1) as '員工' from employee;
select title || space(2) || substring(ename,2,2) as '員工' from employee;

-- 轉換資料型態
select empno || space(1) || ename '員工' from employee; -- MySQL 可以不用轉換就串接
select comcat(empno,' ',ename) '員工' from employee;
-- convert(expr, type[(length)])
select convert(empno,char(4)) || space(1)|| ename '員工' from employee;
-- cast(expr as type[(length)])
select cast(empno as char(4)) || space(1)|| ename '員工' from employee;

-- 日期的運算
select ename, hiredate from employee;
select ename, hiredate + interval 5 day as '到職後五天' from employee;
-- sysdate()
select sysdate(); -- 正在執行的日期與時間
select sysdate(), sleep(2),sysdate(); -- sleep(2) 休眠兩秒
-- now()
select now(); -- 開始的日期與時間
select now(), sleep(2), now(); -- 休眠兩秒,開始的時間依舊不會變

-- cur___()
select current_timestamp(); -- 顯示日期+時間

select curdate(); -- 只顯示日期
select current_date();

select curtime(); -- 只顯示時間
select current_time();


-- 時間的加法
select now() + interval 2 month as '日期';
select adddate(now(), interval 2 month) as '日期';
-- 時間的減法
select now() - interval 2 month as '日期';
select subdate(now(), interval 2 month) as '日期';

-- 計算每位員工工作的年資(月資): datediff(expr1, expr2)
select empno, ename, datediff(sysdate(),hiredate) div 365 'year' from employee;
select empno, ename, datediff(sysdate(),hiredate) div 365 as 'year',
(datediff(sysdate(),hiredate) % 365)div 30 as 'month' from employee;

-- round的練習
select empno, ename, datediff(sysdate(),hiredate) div 365 'year1' from employee;
select empno, ename, 
round(datediff(sysdate(),hiredate)/365,1) as 'year' 
from employee;

-- 顯示每位員工的到職日期
select empno, ename, hiredate, year(hiredate)'Year',month(hiredate)'Month', day(hiredate)'Day' from employee;

