if object_id ('silver.customers_dataset', 'U') is not null
	drop table silver.customers_dataset
create table silver.customers_dataset(
customer_id nvarchar(50),
customer_unique_id nvarchar(50),
customer_zip_code_prefix varchar(20),
customer_city nvarchar(50),
customer_state nvarchar(5),
dwh_create_date datetime2 default getdate(),
)

if object_id ('silver.geolocation_dataset', 'U') is not null
	drop table silver.geolocation_dataset
create table silver.geolocation_dataset(
geolocation_id int,
geolocation_zip_code_prefix varchar(50),
geolocation_lat float,
geolocation_lng float,
geolocation_city nvarchar(50),
geolocation_state nvarchar(50),
dwh_create_date datetime2 default getdate(),
)

if object_id ('silver.order_items_dataset', 'U') is not null
	drop table silver.order_items_dataset
create table silver.order_items_dataset(
order_id nvarchar(50),
order_item_id nvarchar(50),
product_id nvarchar(50),
seller_id nvarchar(50),
shipping_limit_date datetime2,
price decimal,
freight_value decimal,
dwh_create_date datetime2 default getdate(),
)

if object_id ('silver.order_payments_dataset', 'U') is not null
	drop table silver.order_payments_dataset
create table silver.order_payments_dataset(
order_id nvarchar(50),
payment_sequential int,
payment_type nvarchar(50),
payment_installments int,
payment_value decimal,
dwh_create_date datetime2 default getdate(),
)

if object_id ('silver.order_reviews_dataset', 'U') is not null
	drop table silver.order_reviews_dataset
create table silver.order_reviews_dataset(
review_id nvarchar(50),
order_id nvarchar(50),
review_score nvarchar(50),
review_comment_title nvarchar(max),
review_comment_message nvarchar(max),
review_creation_date nvarchar(100),
review_answer_timestamp nvarchar(100),
dwh_create_date datetime2 default getdate(),
)

if object_id ('silver.orders_dataset', 'U') is not null
	drop table silver.orders_dataset
create table silver.orders_dataset(
order_id nvarchar(50),
customer_id nvarchar(50),
order_status nvarchar(50),
order_purchase_timestamp datetime2,
order_approved_at datetime2,
order_delivered_carrier_date datetime2,
order_delivered_customer_date datetime2,
order_estimated_delivery_date datetime2,
dwh_create_date datetime2 default getdate(),
)

if object_id ('silver.products_dataset', 'U') is not null
	drop table silver.products_dataset
create table silver.products_dataset(
product_id nvarchar(50),
product_category_name nvarchar(50),
product_name_lenght int,
product_description_lenght int,
product_photos_qty int,
product_weight_g int,
product_length_cm int,
product_height_cm int,
product_width_cm int,
dwh_create_date datetime2 default getdate(),
)

if object_id ('silver.sellers_dataset', 'U') is not null
	drop table silver.sellers_dataset
create table silver.sellers_dataset(
seller_id nvarchar(50),
seller_zip_code_prefix nvarchar(50),
seller_city nvarchar(50),
seller_state nvarchar(50),
dwh_create_date datetime2 default getdate(),
)

if object_id ('silver.product_category_name_translation', 'U') is not null
	drop table silver.product_category_name_translation
create table silver.product_category_name_translation(
product_category_name nvarchar(50),
product_category_name_english nvarchar(50),
dwh_create_date datetime2 default getdate(),
)