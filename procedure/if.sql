# 详细使用

-- 1、if 语句
-- 语法
-- if 条件 then
--     语句;
-- elseif 条件 then 可以有多个 elseif 分支
--     语句;
-- else
--     语句;
-- end if;

create procedure p3()
begin
    declare user_count int default 0;
    declare count_text varchar(20) default '';

    select count(*) into user_count from tb_user;

    if user_count > 0 then
        set count_text := '用户数量大于 0';
    elseif user_count = 0 then
        set count_text := '用户数量等于 0';
    else
        set count_text := '用户数量小于 0';
    end if;

    select count_text;
end;

call p3();

drop procedure p3;

