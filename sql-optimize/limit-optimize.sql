# 分页优化

-- 在大数据量查询时，会导致查询效率低
-- select * from tb_user limit 1000000, 10;

-- 优化方案：覆盖索引+子查询
-- 1、先查询出主键 id 列表
select id from tb_user limit 1000000, 10;
-- 2、根据主键 id 列表查询数据
-- This version of MySQL doesn't yet support 'LIMIT & IN/ALL/ANY/SOME subquery'
-- select * from tb_user where id in (select id from tb_user limit 1000000, 10);
-- 修改：多表联查
select u.* from tb_user u, (select id from tb_user limit 1000000, 10) a where u.id = a.id;
