CREATE DATABASE PROJECT;  
GO
USE PROJECT  


 

CREATE TABLE [User] (  

    username varchar(50) not null check (LEN(username) > 5), 

    passhash varchar(100) not null,  

    fullname varchar(100) not null,  

    isbuyer bit default 0,  

    isseller bit default 0,  

    CONSTRAINT User_pk PRIMARY KEY (username)  

);  

 

  

CREATE TABLE User_email(  

    username varchar(50) not null,  

    email varchar(100) not null,  

    CONSTRAINT UserEmail_pk PRIMARY KEY (username, email),  

    CONSTRAINT UserEmail_fk FOREIGN KEY (username) REFERENCES [User](username)  

);  

 

 

CREATE TABLE User_phonenumber(  

    username varchar(50) not null,  

    phonenumber varchar(10) not null,  

    CONSTRAINT UserPhoneNumber_pk PRIMARY KEY (username, phonenumber),  

    CONSTRAINT UserPhoneNumber_fk FOREIGN KEY (username) REFERENCES [User](username)  

);  

 

  

CREATE TABLE PaymentMethod(  

    payment_id int not null IDENTITY(1, 1),  

    method_name varchar(50) not null UNIQUE check (method_name in ('Venmo', 'Paypal', 'Credit Card', 'Cash', 'Flex Dollars')),   

    CONSTRAINT PaymentMethod_PK PRIMARY KEY (payment_id)  

);  

 

  

CREATE TABLE UVALocation(  

    locationID int not null IDENTITY(1, 1),  

    [name] varchar(50) not null,  

    street varchar(50) not null,  

    city varchar(50) not null,  

    [state] varchar(50) not null,  

    zip int not null,  

    CONSTRAINT UVALocation_PK PRIMARY KEY (locationID)  

);  

 

 

CREATE TABLE User_PaymentMethods(  

    username varchar(50) not null,   

    payment_id int not null,  

    CONSTRAINT User_PaymentMethods_PK PRIMARY KEY (username, payment_id),  

    CONSTRAINT User_PaymentMethods_FK1 FOREIGN KEY (username) REFERENCES [User](username),  

    CONSTRAINT User_PaymentMethods_FK2 FOREIGN KEY (payment_id) REFERENCES [PaymentMethod](payment_id)  

);  

 

 

CREATE TABLE User_UVALocations(  

    username varchar(50) not null,  

    locationID int not null,  

    CONSTRAINT User_UVALocations_PK PRIMARY KEY (username, locationID),  

    CONSTRAINT User_UVALocation_FK1 FOREIGN KEY (username) REFERENCES [User](username),  

    CONSTRAINT User_UVALocation_FK2 FOREIGN KEY (locationID) REFERENCES [UVALocation](locationID)  

);  

  

 

CREATE TABLE User_Rates(   

    rating_id int not null IDENTITY(1, 1),   

    rater varchar(50) not null,   

    ratee varchar(50) not null,  

    rating int not null CONSTRAINT rating_ck check (rating between 1 and 5),    

    comment varchar(100),   

    CONSTRAINT User_Rates_PK PRIMARY KEY (rating_id),   

    CONSTRAINT User_Rates_FK1 FOREIGN KEY (rater) REFERENCES [User](username),   

    CONSTRAINT User_Rates_FK2 FOREIGN KEY (ratee) REFERENCES [User](username)   

);  

 

 

CREATE TABLE Car(  

    car_id int not null IDENTITY(1, 1),      

    username varchar(50) not null, 

    make varchar(50) not null,  

    model varchar(50) not null,  

    [year] int not null CONSTRAINT car_year_ck check ([year] > 1900),  

    color varchar(50) not null,      
    CONSTRAINT Car_username_FK FOREIGN KEY (username) REFERENCES [User](username), 

    CONSTRAINT Car_PK PRIMARY KEY (car_id)  

);  

 

 

CREATE TABLE Venmo(   

    handle varchar(50) not null check (LEN(handle) > 5),    

    username varchar(50) not null,    

    CONSTRAINT User_Venmo_FK FOREIGN KEY (username) REFERENCES [User](username),    

    CONSTRAINT Venmo_PK PRIMARY KEY (handle)   

);   

 

 

CREATE TABLE Paypal(   

    username varchar(50) not null check (LEN(username) > 5),    

    app_username varchar(50) not null,     

    CONSTRAINT User_Paypal_FK FOREIGN KEY (app_username) REFERENCES [User](username),  

    CONSTRAINT Paypal_PK PRIMARY KEY (username)   

);   

  

 

