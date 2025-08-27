# 存储过程

-- 1、创建存储过程
-- 语法：
-- create procedure 存储过程名([参数列表])
-- begin
--     存储过程体
-- end;

create procedure p1()
begin
    select count(*) from tb_user;
end;

-- 2、调用存储过程
-- 语法：
-- call 存储过程名([参数列表]);
call p1();

-- 3、查看存储过程
-- 查看某个存储过程定义
show create procedure p1;

-- 查看所有存储过程
select * from information_schema.routines
where routine_schema = 'db1'
  and routine_type = 'PROCEDURE';

-- 4、删除存储过程
-- 语法：
-- drop procedure 存储过程名;
drop procedure p1;
