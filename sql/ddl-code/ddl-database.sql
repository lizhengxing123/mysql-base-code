-- 显示所有数据库
show databases;

-- 创建数据库
create database if not exists db1;

-- 使用数据库
use db1;

-- 查看当前使用的数据库
select database();

-- 删除数据库
drop database if exists db1;
