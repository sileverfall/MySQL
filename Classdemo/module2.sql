-- 顯示所有資料庫
show databases;

 -- database=schema
 create database if not exists db01;
 create database db02;
 
 -- character字元集 collate 校對
 show char set;
 show collation;
 show collation like 'big5';
 
 -- 修改
 alter database db02
 char set utf16
 collate ucs2_bin;
 -- 刪除
 drop database if exists db02;
 -- 切換
 use db01;
 
 
 
 