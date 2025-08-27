# loop 循环

-- 语法
-- loop 循环体
-- end loop;

-- 循环体中可以使用 leave 语句退出循环
-- 循环体中可以使用 iterate 语句跳过当前循环，进入下次循环


create procedure p10(in n int, out result int)
begin
    set result := 0;
    loop1:
    loop
        if n <= 0 then
            leave loop1;
        end if;

        if n % 2 = 0 then
            set n := n - 1;
            iterate loop1;
        end if;

        set result := result + n;
        set n := n - 1;
    end loop loop1;
end;

call p10(10, @result);
select @result;
