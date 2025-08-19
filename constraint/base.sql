-- 约束

-- 1、NOT NULL:非空约束
-- 限制该字段的数据不能为 null

-- 2、UNIQUE:唯一约束
-- 限制该字段所有数据都是唯一的，不能重复

-- 3、PRIMARY KEY:主键约束
-- 主键是一行数据的唯一标识，要求非空且唯一
-- 主键约束会自动添加唯一约束

-- 4、DEFAULT:默认约束
-- 限制该字段的数据有默认值

-- 5、CHECK:检查约束
-- 限制该字段的数据必须满足指定的条件

-- 6、FOREIGN KEY:外键约束
-- 限制该字段的数据必须来自于引用表的主键值


create table person
(
    id     int primary key auto_increment comment '人员主键ID',
    name   varchar(20) not null unique comment '人员姓名',
    age    int check (age >= 0 and age <= 120) comment '人员年龄',
    status char(1) default '1' comment '人员状态',
    gender char(1) comment '人员性别'
) comment '人员信息表';

insert into person (name, age, status, gender)
values ('张三', 18, '1', '男'),
       ('李四', 20, '1', '女'),
       ('王五', 22, '1', '男');

update person
set status = '0'
where id = 5;
