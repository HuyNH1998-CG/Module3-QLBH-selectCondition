create database quanlybanhang;
use quanlybanhang;
create table customer(
customerid int not null auto_increment primary key,
customername nvarchar(45),
customerage int
);
create table saleorder (
orderid int not null auto_increment primary key,
customerid int,
orderdate date,
ordertotalprice int,
foreign key (customerid) references customer(customerid)
);
create table product(
productid int not null primary key,
productname nvarchar(45),
productprice int
);
create table orderdetail(
orderid int not null ,
productid int not null ,
orderquantity int,
primary key (orderid,productid),
foreign key (orderid) references saleorder(orderid),
foreign key (productid) references product(productid)
);
insert into customer
value (1,"Minh Quan",10),
(2,"Ngoc Oanh",20),
(3,"Hong Ha",50);
insert into saleorder
value(1,1,"2006-02-21",null),
(2,2,"2006-03-23",null),
(3,1,"2006-03-16",null);
insert into product
value(1,"May Giat",3),
(2,"Tu Lanh",5),
(3,"Dieu Hoa",7),
(4,"Quat",1),
(5,"Bep Dien",2);
insert into orderdetail
value(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

select orderid, orderdate, ordertotalprice from saleorder;
select customername, productname from (saleorder,product) join customer on saleorder.customerid = customer.customerid;
select customername from customer c
where not exists (select null
from saleorder s
where s.customerid = c.customerid );
select saleorder.orderid,saleorder.orderdate, 
sum(orderdetail.orderquantity * product.productprice) as ordertotalprice
 from (saleorder,product) join orderdetail on 
 (orderdetail.orderid = saleorder.orderid) and (orderdetail.productid = product.productid)
 group by orderid;