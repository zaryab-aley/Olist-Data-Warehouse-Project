create or alter procedure bronze.load_bronze as

begin
	declare @start_time datetime2, @end_time datetime2
	begin try
		print '================================'
		print 'Loading Bronze Layer'
		print '================================' 

	set @start_time = getdate()

		truncate table bronze.customers_dataset;
		bulk insert bronze.customers_dataset
		from 'C:\Users\ZARYAB\Desktop\olist_data\olist_customers_dataset.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			rowterminator='0x0a',
			tablock
		);

		truncate table bronze.geolocation_dataset;
		bulk insert bronze.geolocation_dataset
		from 'C:\Users\ZARYAB\Desktop\olist_data\olist_geolocation_dataset.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			rowterminator='0x0a',
			tablock
		);

		truncate table bronze.order_items_dataset;
		bulk insert bronze.order_items_dataset
		from 'C:\Users\ZARYAB\Desktop\olist_data\olist_order_items_dataset.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			rowterminator='0x0a',
			tablock
		);

		truncate table bronze.order_payments_dataset;
		bulk insert bronze.order_payments_dataset
		from 'C:\Users\ZARYAB\Desktop\olist_data\olist_order_payments_dataset.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			rowterminator='0x0a',
			tablock
		);

		truncate table bronze.order_reviews_dataset;
		bulk insert bronze.order_reviews_dataset
		from 'C:\Users\ZARYAB\Desktop\olist_data\olist_order_reviews_dataset.csv'
		with (
			format='csv',
			firstrow=2,
			tablock
		);

		truncate table bronze.orders_dataset;
		bulk insert bronze.orders_dataset
		from 'C:\Users\ZARYAB\Desktop\olist_data\olist_orders_dataset.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			rowterminator='0x0a',
			tablock
		);

		truncate table bronze.product_category_name_translation;
		bulk insert bronze.product_category_name_translation
		from 'C:\Users\ZARYAB\Desktop\olist_data\product_category_name_translation.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			rowterminator='0x0a',
			tablock
		);

		truncate table bronze.products_dataset;
		bulk insert bronze.products_dataset
		from 'C:\Users\ZARYAB\Desktop\olist_data\olist_products_dataset.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			rowterminator='0x0a',
			tablock
		);

		truncate table bronze.sellers_dataset;
		bulk insert bronze.sellers_dataset
		from 'C:\Users\ZARYAB\Desktop\olist_data\olist_sellers_dataset.csv'
		with (
			firstrow=2,
			fieldterminator=',',
			rowterminator='0x0a',
			tablock
		);
	
	set @end_time = getdate()
	print 'Bronze Layer Loaded Successfully'
	print 'Start Time: ' + cast(@start_time as nvarchar(100))
	print 'End Time: ' + cast(@end_time as nvarchar(100))
	print 'Total Time Taken: ' + cast(datediff(second, @start_time, @end_time) as nvarchar(100)) + ' seconds'
	
	end try
	begin catch
		print 'Error Occured while loading Bronze Layer'
		print 'Error Number: ' + cast(error_number() as nvarchar(10))
		print 'Error Message: ' + error_message()
	end catch

end