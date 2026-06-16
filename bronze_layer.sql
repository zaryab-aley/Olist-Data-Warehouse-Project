if object_id ('bronze.customers_dataset', 'U') is not null
	drop table bronze.customers_dataset
create table bronze.customers_dataset(
customer_id nvarchar(50),
customer_unique_id nvarchar(50),
customer_zip_code_prefix int,
customer_city nvarchar(50),
customer_state nvarchar(5)
)

if object_id ('bronze.geolocation_dataset', 'U') is not null
	drop table bronze.geolocation_dataset
create table bronze.geolocation_dataset(
geolocation_zip_code_prefix int,
geolocation_lat float,
geolocation_lng float,
geolocation_city nvarchar(50),
geolocation_state nvarchar(5)
)

if object_id ('bronze.order_items_dataset', 'U') is not null
	drop table bronze.order_items_dataset
create table bronze.order_items_dataset(
order_id nvarchar(50),
order_item_id nvarchar(50),
product_id nvarchar(50),
seller_id nvarchar(50),
shipping_limit_date datetime2,
price decimal,
freight_value decimal
)

if object_id ('bronze.order_payments_dataset', 'U') is not null
	drop table bronze.order_payments_dataset
create table bronze.order_payments_dataset(
order_id nvarchar(50),
payment_sequential int,
payment_type nvarchar(50),
payment_installments int,
payment_value decimal
)

if object_id ('bronze.order_reviews_dataset', 'U') is not null
	drop table bronze.order_reviews_dataset
create table bronze.order_reviews_dataset(
review_id nvarchar(50),
order_id nvarchar(50),
review_score int,
review_comment_title nvarchar(200),
review_comment_message nvarchar(200),
review_creation_date datetime2,
review_answer_timestamp datetime2
)

if object_id ('bronze.orders_dataset', 'U') is not null
	drop table bronze.orders_dataset
create table bronze.orders_dataset(
order_id nvarchar(50),
customer_id nvarchar(50),
order_status nvarchar(50),
order_purchase_timestamp datetime2,
order_approved_at datetime2,
order_delivered_carrier_date datetime2,
order_delivered_customer_date datetime2,
order_estimated_delivery_date datetime2
)

if object_id ('bronze.products_dataset', 'U') is not null
	drop table bronze.products_dataset
create table bronze.products_dataset(
product_id nvarchar(50),
product_category_name nvarchar(50),
product_name_lenght int,
product_description_lenght int,
product_photos_qty int,
product_weight_g int,
product_length_cm int,
product_height_cm int,
product_width_cm int
)

if object_id ('bronze.sellers_dataset', 'U') is not null
	drop table bronze.sellers_dataset
create table bronze.sellers_dataset(
seller_id nvarchar(50),
seller_zip_code_prefix int,
seller_city nvarchar(50),
seller_state nvarchar(5)
)

if object_id ('bronze.product_category_name_translation', 'U') is not null
	drop table bronze.product_category_name_translation
create table bronze.product_category_name_translation(
product_category_name nvarchar(50),
product_category_name_english nvarchar(50)
)