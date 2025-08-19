-- 查询所有字段数据
select *
from employee;

-- 查询指定字段数据
select work_no '员工号', name, age, sex, work_address as '工作地址'
from employee;

-- 去重
select distinct work_address '工作地址'
from employee;