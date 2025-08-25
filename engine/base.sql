-- 查看建表默认引擎
-- ENGINE=InnoDB
show create table employee;

-- 查看当前数据库支持的引擎
show engines;
-- innodb 引擎：默认引擎
    -- 支持事务
    -- 支持外键
    -- 支持行级锁
    -- 支持表级锁
    -- 存储文件：都在.idb 表空间文件中，包括表结构、索引、数据
        -- 可以使用 idb2sdi 查看表结构信息
        -- 表空间可以分为：段、区（1M，最多64页）、页（最小操作单元，16k）、行

-- myisam 引擎
    -- 不支持事务
    -- 不支持外键
    -- 不支持行级锁
    -- 支持表级锁
    -- 访问速度快
    -- 存储文件：
        -- 表数据文件：.MYD
        -- 表索引文件：.MYI
        -- 表结构文件：.sdi

-- memory 引擎：只能作临时表或缓存
    -- 不支持事务
    -- 不支持外键
    -- 不支持表级锁
    -- 支持hash索引
    -- 访问速度快
    -- 存储文件：
        -- 表结构文件：.sdi



-- 查看表的存储引擎
show table status like 'employee';

-- 创建表的时候指定存储引擎
create table my_myisam (
    id int primary key,
    name varchar(20),
    age int
) engine = MyISAM;


create table my_memory (
    id int primary key,
    name varchar(20),
    age int
) engine = Memory;
