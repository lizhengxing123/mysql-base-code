# 元数据锁
-- MDL 加锁过程是系统自动完成的，不需要用户手动操作
-- 当对一张表进行增删改查操作时，会自动加 MDL 读锁（共享）
-- 当对一张表进行表结构变更时，会自动加 MDL 写锁（排他）

-- 查看元数据锁
select object_type, object_schema, object_name, lock_type, lock_duration, lock_status
from performance_schema.metadata_locks;
