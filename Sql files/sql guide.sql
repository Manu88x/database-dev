-- ============================================================
--  Online E-Commerce Database System — Group 10
--  SQL Schema based on Group-10 hand-drawn ERD
--  Run in this order to satisfy FK dependencies
-- ============================================================

-- 1. User
CREATE TABLE User (
  User_ID       INT          PRIMARY KEY AUTO_INCREMENT,
  FirstName     VARCHAR(50)  NOT NULL,
  LastName      VARCHAR(50)  NOT NULL,
  Password      VARCHAR(255) NOT NULL,
  Address       VARCHAR(255)
);

-- 2. User_Email  (multivalued — composite PK)
CREATE TABLE User_Email (
  User_ID  INT          NOT NULL,
  Email    VARCHAR(100) NOT NULL,
  PRIMARY KEY (User_ID, Email),
  FOREIGN KEY (User_ID) REFERENCES User(User_ID)
    ON DELETE CASCADE
);

-- 3. User_Phone  (multivalued — composite PK)
CREATE TABLE User_Phone (
  User_ID      INT         NOT NULL,
  PhoneNumber  VARCHAR(20) NOT NULL,
  PRIMARY KEY (User_ID, PhoneNumber),
  FOREIGN KEY (User_ID) REFERENCES User(User_ID)
    ON DELETE CASCADE
);

-- 4. Category
CREATE TABLE Category (
  Category_ID    INT          PRIMARY KEY AUTO_INCREMENT,
  CategoryName   VARCHAR(100) NOT NULL UNIQUE,
  CatDescription TEXT
);

-- 5. Product
CREATE TABLE Product (
  Product_ID   INT           PRIMARY KEY AUTO_INCREMENT,
  ProductName  VARCHAR(150)  NOT NULL,
  Description  TEXT,
  Category_ID  INT           NOT NULL,
  FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);

-- 6. Order  (backtick escapes reserved keyword)
CREATE TABLE `Order` (
  Order_ID         INT          PRIMARY KEY AUTO_INCREMENT,
  OrderDate        DATETIME     NOT NULL,
  OrderStatus      VARCHAR(30)  NOT NULL,
  User_ID          INT          NOT NULL,
  FOREIGN KEY (User_ID) REFERENCES User(User_ID)
);

-- 7. Order_Item
CREATE TABLE Order_Item (
  OrderItem_ID  INT            PRIMARY KEY AUTO_INCREMENT,
  Quantity      INT            NOT NULL,
  UnitPrice     DECIMAL(10,2)  NOT NULL,
  Order_ID      INT            NOT NULL,
  Product_ID    INT            NOT NULL,
  FOREIGN KEY (Order_ID)   REFERENCES `Order`(Order_ID),
  FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- 8. Cart_Item
CREATE TABLE Cart_Item (
  CartItem_ID  INT      PRIMARY KEY AUTO_INCREMENT,
  User_ID      INT      NOT NULL,
  Product_ID   INT      NOT NULL,
  Quantity     INT      NOT NULL,
  DateAdded    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (User_ID)    REFERENCES User(User_ID),
  FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- 9. Payment
CREATE TABLE Payment (
  Payment_ID      INT            PRIMARY KEY AUTO_INCREMENT,
  Amount          DECIMAL(10,2)  NOT NULL,
  PaymentMethod   VARCHAR(50)    NOT NULL,
  PaymentStatus   VARCHAR(30)    NOT NULL,
  PaymentDate     DATETIME       NOT NULL,
  Transaction_ID  VARCHAR(100)   UNIQUE,
  Order_ID        INT            NOT NULL UNIQUE,
  FOREIGN KEY (Order_ID) REFERENCES `Order`(Order_ID)
);

-- 10. Review
CREATE TABLE Review (
  Review_ID    INT      PRIMARY KEY AUTO_INCREMENT,
  ReviewText   TEXT,
  ReviewDate   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  User_ID      INT      NOT NULL,
  Product_ID   INT      NOT NULL,
  FOREIGN KEY (User_ID)    REFERENCES User(User_ID),
  FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);
