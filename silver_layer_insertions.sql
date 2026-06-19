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

with cleaned as (
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
from cleaned
group by geolocation_zip_code_prefix;