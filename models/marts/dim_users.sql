{{ config(materialized='table') }}

with users as(
    select *
    from {{ ref('stg_allusers')}}
),

sales as (
    select * from {{ ref('fct_sales') }}
),

buyer_sales as (
    select
        buyerid as userid,
        min(saledate) as first_order_date,
        max(saledate) as most_recent_order_date,
        count(salesid) as number_of_orders,
        sum(pricepaid) as ttl_amount_of_orders

    from sales
    group by 1

),

seller_sales as (
    select
        sellerid as userid,
        min(saledate) as first_sale_date,
        max(saledate) as most_recent_sale_date,
        count(salesid) as number_of_sales,
        sum(pricepaid) as ttl_amount_of_sales

    from sales
    group by 1

),


final as (
    select *
    from users
    left join buyer_sales using (userid)
    left join seller_sales using (userid)
)
  
select * from final
