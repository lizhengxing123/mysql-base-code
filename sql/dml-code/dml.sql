-- 查询表中所有数据
select *
from employee;

-- 插入数据
insert into employee (id, work_no, name, age, sex, id_card, entry_date)
values (1, '001', '张三', 18, '男', '123456789012345678', '2020-01-01');

-- 批量插入数据
insert into employee (id, work_no, name, age, sex, id_card, entry_date)
values (2, '002', '李四', 20, '女', '123456789012345670', '2020-01-02'),
       (3, '003', '王五', 22, '男', '123456789012345671', '2020-01-03');

insert into employee
values (1, '001', '张三', 18, '男', '123456789012345678', '2020-01-01', '北京'),
       (2, '002', '李四', 20, '女', '123456789012345670', '2020-01-02', '上海'),
       (3, '003', '王五', 22, '男', '123456789012345671', '2020-01-03', '广州'),
       (4, '004', '赵六', 24, '女', '123456789012345672', '2020-01-04', '深圳'),
       (5, '005', '王二', 26, '男', '123456789012345673', '2020-01-05', '成都'),
       (6, '006', '王二', 28, '女', '123456789012345674', '2020-01-06', '北京');


-- 修改数据
update employee
set name = '金庸'
where id = 1;

update employee
set name = '周芷若',
    sex  = '女',
    age  = 18
where id = 3;

-- 修改所有数据
update employee
set entry_date = '2025-01-01';

-- 删除某一条数据
delete
from employee
where id = 2;

-- 删除某一个字段数据
update employee
set work_no=null;

-- 删除所有数据
-- 1. truncate table employee;
delete from employee;