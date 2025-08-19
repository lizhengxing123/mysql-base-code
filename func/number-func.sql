-- 数值函数

-- 1、ceil
select ceil(1.1);
-- 2

-- 2、floor
select floor(1.1);
-- 1

-- 3、mod
select mod(10, 3);
-- 1

-- 4、rand：随机数，范围为[0, 1)
select rand();
-- 0.5519121620356219

-- 5、round：四舍五入，第二个参数为保留几位小数
select round(1.109, 2);
-- 1.11

-- 应用
-- 生成随机6位数，范围为[100000, 999999]
-- 方法一：FLOOR(min + RAND() * (max - min + 1))
select floor(100000 + rand() * (999999 - 100000 + 1));
-- 方法二：使用rpad
select rpad(floor(rand() * 1000000), 6, '0');
