# 存储函数
-- 存储函数是有返回值的存储过程，参数只能是in类型

-- 语法
-- create function 函数名(参数列表) returns 返回类型
-- begin
--     函数体
-- end;

create function fn1(n int)
returns int deterministic
begin
    declare result int default 0;
    while n > 0 do
        set result := result + n;
        set n := n - 1;
    end while;
    return result;
end;

-- 调用函数
select fn1(10);
