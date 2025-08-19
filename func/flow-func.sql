-- 流程控制函数

-- 1、if
-- 语法：if(条件, 表达式1, 表达式2)
select if(1 > 2, 'true', 'false');

-- 2、ifnull
-- 语法：ifnull(表达式1, 表达式2)
-- 说明：如果表达式1为null，返回表达式2，否则返回表达式1
select ifnull(null, 'default'); -- default
select ifnull('', 'default'); -- ''
select ifnull('a', 'default');
-- a

-- 3、case
-- 语法：case 表达式 when 条件1 then 结果1 when 条件2 then 结果2 else 结果3 end
select name,
       case work_address
           when '北京' then '一线城市'
           when '上海' then '一线城市'
           else '其他城市'
           end as city_type
from employee;

-- 计算员工年龄，并展示为青年中年老年
select name,
       case
           when ceil(datediff(curdate(), date(substring(id_card, 7, 8))) / 365) < 25 then '青年'
           when ceil(datediff(curdate(), date(substring(id_card, 7, 8))) / 365) < 40 then '中年'
           else '老年'
           end as age_type
from employee
order by ceil(datediff(curdate(), date(substring(id_card, 7, 8))) / 365) desc;

-- 使用子查询进行代码优化
select name,
       case
           when age < 25 then '青年'
           when age < 40 then '中年'
           else '老年'
           end as age_group
from (
         -- 在子查询中计算年龄，主查询直接使用别名
         select name,
                ceil(datediff(curdate(), date(substring(id_card, 7, 8))) / 365) as age
         from employee) as emp_age
order by age desc;
-- 直接使用年龄别名排序

-- 使用更优解法计算年龄
select name,
       case
           when age < 18 then '青年'
           when age < 40 then '中年'
           else '老年'
           end as age_group
from (
         -- 优化：使用TIMESTAMPDIFF直接计算年份差
         select name,
                TIMESTAMPDIFF(
                        YEAR,
                        date(substring(id_card, 7, 8)),
                        curdate()
                ) as age
         from employee) as emp_age
order by age asc;