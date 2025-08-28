# 重做日志
-- redo log，记录的是事务提交时数据页的物理修改，用来实现事务的持久性
-- 重做日志由两部分组成：
-- 重做日志缓冲区（Redo Log Buffer）：在内存中
-- 重做日志文件（Redo Log File）：在磁盘中
-- 当事务提交之后，会把所有修改信息都存到该日志文件中
-- 用于在刷新脏页到磁盘，发生错误时，恢复数据

# 回滚日志
-- undo log，记录数据被修改前的信息，作用有两个：提供回滚和MVCC（多版本并发控制）
-- 事务的原子性依赖于undo log
-- undo log 是逻辑日志，redo log 是物理日志
-- undo log 记录的都是相反的信息，比如 insert 操作，会记录 delete 操作，update 操作，会记录 update 前的数据
-- 当执行 rollback 时，会根据 undo log 中的信息，将数据恢复到事务开始之前的状态
-- undo log销毁：undo log在事务执行时产生，事务提交后，并不会立即销毁，因为这些日志可能还会用于MVCC
-- undo log存储：undo log采用段（segment）的方式进行管理和记录，存放在回滚段（rollback segment）中，内部包含1024个undo log segment
