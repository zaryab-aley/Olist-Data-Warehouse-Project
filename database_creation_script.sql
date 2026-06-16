use master;
go

if exists (select 1 from sys.databases where name='olist_data_warehouse')
begin
	alter database olist_data_warehouse set single_user with rollback immediate
	drop database olist_data_warehouse;
end;
go

create database olist_data_warehouse;

use olist_data_warehouse;

create schema bronze;
create schema silver;
create schema gold;