-- Multi-Table Query Practice

-- Display the ProductName and CategoryName for all products in the database. Shows 77 records.
select c.CategoryName as Category
    , p.ProductName as Product
from product as p
join category as c 
    on p.CategoryId = c.Id

-- Display the order Id and shipper CompanyName for all orders placed before August 9 2012. Shows 429 records.

select o.Id as OrderId, o.ShipName as CompanyName, o.OrderDate
from [order] as o
where o.orderDate < DATE('2012-08-09')
order by o.OrderDate  --added to see the dates better

--another way (with joining): 
select o.Id as OrderId, s.CompanyName , o.OrderDate
from [order] as o
join shipper as s
    on o.shipvia = s.id
where o.orderDate < DATE('2012-08-09')
order by o.OrderDate

-- Display the name and quantity of the products ordered in order with Id 10251. Sort by ProductName. Shows 3 records.
--select * from [order]
--select * from product
--select * from [orderDetail]

select orderDetail.Quantity, orderDetail.ProductId, product.ProductName, [order].Id
from [order]
join orderDetail
    on [order].id = orderDetail.OrderId
join product
    on orderDetail.ProductId = product.id
where [order].id = 10251

-- Display the OrderID, Customer's Company Name and the employee's LastName for every order. All columns should be labeled clearly. Displays 16,789 records.
select [order].Id as order_id, customer.CompanyName as Customers_Company_Name, employee.LastName as employees_lastName
from [order]
join customer
    on [order].CustomerId = customer.Id
join employee
    on [order].EmployeeId = employee.Id


--~~~~~~~~~STRETCH~~~~~~~~~~~
--Displays CategoryName and a new column called Count that shows how many products are in each category. Shows 8 records.
select categories.CategoryName, count( products.productName) as ProductCount
from categories
join products
on categories.categoryid = products.categoryid
group by categories.categoryname

--Display OrderID and a column called ItemCount that shows the total number of products placed on the order. Shows 196 records.
select  [orderDetails].orderid, total([orderDetails].quantity) as ItemCount
from [orderDetails]
group by [orderDetails].orderid