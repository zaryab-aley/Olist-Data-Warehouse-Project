bulk insert bronze.customers_dataset
from 'C:\Users\ZARYAB\Desktop\olist_data\olist_customers_dataset.csv'
with (
	firstrow=2,
	fieldterminator=',',
	rowterminator='0x0a',
	tablock
);