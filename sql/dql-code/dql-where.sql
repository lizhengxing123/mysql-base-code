-- 基础运算符：>、<、=、<=、>=、!=
select *
from employee
where age > 20;

-- 不等于
select *
from employee
-- where age != 20;
where age <> 20;

-- is null
select *
from employee
where id_card is null;

-- is not null
select *
from employee
where id_card is not null;

-- 区间
select *
from employee
where age between 18 and 25;
-- where age >= 18 and age <= 25;
-- where age >= 18 && age <= 25;
-- where age not between 18 and 25;

-- 多个条件
select *
from employee
where age between 18 and 25
  and sex = '男';

-- 或
select *
from employee
where age between 18 and 25
  and (sex = '男' or sex = '女');

select *
from employee
where age between 18 and 25
  and sex in ('男', '女')
  and work_address not in ('北京', '上海')
  and id_card is not null;

-- 模糊查询
-- _ 匹配单个字符
select *
from employee
where name like '王_';

-- % 匹配多个字符
select *
from employee
where name like '王%';

