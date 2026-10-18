SELECT o.id,c.name , sum(oi.qty*oi.price) total
from orders o join customers c on c.id=o.customer_id
  JOIN order_items oi ON oi.order_id = o.id
where o.created_at >= '2024-01-01' and c.country in ('DE','FR')
group by o.id, c.name
having sum(oi.qty*oi.price)>100
order by total desc
