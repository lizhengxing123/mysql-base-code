use mysql;

-- 查看用户
select *
from user;

-- 创建本地用户zhangsan
create user 'zhangsan'@'localhost' identified by '123456';

-- 修改密码
alter user 'zhangsan'@'localhost' identified with mysql_with_password by '1234';

-- 删除用户
drop user 'zhangsan'@'localhost';

-- 查询用户权限
show grants for 'zhangsan'@'localhost';

-- 授予所有权限
grant all privileges on db1.* to 'zhangsan'@'localhost';

-- 撤销权限
revoke all privileges on db1.* from 'zhangsan'@'localhost';
