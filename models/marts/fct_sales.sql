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

-- As you can see from my code above I try to answer the question on commission to show the commission rate. I am able to quickly show to users the 15 percent fixed commission rate. I can show the sales date for these transactions.