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

select
    *
from silver.order_payments_dataset