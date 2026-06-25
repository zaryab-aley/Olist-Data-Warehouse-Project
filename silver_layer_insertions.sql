insert into silver.customers_dataset(
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
	)
select
	trim(replace(customer_id, '"', '')) as customer_id,
	trim(replace(customer_unique_id, '"', '')) as customer_unique_id,
	trim(replace(customer_zip_code_prefix, '"', '')) as customer_zip_code_prefix,
	trim(upper(customer_city)) as customer_city,
	trim(customer_state) as customer_state
from bronze.customers_dataset

with cleaned_geolocation as (
    select
        replace(geolocation_zip_code_prefix, '"', '') as geolocation_zip_code_prefix,
        cast(geolocation_lat as float) as geolocation_lat,
        cast(geolocation_lng as float) as geolocation_lng,
        case
            when lower(trim(replace(replace(replace(geolocation_city, '"', ''), '*', ''), '...', ''))) like '%paulo'
                then 'sao paulo'
            else lower(trim(replace(replace(replace(geolocation_city, '"', ''), '*', ''), '...', '')))
        end as geolocation_city,
        case
            when len(upper(trim(replace(geolocation_state, '"', '')))) > 2
                then right(upper(trim(replace(geolocation_state, '"', ''))), 2)
            else upper(trim(replace(geolocation_state, '"', '')))
        end as geolocation_state
    from bronze.geolocation_dataset
)
insert into silver.geolocation_dataset(
geolocation_id, geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state
)
select
    row_number() over(order by geolocation_zip_code_prefix) as geolocation_id,
    geolocation_zip_code_prefix,
    avg(geolocation_lat) as geolocation_lat,
    avg(geolocation_lng) as geolocation_lng,
    min(geolocation_city) as geolocation_city,
    min(geolocation_state) as geolocation_state
from cleaned_geolocation
group by geolocation_zip_code_prefix;

insert into silver.order_items_dataset(
order_item_pk, order_id, order_item_id, product_id, seller_id, shipping_limit_date, price, freight_value)
select
    row_number() over(order by order_id, order_item_id) as order_item_pk,
    *
from
(
    select
        lower(trim(replace(order_id, '"', ''))) as order_id,
        cast(order_item_id as int) as order_item_id,
        lower(trim(replace(product_id, '"', ''))) as product_id,
        lower(trim(replace(seller_id, '"', ''))) as seller_id,
        cast(shipping_limit_date as datetime2) as shipping_limit_date,
        cast(price as decimal(10,2)) as price,
        cast(freight_value as decimal(10,2)) as freight_value
    from bronze.order_items_dataset
) as t;

insert into silver.order_payments_dataset(
order_payment_pk, order_id, payment_sequential, payment_type, payment_installments, payment_value
)

select
    row_number() over(order by order_id, payment_sequential) as order_payment_pk,
    *
from
(
    select
        lower(trim(replace(order_id, '"', ''))) as order_id,
        cast(payment_sequential as int) as payment_sequential,
        lower(trim(replace(payment_type, '"', ''))) as payment_type,
        cast(payment_installments as int) as payment_installments,
        cast(payment_value as decimal(10,2)) as payment_value
    from bronze.order_payments_dataset
) as t;

insert into silver.order_reviews_dataset(
review_id, order_id, review_score, review_comment_title, review_comment_message, review_creation_date, review_answer_timestamp
)

select
	lower(trim(review_id)) as review_id,
	lower(trim(order_id)) as order_id,
	cast(review_score as int) as review_score,
	case
		when review_comment_title is null then 'no title'
		else lower(trim(review_comment_title))
	end as review_comment_title,
	case
		when review_comment_message is null then 'no review'
		else lower(trim(review_comment_message))
	end as review_comment_message,
	cast(review_creation_date as datetime2) as review_creation_date,
	cast(review_answer_timestamp as datetime2) as review_answer_timestamp
from bronze.order_reviews_dataset

insert into silver.orders_dataset(
order_id, customer_id, order_status, order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date, approval_date_missing, delivered_carrier_date_missing, delivered_customer_date_missing
)

select
	lower(trim(replace(order_id, '"', ''))) as order_id,
	lower(trim(replace(customer_id, '"', ''))) as customer_id,
	lower(trim(replace(order_status, '"', ''))) as order_status,
	order_purchase_timestamp,
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date,
	case
		when order_approved_at is null then 1
		else 0
	end as approval_date_missing,
	case
		when order_delivered_carrier_date is null then 1
		else 0
	end as delivered_carrier_date_missing,
	case
		when order_delivered_customer_date is null then 1
		else 0
	end as delivered_customer_date_missing
from bronze.orders_dataset

insert into silver.product_category_name_translation(
product_category_name, product_category_name_english
)

select distinct
	lower(trim(replace(product_category_name, '_', ' '))) as product_category_name,
	lower(trim(replace(product_category_name_english, '_', ' '))) as product_category_name_english
from bronze.product_category_name_translation

insert into silver.products_dataset(
product_id, product_category_name, product_name_length, product_description_length, missing_product_information, product_photos_qty, missing_product_photos_qty, product_weight_g, product_length_cm, product_height_cm, product_width_cm, missing_dimensions
)

select
	lower(trim(replace(product_id, '"', ''))) as product_id,
	coalesce(lower(trim(replace(product_category_name, '_', ' '))), 'unknown') as product_category_name,
	product_name_lenght as product_name_length,
	product_description_lenght as product_description_length,
	case
		when product_name_lenght is null or product_description_lenght is null then 1
		else 0
	end as missing_product_information,
	product_photos_qty,
	case
		when product_photos_qty is null then 1
		else 0
	end as missing_product_photos_qty,
	product_weight_g,
	product_length_cm,
	product_height_cm,
	product_width_cm,
	case
		when product_weight_g is null or product_length_cm is null or product_height_cm is null or product_width_cm is null then 1
		else 0
	end as missing_dimensions
from bronze.products_dataset