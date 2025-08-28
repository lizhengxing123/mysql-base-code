# 锁

-- 1、按照锁的粒度来分
-- 1.1 全局锁：锁定数据库中的所有表
    -- 全局锁的使用场景：备份数据库，保证数据的一致性和完整性
-- 1.2 表级锁：锁定当前整张表
-- 1.3 行级锁：锁定当前行数据

-- 全局锁使用
-- 加锁
flush tables with read lock;
-- 备份
-- mysqldump -u root -p1234 -h 127.0.0.1 -P 3306 db1 > db1.sql
-- 在备份时，可以加上 --single-transaction 选项来完成不加锁的一致性数据备份
-- mysqldump --single-transaction -u root -p1234 -h 127.0.0.1 -P 3306 db1 > db1.sql
-- 解锁
unlock tables;
