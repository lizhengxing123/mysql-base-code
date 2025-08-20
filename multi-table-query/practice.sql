create table if not exists salary_grade
(
    id           int primary key auto_increment,
    salary_grade int,
    min_salary   int,
    max_salary   int
) comment '薪资等级表';

insert into salary_grade(salary_grade, min_salary, max_salary)
values (1, 0, 3000),
       (2, 3001, 5000),
       (3, 5001, 8000),
       (4, 8001, 10000),
       (5, 10001, 15000),
       (6, 15001, 20000),
       (7, 20001, 25000),
       (8, 25001, 30000);


alter table employee
    add salary int comment '薪资';

insert into employee (id, work_no, name, age, sex, id_card, entry_date, work_address, dept_id, parent_id, salary)
values (8, '00008', '郭靖', 38, '男', '123561889012345678', '2023-01-01', '北京', 1, null, 23000),
       (9, '00009', '黄蓉', 35, '女', '123561889012345679', '2023-01-01', '上海', 1, 8, 20000),
       (10, '00010', '穆念慈', 32, '女', '134561889012345680', '2023-01-01', '广州', 1, 8, 18000),
       (11, '00011', '梅超风', 30, '男', '134561889012345681', '2023-01-01', '深圳', 1, 8, 15000),
       (12, '00012', '乔峰', 36, '男', '124561889012345682', '2023-01-01', '北京', 1, 8, 12000),
       (13, '00013', '段誉', 34, '男', '124561889012345683', '2023-01-01', '成都', 1, 8, 10000),
       (14, '00014', '王语嫣', 32, '女', '134561889012345684', '2023-01-01', '北京', 1, 8, 8000),
       (15, '00015', '东方不败', 30, '男', '234561889012345685', '2023-01-01', '先', 1, 8, 6000);


-- 查询员工姓名、年龄、部门信息
-- 隐式内连接
select e.name, e.age, d.name
from employee e,
     dept d
where e.dept_id = d.id;

-- 查询员工姓名、年龄小于30、部门信息
-- 显示内连接
select e.name, e.age, d.name
from employee e
         inner join dept d on e.dept_id = d.id
where e.age < 30;

-- 查询部门拥有的员工数量
select d.name, count(e.id) as '员工数量'
from employee e
         inner join dept d on e.dept_id = d.id
group by d.name;

-- 查询员工姓名、年龄大于30、部门信息
-- 左外连接
select e.name, e.age, d.name
from employee e
         left join dept d on e.dept_id = d.id
where e.age > 30;

-- 查询员工薪资等级
select e.name, e.salary, s.salary_grade
from employee e
         left join salary_grade s on e.salary between s.min_salary and s.max_salary;

-- 查询研发部员工薪资等级，展示部门名称
select e.name, e.salary, s.salary_grade, d.name
from employee e
         left join salary_grade s on e.salary between s.min_salary and s.max_salary
         left join dept d on e.dept_id = d.id
where d.name = '研发部';

-- 查询每个部门的平均工资
select d.name, avg(e.salary) as '平均工资', max(e.salary) as '最高工资', min(e.salary) as '最低工资'
from dept d
         left join employee e on d.id = e.dept_id
group by d.name;

-- 查询研发部员工的平均工资
select d.name, avg(e.salary) as '平均工资'
from employee e
         left join dept d on e.dept_id = d.id
where d.name = '研发部';

-- 查询比李四工资高的员工
select e.name, e.salary
from employee e
where e.salary > (select e.salary from employee e where e.name = '李四');

-- 查询比平均薪资高的员工
select e.name, e.salary
from employee e
where e.salary > (select avg(e.salary) from employee e);

-- 查询比本部门薪资低的员工，及其部门信息和平均薪资
-- 查询比本部门薪资低的员工，及其部门信息和平均薪资
select e.name, e.salary, d.name, avg_sal.avg_salary as '平均薪资'
from employee e
         -- 查询部门信息
         left join dept d on e.dept_id = d.id
-- 使用关联子查询计算部门平均薪资，避免别名冲突
         left join (select dept_id, avg(salary) as avg_salary from employee group by dept_id) as avg_sal
                   on e.dept_id = avg_sal.dept_id
where e.salary < avg_sal.avg_salary;
-- 直接引用已计算的平均薪资

-- 统计部门员工数量
select d.id, d.name, (select count(e.id) from employee e where e.dept_id = d.id) as '员工数量'
from dept d;