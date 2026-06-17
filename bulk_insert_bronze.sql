bulk insert bronze.customers_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_customers_dataset.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);

bulk insert bronze.geolocation_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_geolocation_dataset.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);

bulk insert bronze.order_items_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_order_items_dataset.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);

bulk insert bronze.order_payments_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_order_payments_dataset.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);

bulk insert bronze.order_reviews_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_order_reviews_dataset.csv'
with (
	format='csv',
	firstrow=2,
	tablock
);


bulk insert bronze.orders_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_orders_dataset.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);

bulk insert bronze.product_category_name_translation
from 'C:\Users\ZARYAB\Desktop\olist_data\product_category_name_translation.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);

bulk insert bronze.products_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_products_dataset.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);

bulk insert bronze.sellers_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_sellers_dataset.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);