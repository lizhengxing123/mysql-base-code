# case 语句

-- 1、值
create procedure p6(in sex int, out result varchar(20))
begin
    case sex
        when 1 then
            set result := '男';
        when 2 then
            set result := '女';
        else
            set result := '未知';
    end case;
end;

call p6(1, @result);
select @result;

-- 2、表达式
create procedure p7(in score int, out result varchar(20))
begin
    case
        when score >= 85 then
            set result := '优秀';
        when score >= 70 then
            set result := '及格';
        else
            set result := '不及格';
    end case;
end;

call p7(85, @result);
select @result;
