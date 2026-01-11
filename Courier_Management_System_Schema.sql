Alter table orders
add constraint DF_orders_Statuss Default 'pending' for Statuss


CREATE TABLE ADMIN(
EMAIL varchar(50) not null,
PASSWORD varchar(50) not null,
);


CREATE TABLE Employee(
Employee_ID int NOT NULL PRIMARY KEY,
USERNAME Varchar(50) NOT NULL,
PASSWORD Varchar(50) NOT NULL,
PHONENO Varchar(50) NOT NULL,
GENDER Varchar(50) NOT NULL,
EMAIL Varchar(50) NOT NULL,
ADDRESS Varchar(50) NOT NULL,
);

 
CREATE TABLE  USEER(
User_ID int NOT NULL PRIMARY KEY,
USERNAME Varchar(50) NOT NULL,
PASSWORD Varchar(50) NOT NULL,
PHONENO Varchar(50) NOT NULL,
GENDER Varchar(50) NOT NULL,
EMAIL Varchar(50) NOT NULL,
ADDRESS Varchar(50) NOT NULL,
);

CREATE TABLE Sender(
Sender_ID int NOT NULL PRIMARY KEY,
Sen_CNIC Varchar(50) NOT NULL,
Sen_FULLNAME varchar(50) NULL,
Sen_EMAIL varchar(50) NULL,
Sen_PHONE varchar(50) NULL,
Sen_ADDRESS varchar(50) NULL,
Se_Pin_Code varchar(50) NULL,

   );
CREATE TABLE Receiver(
Receiver_ID int NOT NULL PRIMARY KEY,
Re_CNIC Varchar(50) NOT NULL,
Re_FULLNAME varchar(50) NULL,
Re_EMAIL varchar(50) NULL,
Re_PHONE varchar(50) NULL,
Re_ADDRESS varchar(50) NULL,
Re_Pin_Code varchar(50) NULL,


   );
CREATE TABLE  Delivery(
PackageID int NOT NULL PRIMARY KEY,
RegistrationNo Varchar(50) NOT NULL,
PackageType Varchar(50) NOT NULL,
Weightt varchar(50) NOT NULL,
ServiceType varchar(50) NOT NULL,
DeliveryTime varchar(50) NOT NULL,
Shippingdate varchar(50) NOT NULL,


   );

CREATE TABLE orders (
Order_ID int NOT NULL PRIMARY KEY,
PackageID int NOT NULL,
  FOREIGN KEY(PackageID) REFERENCES Delivery(PackageID),
Sender_ID int NOT NULL,
 FOREIGN KEY(Sender_ID) REFERENCES Sender(Sender_ID),
Se_FULLNAME varchar(50) NULL,
Se_Pin_Code varchar(50) NULL,
Sen_ADDRESS varchar(50) NULL,
Receiver_ID int NOT NULL,
 FOREIGN KEY (Receiver_ID) REFERENCES Receiver(Receiver_ID),
Re_Pin_Code varchar(50) NULL,
Re_ADDRESS varchar(50) NULL,
PackageType varchar(50) NULL,
Statuss varchar(50) NULL
);


ALTER TABLE Sender
    ADD Order_ID int NOT NULL,
    FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID)


ALTER TABLE Receiver
    ADD Order_ID int NOT NULL,
    FOREIGN KEY(Order_ID) REFERENCES Orders(Order_ID)


Create TABlE Delivery(
PackageID int NOT NULL PRIMARY KEY,
RegistrationNo varchar(50) NOT NULL,
PackageType  varchar(50) NULL,
Weightt    varchar(50)  NULL,
ServiceType  varchar(50) NULL,
PackageDimension varchar(50) NULL,
Shippingdate   varchar(50) NULL
);

--------------------------------------------V1

Create VIEW Order_view as
select e.PackageID,a.Sender_ID,a.Sen_FULLNAME,a.Se_Pin_Code,a.Sen_ADDRESS,
b.Receiver_ID,b.Re_Pin_Code,b.Re_ADDRESS,
e.PackageType from Sender as a
inner join Receiver as b on a.Sender_ID=b.Receiver_ID
inner  join Delivery as e on a.Sender_ID=e.PackageID

select * from Order_view
Alter table orders
add constraint DF_orders_Statuss
default 'pending' for Statuss
---------------------------------------------V2


create view compl_view as
select a.Order_ID,c.Re_FULLNAME as Customer,b.Sen_ADDRESS as Origen,c.Re_ADDRESS as Destination,d.PackageType,c.Re_ADDRESS as address,d.PackageID from orders as a
full join Sender as b on a.Order_ID=b.Sender_ID
full join Receiver as c on a.Order_ID=c.Receiver_ID
full join Delivery as d on a.Order_ID=d.PackageID
where a.Statuss like 'Completed'


select * from Comp_orders

--------------------------------------------V3
create view Tracker as 
select s.Sen_FULLNAME,r.Re_FULLNAME,s.Sen_ADDRESS,r.Re_ADDRESS,a.PackageType,a.ServiceType,a.PackageID,a.RegistrationNo,a.Shippingdate from Delivery as a
full join Sender as s on a.PackageID=s.Sender_ID
full join Receiver as r on s.Sender_ID=r.Receiver_ID

select * from Tracker where  PackageID=5         --RegistrationNo like 'reg#1'

create view wTracker as 
select s.Sen_FULLNAME,r.Re_FULLNAME,s.Sen_ADDRESS,r.Re_ADDRESS,a.PackageType,a.ServiceType,a.PackageID,a.RegistrationNo,a.Shippingdate,j.Statuss from Delivery as a
full join Sender as s on a.PackageID=s.Sender_ID
full join Receiver as r on s.Sender_ID=r.Receiver_ID
full join orders as j on   s.Sender_ID=r.Receiver_ID

------------------------------------------V4
create view Confim_views as
select c.PackageID,a.Sen_FULLNAME,a.Sen_PHONE ,a.Sen_ADDRESS,b.Re_FULLNAME,b.Re_PHONE,b.Re_ADDRESS
,c.Weightt,c.PackageDimension,c.PackageType ,c.Shippingdate,c.ServiceType from Sender as a
join Receiver as b on a.Sender_ID=b.Receiver_ID
join Delivery as c on b.Receiver_ID=c.PackageID
select * from  Confim_views

----------------------------------------V5
create view cancel_view as
select a.Order_ID,c.Re_FULLNAME as Customer,b.Sen_ADDRESS as Origen,c.Re_ADDRESS as Destination,d.PackageType,c.Re_ADDRESS as address,d.PackageID from orders as a
full join Sender as b on a.Order_ID=b.Sender_ID
full join Receiver as c on a.Order_ID=c.Receiver_ID
full join Delivery as d on a.Order_ID=d.PackageID
where a.Statuss like 'Cancelled'

select * from cancel_view
----------------------------------------v6
create view Confim_viewss as
select c.RegistrationNo,c.PackageID,a.Sen_FULLNAME,a.Sen_PHONE ,a.Sen_ADDRESS,b.Re_FULLNAME,b.Re_PHONE,b.Re_ADDRESS
,c.Weightt,c.PackageDimension,c.PackageType ,c.Shippingdate,c.ServiceType from Sender as a
join Receiver as b on a.Sender_ID=b.Receiver_ID
join Delivery as c on b.Receiver_ID=c.PackageID
select * from  Confim_viewss  where RegistrationNo like 'reg#1'