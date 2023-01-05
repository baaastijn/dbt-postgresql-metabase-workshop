with customers as (

    select * from {{ ref('raw_customers') }}

),

orders as (

    select * from {{ ref('raw_orders') }}

),

payments as (

    select * from {{ ref('raw_payments') }}

),


final as (

    select
        customers.country,
        count(orders.id) as total_of_orders,
        sum(payments.amount) as total_revenue

    from customers

    join orders
        on customers.id = orders.customer_id

    join payments
        on  orders.id = payments.order_id
    
    where orders.order_status = 'true'
    
    group by customers.country

)

select * from final