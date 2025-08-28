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

# 事务的隔离界别
-- 1、读未提交（Read Uncommitted）
    -- 允许事务读取未提交的数据，会导致脏读
-- 2、读已提交（Read Committed）
    -- 允许事务读取已提交的数据，会导致不可重复读
-- 3、可重复读（Repeatable Read）：默认
    -- 允许事务读取已提交的数据，不会导致不可重复读，但是会导致幻读
    -- 幻读：在可重复读隔离级别下，事务在执行过程中，会对已存在的记录进行读取，但是在读取完成之后，其他事务插入了新的记录，导致读取到的记录数量发生了变化
    -- 解决幻读：使用 Next-Key Lock 锁
-- 4、串行化（Serializable）
    -- 允许事务读取已提交的数据，不会导致不可重复读，也不会导致幻读
    -- 串行化隔离级别下，事务会对所有数据进行加锁，会导致性能下降

# 事务的四大特性
-- 1、原子性（Atomicity）
    -- 事务是一个不可分割的工作单位，事务中的操作要么全部发生，要么全部不发生
-- 2、一致性（Consistency）
    -- 事务必须使数据库从一个一致性状态变换到另一个一致性状态
-- 3、隔离性（Isolation）
    -- 事务的隔离性是指一个事务的执行不能被其他事务干扰
-- 4、持久性（Durability）
    -- 事务一旦提交，其对数据库的改变就会永久保存，不能回滚
