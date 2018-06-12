-- 顯示所有資料庫
show databases;

-- database=schema
create database db01;
create schema db02;

show char set;
show collation;
show collation like 'big5%';

-- 修改資料庫
alter database db02
char set utf16
collate ucs2_bin;

-- 刪除資料庫
drop database if exists db02;

-- 切換資料庫
use db01;
