-- 子查询

-- 1、标量子查询：子查询返回的结果是一个标量值
-- 常用操作符：=、>、<、>=、<=、<>
select *
from employee
where dept_id = (select id from dept where name = '销售部');

select *
from employee
where entry_date > (select entry_date from employee where name = '王二');


-- 2、列子查询：子查询返回的结果是一列值
-- 常用操作符：in、not in、any、some、all
select *
from employee
where dept_id in (select id from dept where name in ('销售部', '财务部'));

-- 比研发部员工年龄都大的
select *
from employee
-- where age > all
where age > some (select age from employee where dept_id = (select id from dept where name = '研发部'));


-- 3、行子查询：子查询返回的结果是一行值
-- 常用操作符：=、<>、in、not in
select *
from employee
where (sex, work_address) = (select sex, work_address
                             from employee
                             where name = '李四');

-- 4、表子查询：子查询返回的结果是一个表
select *
from employee
where (sex, work_address) in (select sex, work_address
                              from employee
                              where name in ('李四', '张三'));

select *
from (select *
      from employee
      where (sex, work_address) in (select sex, work_address
                                    from employee
                                    where name in ('李四', '张三'))) e
         left join dept d on d.id = e.dept_id;