# 行锁（Record Lock）
-- 锁定单个行记录，防止其他事务修改当前行数据，在RC、RR隔离级别下都支持

-- 1、共享锁（X）
-- 共享锁与共享锁兼容，与排他锁互斥
-- 2、排他锁（S）
-- 排他锁与共享锁和排他锁都互斥

-- 查看行锁
select object_schema, object_name, lock_type, lock_mode, lock_data
from performance_schema.data_locks;