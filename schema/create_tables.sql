USE AutoPartsStore;
GO

CREATE TABLE CarBrand 
(
    Brand_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name     NVARCHAR(50) NOT NULL CHECK(Name NOT LIKE '%[^A-Za-z -]%'), 
    Country  NVARCHAR(50) NOT NULL CHECK (Country LIKE '[A-Z]%')
);

CREATE TABLE CarModel
(
    Model_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL CHECK (Name <> ''),
    Brand_ID INT NOT NULL
);

CREATE TABLE ModelGeneration
(
    ModelGeneration_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name       NVARCHAR(50) NOT NULL,
    YearFrom   SMALLINT  NOT NULL CHECK (YearFrom BETWEEN 1900 AND 2100),
    YearTo     SMALLINT  NULL,
    Model_ID INT NOT NULL,

    CONSTRAINT CK_ModelGeneration_Years
    CHECK ((YearTo IS NULL) OR (YearTo BETWEEN 1900 AND 2100 AND YearTo >= YearFrom)
    )
);

    CREATE TABLE GenerationOption
    (
        GenerationOption_ID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
        --future foreign keys
        Generation_ID INT NOT NULL,
        BodyName NVARCHAR(50) NOT NULL,
        Engine_ID INT NOT NULL
    );

CREATE TABLE BodyType
(
    BodyName NVARCHAR(50) NOT NULL PRIMARY KEY CHECK (BodyName <> '')
);

-- "enumeration" for engine types
CREATE TABLE EngineType
(
    TypeName NVARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE Engine
(
    Engine_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Code NVARCHAR(20) NOT NULL,
    Capacity SMALLINT NOT NULL CHECK (Capacity >= 0),
    Horsepower SMALLINT NOT NULL CHECK (Horsepower > 0),
    EngineType_Name NVARCHAR(20) NOT NULL --foreign key for later


);

--dictionary table handling M:M relationship between CarPart and Engine
CREATE TABLE EnginePartFitment
(
    Engine_ID INT NOT NULL,
    Part_ID   INT NOT NULL,
    PRIMARY KEY (Engine_ID, Part_ID)
);


CREATE TABLE GenerationOptionPartFitment
(
    Part_ID INT NOT NULL,
    GenerationOption_ID INT NOT NULL,
    PRIMARY KEY (Part_ID, GenerationOption_ID)
);

CREATE TABLE CarPartCatalogue
(
    Part_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PartName NVARCHAR(50) NOT NULL CHECK (PartName <> ''),
    Manufacturer NVARCHAR(50) NOT  NULL,
    WarrantyPeriod TINYINT NOT NULL CHECK (WarrantyPeriod >= 0)
);

CREATE TABLE CarPartOffer
(
    Offer_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    BasePrice DECIMAL(10,2) NOT NULL CHECK (BasePrice > 0),
    PercentDiscount TINYINT NOT NULL CHECK (PercentDiscount BETWEEN 0 AND 99),
    ValidFrom DATE NOT NULL,
    ValidTo   DATE NOT NULL,
    Part_ID INT NOT NULL, -- future FK

    CONSTRAINT CK_CarPartOffer_Validity CHECK (ValidTo >= ValidFrom)
);

CREATE TABLE CarPartInventoryBatch
(
    Batch_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    QuantityAvailable INT NOT NULL CHECK (QuantityAvailable >= 0),
    QuantityReserved INT NOT NULL CHECK (QuantityReserved >= 0),
    UnitCost DECIMAL(10,2) NOT NULL CHECK (UnitCost > 0),
    Part_ID INT NOT NULL, -- future FK

    CONSTRAINT CK_CarPartInventoryBatch_Quantities CHECK (QuantityReserved <= QuantityAvailable)
);

CREATE TABLE DeliveryItemBatch
(
    DeliveryItemBatch_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ShippedQuantity SMALLINT NOT NULL CHECK (ShippedQuantity > 0),
    DeliveryItem_ID INT NOT NULL, --future FK
    Batch_ID INT NOT NULL --future FK
);

CREATE TABLE DeliveryItem
(
    DeliveryItem_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Delivery_ID INT NOT NULL, --future FK
    OrderedItem_ID INT NOT NULL --future fk
);

CREATE TABLE OrderedItem
(
    OrderedItem_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    QuantityOrdered SMALLINT NOT NULL CHECK (QuantityOrdered >= 0),
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice > 0),
    Order_ID INT NOT NULL, --future fk
    Offer_ID INT NOT NULL --future fk
);

