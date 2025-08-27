# repeat 循环
-- 满足条件退出循环

-- 语法
-- repeat 循环体
-- until 条件
-- end repeat;

create procedure p9(in n int, out result int)
begin
    set result := 0;

    repeat
        set result := result + n;
        set n := n - 1;
    until n <= 0 end repeat;
end;

call p9(10000, @result);
select @result;
