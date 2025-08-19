-- 聚合函数
-- 统计总数
select count(*)
from employee;

-- 最小值
select min(age)
from employee;

-- 最大值
select max(age)
from employee;

-- 平均值
select avg(age)
from employee;

-- 求和
select sum(age)
from employee
where sex = '男';


-- 分组
select sex, count(*)
from employee
group by sex;

select sex, avg(age)
from employee
group by sex;

-- 分组后筛选
select work_address, count(*) as adress_count
from employee
where sex = '男'
group by work_address
having adress_count > 1;