--"enumeration" for statuses
CREATE TABLE DeliveryStatus
(
    StatusName NVARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE Delivery
(
    Delivery_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StatusName NVARCHAR(20) NOT NULL,
    DeliveryCost DECIMAL(10,2) NOT NULL CHECK (DeliveryCost > 0),
    Order_ID INT NOT NULL --future fk
);

CREATE TABLE PaymentMethod
(
    PaymentName NVARCHAR(20) NOT NULL PRIMARY KEY
);

--"enumeration" for orders
CREATE TABLE OrderStatus
(
    StatusName NVARCHAR(20) NOT NULL PRIMARY KEY
);

CREATE TABLE Orders
(
    Order_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    StatusName NVARCHAR(20) NOT NULL, 
    CustomerNote NVARCHAR(200) NULL,
    PaymentName NVARCHAR(20) NOT NULL,
    TotalCost DECIMAL(10,2) NOT NULL CHECK (TotalCost > 0),
    TransactionDate DATE NOT NULL,
    Addresses_ID INT NOT NULL,
    Customer_ID INT NOT NULL
);

CREATE TABLE Customer
(
    Customer_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Name NVARCHAR(20) NOT NULL CHECK (Name NOT LIKE '%[^A-Za-z]%'),
    Surname NVARCHAR(20) NOT NULL CHECK (Surname NOT LIKE '%[^A-Za-z]%'),
    Email NVARCHAR(40) NOT NULL CHECK (Email LIKE '%@%'),
    PhoneNumber CHAR(9) NOT NULL CHECK (PhoneNumber NOT LIKE '%[^0-9]%'),
    NIP CHAR(10) NULL CHECK (NIP IS NULL OR NIP NOT LIKE '%[^0-9]%')
);

CREATE TABLE Addresses
(
    Addresses_ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Line1 NVARCHAR(50) NOT NULL CHECK (Line1 <> ''),
    Line2 NVARCHAR(50) NULL,
    PostalCode CHAR(6) NOT NULL
        CHECK (PostalCode LIKE '[0-9][0-9]-[0-9][0-9][0-9]'),
    City NVARCHAR(50) NOT NULL
        CHECK (City LIKE '[A-Z]%'),
    Customer_ID INT NOT NULL  -- future FK
);

--------------------------------------------------------------------------------------------------------
------------------------     ALTERING TABLES -> ADDING FOREIGN KEYS                  -------------------
--------------------------------------------------------------------------------------------------------

ALTER TABLE CarModel
ADD CONSTRAINT FK_CarModel_CarBrand
    FOREIGN KEY (Brand_ID)
    REFERENCES CarBrand(Brand_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE ModelGeneration
ADD CONSTRAINT FK_ModelGeneration_CarModel
    FOREIGN KEY (Model_ID)
    REFERENCES CarModel(Model_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE GenerationOption
ADD CONSTRAINT FK_GenOption_ModelGeneration
    FOREIGN KEY (Generation_ID)
    REFERENCES ModelGeneration(ModelGeneration_ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--zmiana klucza glownego w body zaktualizuje go w generationOption
ALTER TABLE GenerationOption
ADD CONSTRAINT FK_GenOption_BodyType
    FOREIGN KEY (BodyName)
    REFERENCES BodyType(BodyName)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;

ALTER TABLE GenerationOption
ADD CONSTRAINT FK_GenOption_Engine
    FOREIGN KEY (Engine_ID)
    REFERENCES Engine(Engine_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--usuniecie generation option usunie fitment (traci logiczny sens)
ALTER TABLE GenerationOptionPartFitment
ADD CONSTRAINT FK_Fitment_GenOption
    FOREIGN KEY (GenerationOption_ID)
    REFERENCES GenerationOption(GenerationOption_ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--tak samo z czescia, usuniecie jej usunie jej fitment
ALTER TABLE GenerationOptionPartFitment
ADD CONSTRAINT FK_Fitment_CarPart
    FOREIGN KEY (Part_ID)
    REFERENCES CarPartCatalogue(Part_ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--update s³ownika updateuje wartosc wszedzie
ALTER TABLE Engine
ADD CONSTRAINT FK_Engine_EngineType
    FOREIGN KEY (EngineType_Name)
    REFERENCES EngineType(TypeName)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;

--usuniecie silnika usuwa fitment
ALTER TABLE EnginePartFitment
ADD CONSTRAINT FK_EnginePartFitment_Engine
    FOREIGN KEY (Engine_ID)
    REFERENCES Engine(Engine_ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE EnginePartFitment
ADD CONSTRAINT FK_EnginePartFitment_CarPart
    FOREIGN KEY (Part_ID)
    REFERENCES CarPartCatalogue(Part_ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--cannot delete carpart until all deliverybatches are deleted (security)
ALTER TABLE CarPartInventoryBatch
ADD CONSTRAINT FK_InventoryBatch_CarPart
    FOREIGN KEY (Part_ID)
    REFERENCES CarPartCatalogue(Part_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE CarPartOffer
ADD CONSTRAINT FK_Offer_CarPart
    FOREIGN KEY (Part_ID)
    REFERENCES CarPartCatalogue(Part_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE OrderedItem
ADD CONSTRAINT FK_OrderedItem_Offer
    FOREIGN KEY (Offer_ID)
    REFERENCES CarPartOffer(Offer_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE OrderedItem
ADD CONSTRAINT FK_OrderedItem_Order
    FOREIGN KEY (Order_ID)
    REFERENCES Orders(Order_ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE DeliveryItemBatch
ADD CONSTRAINT FK_ItemBatch_DeliveryItem
    FOREIGN KEY (DeliveryItem_ID)
    REFERENCES DeliveryItem(DeliveryItem_ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE DeliveryItemBatch
ADD CONSTRAINT FK_ItemBatch_InventoryBatch
    FOREIGN KEY (Batch_ID)
    REFERENCES CarPartInventoryBatch(Batch_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE DeliveryItem
ADD CONSTRAINT FK_DeliveryItem_Delivery
    FOREIGN KEY (Delivery_ID)
    REFERENCES Delivery(Delivery_ID)
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

ALTER TABLE DeliveryItem
ADD CONSTRAINT FK_DeliveryItem_OrderedItem
    FOREIGN KEY (OrderedItem_ID)
    REFERENCES OrderedItem(OrderedItem_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE Delivery
ADD CONSTRAINT FK_Delivery_Status
    FOREIGN KEY (StatusName)
    REFERENCES DeliveryStatus(StatusName)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;

ALTER TABLE Delivery
ADD CONSTRAINT FK_Delivery_Order
    FOREIGN KEY (Order_ID)
    REFERENCES Orders(Order_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_OrderStatus
    FOREIGN KEY (StatusName)
    REFERENCES OrderStatus(StatusName)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_PaymentMethod
    FOREIGN KEY (PaymentName)
    REFERENCES PaymentMethod(PaymentName)
    ON DELETE NO ACTION
    ON UPDATE CASCADE;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Addresses
    FOREIGN KEY (Addresses_ID)
    REFERENCES Addresses(Addresses_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

ALTER TABLE Addresses
ADD CONSTRAINT FK_Addresses_Customer
    FOREIGN KEY (Customer_ID)
    REFERENCES Customer(Customer_ID)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;