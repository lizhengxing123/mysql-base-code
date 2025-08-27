# 变量

-- 1、系统变量
-- 分为全局变量（global）和会话变量（session）
-- 查看
show global variables;
show global variables where Value in ('on', 1);
show global variables like '%char%';
select @@global.profiling;
-- 设置
set global profiling = 1;
set @@global.profiling = 1;

-- 2、用户自定义变量
-- 使用 @变量名 即可
-- 赋值
set @a = 1;
set @b := 2 + @a, @c := @a + @b;

select @d := 'ddd';
select count(*) into @count from tb_user;

-- 查看
select @a, @b, @c, @d, @count;


-- 3、局部变量
-- 只能在存储过程或函数中使用，使用 declare 关键字声明
create procedure p2()
begin
    declare user_count int default 0;
    -- user_count := 10;
    select count(*) into user_count from tb_user;
    select user_count;
end;

call p2();
