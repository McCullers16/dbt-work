select 
userid,username,firstname,lastname,city,state,email,phone
, 
{%- set boolean_columns = ['likesports','liketheatre','likeconcerts','likejazz',
'likeclassical','likeopera','likerock','likevegas','likebroadway','likemusicals'] -%}
{% for boolean_col in boolean_columns -%}
CAST({{boolean_col}} AS INT64) AS {{boolean_col}}
{%-if not loop.last %}
,
{%- endif %}
{%- endfor %}
from {{source('ticket','allusers')}}

-- Here demonstrating the technique from the dbt course. This elimintated my use of the manual code to convert every TRUE to 1 and False to 0 that I had in my Module 2 homework.