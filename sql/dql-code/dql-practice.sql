-- 1、查询年龄为18、21、24岁的女性员工
select *
from employee
where age in (18, 21, 24)
  and sex = '女';

-- 2、查询性别为男、年龄在20-25岁之间，名字为两个字的员工
select *
from employee
where sex = '男'
  and age between 20 and 25
  and name like '__';

-- 3、统计年龄大于20岁的男女数量
select sex, count(*) as num
from employee
where age > 20
group by sex;

-- 4、年龄大于18，入职日期降序，年龄升序
select *
from employee
where age > 18
order by entry_date desc,
         age;


-- 5、性别男，年龄大于18，前5个，年龄升序，入职时间降序
select *
from employee
where sex = '男'
  and age > 18
order by age,
         entry_date desc
limit 5;


-- 执行顺序
-- 1、from
-- 2、where
-- 3、group by
-- 4、having
-- 5、select
-- 6、order by
-- 7、limit
