{{ config(materialized='table') }}

with venue as (
    select *
    from {{ ref('stg_venue')}}
),

category as (
    select *
    from {{ ref('stg_category')}}
),

events as (
    select *
    from {{ ref('stg_allevents')}}
),

date as (
    select dateid,caldate as eventdate,holiday
    from {{ ref('stg_date')}}
),

final as (
    select *
    from events
    left join category using (catid)
    left join venue using (venueid)
    left join date using (dateid)
)

select * from final

-- As from lineage this shows me performing my joins with events to category, venue, and date. 