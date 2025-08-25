-- 开启事务
start transaction;

-- 查询张三余额
select salary from employee where name = '张三';

-- 张三转账1000元给李四
update employee set salary = salary - 1000 where name = '张三';

-- 李四接受转账1000元
update employee set salary = salary + 1000 where name = '李四';

-- 提交事务
commit;

-- 回滚事务
rollback;
