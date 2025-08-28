# innodb 引擎架构
-- 分为内存架构和磁盘架构

-- 1、内存架构
-- 1.1 缓冲池（Buffer Pool）
-- 缓冲池是主内存中的一个区域，里面可以缓存磁盘上经常操作的真实数据
-- 在执行增删改查操作时，会先操作缓冲池中的数据，如果缓冲池没有找到，才会从磁盘中加载并缓存
-- 然后再以一定的频率刷新到磁盘中，从而减少磁盘IO，加快处理速度
-- 缓冲池以页（Page）为单位，采用链表数据结构来管理页，根据状态，可以分为三类：
-- free page：空闲页，未被使用
-- clean page：干净页，被使用过，但是数据没有被修改
-- dirty page：脏页，被使用过，数据被修改，与磁盘中数据不一致

-- 1.2 更改缓冲区（Change Buffer）
-- 针对非唯一二级索引页
-- 在执行DML语句时，如果数据没有在缓冲池中，
-- 不会直接操作磁盘，而是先将数据变更存储到更改缓冲区中
-- 在未来数据被读取时，将数据合并恢复到缓冲池中
-- 再将合并后的数据刷新到磁盘中
-- 存在的意义：
-- 非唯一二级索引的增删改都是相对随机的，增加这个缓冲区可以有效的减少磁盘IO

-- 1.3 自适应哈希索引（Adaptive Hash Index）
-- 用于优化对缓冲池中的数据的查询
-- innodb 会监控表上各索引页的查询，如果观察到hash索引可以提升速度，则建立hash索引
-- 自适应哈希索引是系统根据情况自动完成的，不需要手动创建
show variables like '%hash_index%';

-- 1.4 日志缓冲区（Log Buffer）
-- 用来保存要写入到磁盘中的日志信息（redo log、undo log）
-- 默认大小为16M，会定期刷新到磁盘中
-- 如果需要更新、插入和删除许多行的事务，增加日志缓冲区的大小可以提高性能，减少磁盘IO
-- 日志缓冲区大小
show variables like 'innodb_log_buffer_size';
-- 日志刷新到磁盘时机
show variables like 'innodb_flush_log_at_trx_commit';
-- 1：每次事务提交时，都将日志写入并刷新到磁盘中
-- 0：每秒将日志写入并刷新到磁盘一次
-- 2：每次事务提交后，写入日志，并每秒刷新到磁盘一次

-- 2、磁盘架构
-- 2.1 系统表空间（System Tablespace）
-- 是更改缓冲区的存储区域
show variables like 'innodb_data_file_path';

-- 2.2 表空间（File-Per-Table Tablespaces）
-- 每个表都有一个表空间，用来存储表的数据和索引
show variables like 'innodb_file_per_table';

-- 2.3 通用表空间（General Tablespaces）
-- 需要通过 create tablespace 语法创建通用表空间
-- 在创建表时，可以指定该表空间
create tablespace my_tablespace add datafile 'my_tablespace.ibd' engine = 'innodb';
create table my_table (
    id int primary key auto_increment,
    name varchar(20),
    age int
) tablespace my_tablespace;

-- 2.4 撤销表空间（Undo Tablespaces）
-- Mysql 实例在初始化时，会自动创建两个撤销表空间
-- 初始大小为16M，用于存储 undo log
show variables like 'innodb_undo_tablespaces';

-- 2.5 临时表空间（Temporary Tablespaces）
-- 用于存储临时表的数据和索引
-- 临时表空间的大小是动态的，根据需要自动扩展
show variables like 'innodb_temp_data_file_path';

-- 2.6 双写缓冲区（Double Write Buffer）
-- innodb 引擎在将缓冲池中的数据刷新到磁盘前，会先写入到双写缓冲区当中，便于系统异常时恢复数据
-- 双写缓冲区的大小为16M，默认开启
show variables like 'innodb_doublewrite';

-- 2.7 重做日志（Redo Log）
-- 重做日志是用来实现事务的持久性
-- 重做日志由两部分组成：
-- 重做日志缓冲区（Redo Log Buffer）：在内存中
-- 重做日志文件（Redo Log File）：在磁盘中
-- 当事务提交之后，会把所有修改信息都存到该日志文件中
-- 用于在刷新脏页到磁盘，发生错误时，恢复数据

-- 3、后台线程
-- 在合适的时机，将缓冲池中的数据刷新到磁盘中

-- 3.1 Master Thread
-- 核心后台线程，负责调度其他线程，还负责将缓冲池中的数据异步刷新到磁盘中，保持数据的一致性
-- 还包括脏页的刷新、合并插入缓存、undo页的回收

-- 3.2 IO Thread
-- 使用 AIO 异步 IO 线程来处理 IO 请求，提高数据库的性能
-- 主要负责这些 IO 请求的回调：
-- Read Thread：默认4个，负责读操作
-- Write Thread：默认4个，负责写操作
-- Log Thread：默认1个，负责将日志缓冲区刷新到磁盘
-- Insert Buffer Thread：默认1个，负责将写缓冲区内容刷新到磁盘
show engine innodb status;

-- 3.3 Purge Thread
-- 负责回收已提交的事务的 undo 日志
-- 在事务提交之后，undo log 可能就不用了，就用它来回收

-- 3.4 Page Cleaner Thread
-- 协助 Master Thread 刷新脏页到磁盘的线程
-- 减轻 Master Thread 的压力，减少阻塞
