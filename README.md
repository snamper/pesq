duothink
==============
 thinkphp5.0.3 正式版证书开发精简后台 

### 安装说明
 sql文件位置  
 ```
 public/backup/duothink.sql
 ```
 请参照/application/database.php文件新建数据库填写自己对应的账号密码  
 安装请检查更目录runtime下是否有文件，如果有，请清除缓存和日志文件，以免报错！
 
### 入口文件移动说明
  默认官方public/index.php入口文件，如果有虚拟主机环境无法定义请自行移动入口文件到根目录  
  同时修改 application/config.php 133行 模板内容替换    
    
 ```
  // 视图输出字符串内容替换
     'view_replace_str'       => [
         '__c__' =>  '/static/css',
         '__i__' =>  '/static/i',
         '__j__' =>  '/static/js',
     ],
 ```
 同时移动public目录中favicon.icon、reboot.txt、router.php、.htaccess、404.html
 
 ### 关于微信公众号sdk  
  微信公众平台扩展
  ```
    extend/com/wechat
  ```
  
  ### 其他说明  
  
   演示网址 <a href="http://www.pe666.net">www.pe666.net</a>  
   问题反馈建议：QQ：763093576 或是直接讨论板块发表讨论