CREATE TABLE Condition(  

    condition_id int not null IDENTITY(1, 1),  

    condition_name varchar(50) not null UNIQUE check (condition_name in ('New', 'Excellent', 'Good', 'Bad')),  

    CONSTRAINT Condition_PK PRIMARY KEY (condition_id)  

);  

  

 

CREATE TABLE ListedItem(   

    item_id int not null IDENTITY(1, 1), 

    seller_username varchar (50) not null, 

    buyer_username varchar (50), 

    [description] varchar(250),   

    quantity int not null,   

    [name] varchar(50) not null,   

    price int not null,   

    list_date date not null DEFAULT GETDATE(),   

    purchase_date date,   

    condition_id int not null, 

    CONSTRAINT ListedItem_Condition_FK FOREIGN KEY (condition_id) REFERENCES Condition(condition_id),  

    CONSTRAINT ListedItem_Seller_FK FOREIGN KEY (seller_username) REFERENCES [User](username), 

    CONSTRAINT ListedItem_Buyer_FK FOREIGN KEY (buyer_username) REFERENCES [User](username),  

    CONSTRAINT ListedItem_PK PRIMARY KEY (item_id)   

);   

 

  

CREATE TABLE WishList(   

    wishlist_id int not null IDENTITY(1, 1),   

    username varchar(50) not null,   

    CONSTRAINT WishList_PK PRIMARY KEY (wishlist_id),   

    CONSTRAINT WishList_User_FK FOREIGN KEY (username) REFERENCES [User](username)   

); 

 

CREATE TABLE ListedItem_WishList(  

    wishlist_id int not null,  

    item_id int not null,  

    CONSTRAINT ListedItem_WishList_PK PRIMARY KEY (wishlist_id, item_id),  

    CONSTRAINT ListedItem_WishList_fk1 FOREIGN KEY (item_id) REFERENCES ListedItem(item_id),  

    CONSTRAINT ListedItem_WishList_fk2 FOREIGN KEY (wishlist_id) REFERENCES WishList(wishlist_id)  

);  

  

 

CREATE TABLE ShoppingCart(  

    shoppingcart_id int not null IDENTITY(1, 1),  

    username varchar(50) not null,  

    CONSTRAINT ShoppingCart_pk PRIMARY KEY (shoppingcart_id),  

    CONSTRAINT ShoppingCart_username_fk FOREIGN KEY (username) REFERENCES [User](username)  

);  

 

 

CREATE TABLE ListedItem_ShoppingCart(  

    item_id int not null,  

    shoppingcart_id int not null,  

    CONSTRAINT ListedItem_ShoppingCart_pk PRIMARY KEY (item_id, shoppingcart_id),  

    CONSTRAINT ListedItem_ShoppingCart_fk1 FOREIGN KEY (item_id) REFERENCES ListedItem(item_id),  

    CONSTRAINT ListedItem_ShoppingCart_fk2 FOREIGN KEY (shoppingcart_id) REFERENCES ShoppingCart(shoppingcart_id)  

);  

  

 

CREATE TABLE Category(  

    category_id int not null IDENTITY(1, 1),  

    category_name varchar(50) not null UNIQUE check (category_name in ('Technology', 'Clothing','Vehicle')),  

    CONSTRAINT Category_pk PRIMARY KEY (category_id),  

); 

 

 

 

CREATE TABLE ListedItem_Category(  

    item_id int not null,  

    category_id int not null,  

    CONSTRAINT ListedItem_Category_pk PRIMARY KEY (item_id, category_id),  

    CONSTRAINT ListedItem_Category_fk1 FOREIGN KEY (item_id) REFERENCES ListedItem(item_id),  

    CONSTRAINT ListedItem_Category_fk2 FOREIGN KEY (category_id) REFERENCES Category(category_id)  

);  

 

  

CREATE TABLE ShippingMethod(  

    shipping_id int not null IDENTITY(1, 1),  

    shipping_name varchar(50) not null UNIQUE check (shipping_name in ('Delivery', 'Pick-up')), 

    CONSTRAINT ShippingMethod_pk PRIMARY KEY (shipping_id)  

);  

 

  

CREATE TABLE ListedItem_ShippingMethod(  

    item_id int not null,  

    shipping_id int not null,  

    CONSTRAINT ListedItem_ShippingMethod_pk PRIMARY KEY (item_id, shipping_id),  

    CONSTRAINT ListedItem_ShippingMethod_fk1 FOREIGN KEY (item_id) REFERENCES ListedItem(item_id),  

    CONSTRAINT ListedItem_ShippingMethod_fk2 FOREIGN KEY (shipping_id) REFERENCES ShippingMethod(shipping_id)  

);   