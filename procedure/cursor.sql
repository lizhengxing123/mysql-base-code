# 游标

-- 1、声明游标
-- declare 游标名 cursor for 查询语句;
-- 2、打开游标
-- open 游标名;
-- 3、获取游标数据
-- fetch 游标名 into 变量名;
-- 4、关闭游标
-- close 游标名;

# 条件处理程序
-- 1、声明条件处理程序
-- declare [exit | continue] handler for 条件类型 处理语句;
-- 条件类型有：
    -- 1.1、sqlstate 状态码：如'02000'
    -- 1.2、sqlwarning：所有以01开头的状态码的简写
    -- 1.3、not found：所有以02开头的状态码的简写
    -- 1.4、sqlexception：所有其他状态码
-- 2、删除条件处理程序
-- drop handler 条件处理程序名;

create procedure p11(in user_age int)
begin
    declare user_name varchar(20);
    declare user_profession varchar(20);
    declare cur cursor for select name, profession from tb_user where age < user_age;
    -- 条件处理语句：当游标没有数据时，退出循环，关闭游标
    -- declare exit handler for sqlstate '02000' close cur;
    declare exit handler for not found close cur;
    -- 创建表
    drop table if exists tb_user_1;
    create table if not exists tb_user_1 (
        id int primary key auto_increment,
        name varchar(20),
        profession varchar(20)
    );
    -- 插入数据
    open cur;
    while true do
        fetch cur into user_name, user_profession;
        insert into tb_user_1 (name, profession) values (user_name, user_profession);
    end while;
    close cur;
end;

drop procedure if exists p11;

call p11(25);
