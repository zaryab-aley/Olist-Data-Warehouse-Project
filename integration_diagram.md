# Integration Diagram

```mermaid
flowchart LR
    GEO["geolocation_dataset<br/>geolocation_zip_code_prefix<br/>geolocation_lat<br/>geolocation_lng<br/>geolocation_city<br/>geolocation_state"]

    CUST["customers_dataset<br/>customer_ID<br/>customer_unique_ID<br/>customer_zip_code_prefix<br/>customer_city<br/>customer_state"]

    ORD["orders_dataset<br/>order_ID<br/>customer_ID<br/>order_status<br/>order_purchase_timestamp<br/>order_approved_at<br/>order_delivered_carrier_date<br/>order_delivered_customer_date<br/>order_estimated_delivery_date"]

    ITEMS["order_items_dataset<br/>order_ID<br/>order_item_ID<br/>product_ID<br/>seller_ID<br/>shipping_limit_date<br/>price<br/>freight_value"]

    PAY["order_payments_dataset<br/>order_ID<br/>payment_sequential<br/>payment_type<br/>payment_installments<br/>payment_value"]

    REV["order_reviews_dataset<br/>review_ID<br/>order_ID<br/>review_score<br/>review_comment_title<br/>review_comment_message<br/>review_creation_date<br/>review_answer_timestamp"]

    PROD["products_dataset<br/>product_ID<br/>product_category_name<br/>product_name_length<br/>product_description_length<br/>product_photos_qty<br/>product_weight_g<br/>product_length_cm<br/>product_height_cm<br/>product_width_cm"]

    CAT["product_category_name_translation<br/>product_category_name<br/>product_category_name_english"]

    SELL["sellers_dataset<br/>seller_ID<br/>seller_zip_code_prefix<br/>seller_city<br/>seller_state"]

    GEO -->|"geolocation_zip_code_prefix = customer_zip_code_prefix"| CUST
    GEO -->|"geolocation_zip_code_prefix = seller_zip_code_prefix"| SELL

    CUST -->|"customer_ID"| ORD

    ORD -->|"order_ID"| ITEMS
    ORD -->|"order_ID"| PAY
    ORD -->|"order_ID"| REV

    PROD -->|"product_ID"| ITEMS
    SELL -->|"seller_ID"| ITEMS

    CAT -->|"product_category_name"| PROD
```

## Relationship Summary

| Parent table | Child table | Join key |
|---|---|---|
| `customers_dataset` | `orders_dataset` | `customer_ID` |
| `orders_dataset` | `order_items_dataset` | `order_ID` |
| `orders_dataset` | `order_payments_dataset` | `order_ID` |
| `orders_dataset` | `order_reviews_dataset` | `order_ID` |
| `products_dataset` | `order_items_dataset` | `product_ID` |
| `sellers_dataset` | `order_items_dataset` | `seller_ID` |
| `product_category_name_translation` | `products_dataset` | `product_category_name` |
| `geolocation_dataset` | `customers_dataset` | `geolocation_zip_code_prefix = customer_zip_code_prefix` |
| `geolocation_dataset` | `sellers_dataset` | `geolocation_zip_code_prefix = seller_zip_code_prefix` |

