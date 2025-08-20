-- 联合查询
-- 联合查询的列数必须相同
-- 联合查询的列数据类型必须相同

-- 1、union all
-- 合并查询结果，包含重复数据
select *
from employee
where sex = '男'
union all
select *
from employee
where work_address in ('北京', '广州');

-- 2、union
-- 合并查询结果，不包含重复数据
select *
from employee
where sex = '男'
union
select *
from employee
where work_address in ('北京', '广州');
