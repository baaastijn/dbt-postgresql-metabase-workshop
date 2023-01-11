with customers as (
    select *
    from {{ ref('raw_customers') }}
),

suspects as (
    select
        domain
    from {{ ref('raw_suspicious') }}
),

final as (
    select
        customers.*
    from customers, suspects
    where email !~ domain
)
select * from final