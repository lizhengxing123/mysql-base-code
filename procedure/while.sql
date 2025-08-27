# while 循环
-- 满足条件继续循环

-- 语法
-- while 条件 do
--  循环体;
-- end while;

create procedure p8(in n int, out result int)
begin
    set result := 0;
    while n > 0 do
        set result := result + n;
        set n := n - 1;
    end while;
end;

drop procedure p8;

call p8(100, @result);
select @result;
