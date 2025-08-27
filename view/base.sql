# 视图

-- 1、创建视图
create or replace view user_view_1 as
select id, name
from tb_user
where id <= 10;

-- 1.1 查询视图创建语句
show create view user_view_1;

-- 2、查询视图
select *
from user_view_1;

-- 3、修改视图
create or replace view user_view_1 as
select id, name, age
from tb_user
where id <= 5;

alter view user_view_1 as
    select id, name, age, gender
    from tb_user
    where id <= 5;

-- 4、删除视图
drop view user_view_1;

# 检查选项

-- 1、with cascade check option
-- 级联检查选项，会检查自己的条件及其依赖的所有视图的条件
create or replace view user_view_1 as
select id, name
from tb_user
where id <= 20;

create or replace view user_view_2 as
select id, name
from user_view_1
where id >= 10
with cascaded check option;

-- 插入成功，满足 <= 20 且 >= 10
insert into user_view_2
values (11, '张三');
-- 插入失败，不满足 <= 20
insert into user_view_2
values (21, '张三');


-- 2、with local check option
-- 本地检查选项，会检查自己的条件，如果依赖的视图没有检查选项，就不会检查
create or replace view user_view_1 as
select id, name
from tb_user
where id <= 20;

create or replace view user_view_2 as
select id, name
from user_view_1
where id >= 10
with local check option;

-- 插入成功，满足 >= 10
insert into user_view_2
values (11, '张三');
-- 插入成功，满足 >= 10，依赖的视图 user_view_1 没有检查选项，所以不会检查
insert into user_view_2
values (21, '张三');


# 视图更新的条件：视图中的行和基表中的行必须是一对一的关系

-- 1、不能使用聚合函数或窗口函数
-- 2、不能使用 distinct
-- 3、不能使用 group by
-- 4、不能使用 having
-- 5、不能使用 union
-- 6、不能使用 union all
-- 7、不能使用子查询


# 作用

-- 1、简单：简化数据
-- 2、安全：可以限制用户只能查询视图，不能直接查询基表
-- 3、数据独立：视图可以隐藏基表的复杂性，只暴露必要的信息
-- 4、多表查询：视图可以将多个表的数据组合起来，形成一个新的表

-- 例1：隐藏用户表的手机号和email信息
create or replace view user_view_1 as
select id, name, age, gender, profession, status, create_time
from tb_user;

select *
from user_view_1;

-- 例2：对于多表查询，可以建立一个视图，简化操作
create or replace view sc_view_1 as
select s.id student_id, s.name student_name, c.name course_name
from tb_student s,
     tb_course c,
     tb_student_course sc
where s.id = sc.student_id
  and c.id = sc.course_id;

