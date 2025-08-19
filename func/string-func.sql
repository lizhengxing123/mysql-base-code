-- 字符串函数

-- 1、concat
select concat('a', 'b', 'c');
-- abc

-- 2、lower
select lower('ABC');
-- abc

-- 3、upper
select upper('abc');
-- ABC

-- 4、lpad
select lpad('123', 5, '0');
-- 00123

-- 5、rpad
select rpad('123', 5, '0');
-- 12300

-- 6、trim
select trim('  a b c  ');
-- a b c

-- 7、substring：索引从1开始
select substring('123456', 1, 3);
-- 123


-- 应用

-- 1、将员工工号补足五位，不满补0
update employee
set work_no=lpad(work_no, 5, '0');