# 存储过程参数

-- 1、类型
-- 1.1、in：输入参数，调用时必须传递值，默认
-- 1.2、out：输出参数，调用时可以不传递值，过程执行完后，会将值返回
-- 1.3、inout：输入输出参数，调用时必须传递值，过程执行完后，会将值返回

-- 2、语法
-- create procedure 过程名([in|out|inout] 参数名 数据类型)
-- begin
--     语句;
-- end;
create procedure p4(in score int, out result varchar(20))
begin
    if score >= 85 then
        set result := '优秀';
    elseif score >= 60 then
        set result := '及格';
    else
        set result := '不及格';
    end if;
end;

-- 自定义变量，接收返回的数据
call p4(85, @result);
-- 查看返回的数据
select @result;


create procedure p5(inout score int)
begin
    set score := score + 10;
end;
-- 调用
set @score := 80;
call p5(@score);
-- 查看返回的数据
select @score;
