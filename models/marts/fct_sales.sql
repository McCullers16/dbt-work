{{ config(materialized='table') }}

with date as (
    select dateid, caldate as saledate, day, week, month, qtr, year, holiday
    from {{ ref('stg_date')}}
),

sales as (
    select *
    from {{ ref('stg_sales')}}
),

final as (
    select salesid,listid,sellerid,buyerid,eventid,qtysold,pricepaid,
    commission, 1.0*commission/pricepaid as commission_rate,saletime,saledate,holiday
    from sales 
    left join date using (dateid)
)

select * from final
