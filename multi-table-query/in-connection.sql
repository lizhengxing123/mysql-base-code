-- 内连接

-- 1、隐式内连接
select employee.name as '员工姓名', dept.name as '部门名称'
from employee,
     dept
where employee.dept_id = dept.id;

-- 2、显式内连接
-- 内连接可以省略inner关键字
select employee.name as '员工姓名', dept.name as '部门名称'
from employee
         inner join dept on employee.dept_id = dept.id;
