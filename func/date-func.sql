-- 日期函数

-- 1、curdate：当前日期
select curdate();
-- 2025-08-19

-- 2、curtime：当前时间
select curtime();
-- 15:24:33

-- 3、now：当前日期时间
select now();
-- 2025-08-19 15:24:40

-- 4、year：获取年份
select year(now());
-- 2025

-- 5、month：获取月份
select month(now());
-- 8

-- 6、day：获取日期
select day(now());
-- 19

-- 7、date_add：日期增加
-- 日期增加，第二个参数为增加的天数
select date_add(now(), interval 1 day);
-- 2025-08-20 15:24:40

-- 8、datediff：日期差
-- 日期差，第二个参数为被减日期，第一个参数为减日期
select datediff('2025-08-20', curdate());
-- 1
select datediff('2025-08-10', curdate());
-- -9

-- 应用
-- 查询员工的入职天数，并按入职天数降序排列
select name, datediff(curdate(), entry_date) as work_days
from employee
order by work_days desc;
