# MVCC 多版本并发控制
-- 全程 Multi Version Concurrency Control，指维护一个数据的多个版本，使得读写操作没有冲突
-- 快照读为 MYSQL 实现 MVCC 提供了一个非阻塞读的功能

# 基本概念
-- 1、当前读
-- 读取最新的数据，会加锁，防止其他事务修改
-- 比如
select * from tb_user where id = 12 lock in share mode;
select * from tb_user where id = 12 for update;
update tb_user set name = '张三' where id = 12;
insert into tb_user (id, name, age) values (13, '张三', 18);
delete from tb_user where id = 13;
-- 查看锁
select object_schema, object_name, lock_type, lock_mode, lock_data
from performance_schema.data_locks;
show tables like '%lock%';

-- 2、快照读
-- 简单的select语句就是快照读，读取的是记录数据的可见版本，有可能是历史数据
-- 不会加锁，是非阻塞读
-- Read committed：每次select，都会生成一个快照读
-- Repeatable read：开启事务后的第一个select语句才是快照读
-- Serializable：快照读会退化为当前读

# MVCC 的具体实现依赖于以下几个组件

-- 1、数据库记录中的三个隐藏字段
-- 1.1 DB_TRX_ID
    -- 最近修改事务 id，记录插入这条记录或最后一次修改该记录的事务ID
-- 1.2 DB_ROLL_PTR
    -- 回滚指针，指向这条记录的上个版本，用于配合 undo log，指向上个版本
-- 1.3 DB_ROW_ID
    -- 隐藏主键，如果表结构没有指定主键，将会生成该字段

-- 2、undo log 日志
-- undo log 版本链，记录了该记录的所有版本，每个版本都有一个 undo log 记录
-- 版本链数据访问规则，trx_id 表示当前记录对应的事务 id
-- 2.1 trx_id == creator_trx_id
    -- 如果成立，表示数据是当前事务更改的，所以可以访问到该版本

-- 2.2 trx_id < min_trx_id
    -- 如果成立，说明数据已经提交了，所以可以访问到该版本

-- 2.3 trx_id > max_trx_id
    -- 如果成立，说明该事务是在readView生成后才开启的，所以不可以访问到该版本

-- 2.4 min_trx_id <= trx_id <= max_trx_id 且 trx_id 不在 m_ids 列表中
    -- 如果成立，说明数据已经提交了，所以可以访问到该版本

-- 如果以上条件都不成立，顺着版本链继续寻找下一条数据，按照条件匹配，直到找到符合条件的版本，或者版本链结束

-- 3、readView
-- 读视图，是快照读提取数据的依据，记录并维护当前活跃事务的 id
-- 包含四个核心字段：
-- 3.1 m_ids
    -- 当前活跃事务 id 列表
-- 3.2 min_trx_id
    -- 最小活跃事务 id
-- 3.3 max_trx_id
    -- 预分配事务 id，当前最大事务 id+1（事务 id 是自增的）
-- 3.4 creator_trx_id
    -- readView 创建者的事务 id
