{{ config(materialized='table') }}

with date as (
    select dateid, caldate as listingdate
    from {{ ref('stg_date')}}
),

listings as (
    select *
    from {{ ref('stg_listings')}}
),

final as (
    select *
    from listings 
    left join date using (dateid)
)

select * from final 