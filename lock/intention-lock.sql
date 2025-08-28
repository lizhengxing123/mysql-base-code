# 意向锁

-- 意向共享锁(IS)：与表锁共享锁（read）兼容，与表锁排他锁（write）互斥
-- 意向排他锁(IX)：与表锁共享锁（read）和表锁排他锁（write）都互斥。意向锁之间不互斥

-- 查看意向锁
select object_schema, object_name, lock_type, lock_mode, lock_data
from performance_schema.data_locks;
