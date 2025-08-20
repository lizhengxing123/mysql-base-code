-- 外连接

-- 1、左外连接：获取左表的所有信息，右表的匹配信息
-- 左外连接可以省略 outer 关键字
select e.name, d.*
from employee e
         left outer join dept d on e.dept_id = d.id;


-- 2、右外连接：获取右表的所有信息，左表的匹配信息
-- 右外连接可以省略 outer 关键字
select d.name as '部门名称', e.name as '员工姓名'
from employee e
         right outer join dept d on d.id = e.dept_id;
-- 右外连接可以改为左外连接，获取左表的所有信息，右表的匹配信息
select d.name as '部门名称', e.name as '员工姓名'
from dept d
         left outer join employee e on d.id = e.dept_id;
