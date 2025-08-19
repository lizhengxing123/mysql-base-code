-- 排序
-- 升序，默认 asc
select *
from employee
order by age;

-- 降序
select *
from employee
order by age desc;

-- 多字段排序
select *
from employee
order by entry_date desc,
         age;
