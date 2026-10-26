USE AutoPartsStore;
GO

INSERT INTO CarBrand (Name, Country)
VALUES 
('Volkswagen', 'Germany'),
('Audi', 'Germany'),
('Toyota', 'Japan'),
('Honda', 'Japan'),
('Ford', 'USA'),
('Chevrolet', 'USA'),
('Hyundai', 'South Korea'),
('Kia', 'South Korea'),
('Volvo', 'Sweden'),
('Renault', 'France'),
('Peugeot', 'France'),
('Skoda', 'Czech Republic'),
('Fiat', 'Italy'),
('Alfa Romeo', 'Italy'),
('Nissan', 'Japan');

INSERT INTO CarModel (Name, Brand_ID)
VALUES
('Golf', 1),
('Passat', 1),
('Tiguan', 1),
('A3', 2),
('A4', 2),
('Q5', 2),
('Corolla', 3),
('Camry', 3),
('RAV4', 3),
('Civic', 4),
('Accord', 4),
('CR-V', 4),
('Focus', 5),
('Mustang', 5),
('Explorer', 5),
('Malibu', 6),
('Silverado', 6),
('Equinox', 6);

---------------------------

INSERT INTO ModelGeneration (Name, YearFrom, YearTo, Model_ID)
VALUES
-- Volkswagen Golf (1)
('Mk5', 2003, 2008, 1),
('Mk6', 2008, 2012, 1),

-- Passat (2)
('B6', 2005, 2010, 2),
('B7', 2010, 2014, 2),

-- Tiguan (3)
('Gen1', 2007, 2016, 3),
('Gen2', 2016, NULL, 3),

-- Audi A3 (4)
('8P', 2003, 2013, 4),
('8V', 2013, 2020, 4),

-- Audi A4 (5)
('B8', 2008, 2016, 5),
('B9', 2016, NULL, 5),

-- Audi Q5 (6)
('Gen1', 2008, 2017, 6),
('Gen2', 2017, NULL, 6),

-- Toyota Corolla (7)
('E150', 2006, 2013, 7),
('E170', 2013, 2019, 7),

-- Camry (8)
('XV40', 2006, 2011, 8),
('XV50', 2011, 2017, 8),

-- RAV4 (9)
('XA40', 2012, 2018, 9),
('XA50', 2018, NULL, 9),

-- Honda Civic (10)
('8th Gen', 2006, 2011, 10),
('9th Gen', 2011, 2015, 10),

-- Accord (11)
('8th Gen', 2008, 2013, 11),
('9th Gen', 2013, 2017, 11),

-- CR-V (12)
('3rd Gen', 2007, 2011, 12),
('4th Gen', 2011, 2016, 12),

-- Ford Focus (13)
('Mk2', 2004, 2011, 13),
('Mk3', 2011, 2018, 13),

-- Mustang (14)
('S197', 2005, 2014, 14),
('S550', 2015, NULL, 14),

-- Explorer (15)
('Gen5', 2011, 2019, 15),
('Gen6', 2019, NULL, 15);
-------------------------------------------------------------
INSERT INTO BodyType (BodyName)
VALUES
('Hatchback'),
('Sedan'),
('Wagon'),
('SUV'),
('Crossover'),
('Coupe'),
('Pickup'),
('Van'),
('Liftback'),
('Cabriolet');

-----------------------------------------------
INSERT INTO EngineType (TypeName)
VALUES
('Petrol'),
('Diesel'),
('Hybrid'),
('Electric'),
('LPG');

--------------
INSERT INTO Engine (Code, Capacity, Horsepower, EngineType_Name)
VALUES
-- Volkswagen / Audi
('1.9TDI', 1896, 105, 'Diesel'),
('2.0TDI', 1968, 150, 'Diesel'),
('1.4TSI', 1390, 122, 'Petrol'),
('2.0TSI', 1984, 200, 'Petrol'),

-- Toyota
('1ZR-FAE', 1598, 132, 'Petrol'),
('2AR-FE', 2494, 178, 'Petrol'),
('A25A-FKS', 2487, 208, 'Hybrid'),

-- Honda
('R18A', 1799, 140, 'Petrol'),
('K20A', 1998, 200, 'Petrol'),
('L15B', 1496, 182, 'Petrol'),

-- Ford
('Duratec20', 1999, 145, 'Petrol'),
('EcoBoost15', 1496, 180, 'Petrol'),
('Coyote50', 4951, 435, 'Petrol'),

-- Chevrolet
('Ecotec25', 2499, 197, 'Petrol'),
('Duramax28', 2776, 181, 'Diesel'),

-- Electric
('EV150', 0, 150, 'Electric');

-----------------------------------------------
INSERT INTO GenerationOption (Generation_ID, BodyName, Engine_ID)
VALUES
-- 1–2: Golf
(1, 'Hatchback', 1),  -- Mk5 + 1.9TDI
(2, 'Hatchback', 3),  -- Mk6 + 1.4TSI

-- 3–4: Passat
(3, 'Sedan', 2),      -- B6 + 2.0TDI
(4, 'Sedan', 4),      -- B7 + 2.0TSI

-- 5–6: Tiguan
(5, 'SUV', 2),        -- Gen1 + 2.0TDI
(6, 'SUV', 4),        -- Gen2 + 2.0TSI

-- 7–8: Audi A3
(7, 'Hatchback', 3),  -- 8P + 1.4TSI
(8, 'Hatchback', 4),  -- 8V + 2.0TSI

-- 9–10: Audi A4
(9,  'Sedan', 2),     -- B8 + 2.0TDI
(10, 'Sedan', 4),     -- B9 + 2.0TSI

-- 11–12: Audi Q5
(11, 'SUV', 2),       -- Gen1 + 2.0TDI
(12, 'SUV', 4),       -- Gen2 + 2.0TSI

-- 13–15: Toyota Corolla
(13, 'Sedan', 5),     
(14, 'Sedan', 6),     
(15, 'Sedan', 6);    


----------------------------------------------------------

INSERT INTO CarPartCatalogue (PartName, Manufacturer, WarrantyPeriod)
VALUES
('Oil Filter', 'Bosch', 12),
('Air Filter', 'Mahle', 12),
('Cabin Filter', 'Mann', 12),
('Front Brake Pads', 'TRW', 24),
('Rear Brake Pads', 'TRW', 24),
('Brake Disc Front', 'Brembo', 24),
('Brake Disc Rear', 'Brembo', 24),
('Spark Plug', 'NGK', 12),
('Ignition Coil', 'Bosch', 24),
('Fuel Pump', 'Delphi', 24),
('Alternator', 'Valeo', 24),
('Starter Motor', 'Valeo', 24),
('Timing Belt Kit', 'Gates', 36),
('Water Pump', 'GMB', 24),
('Radiator', 'Nissens', 24),
('AC Compressor', 'Denso', 24),
('Front Shock Absorber', 'KYB', 24),
('Rear Shock Absorber', 'KYB', 24),
('Clutch Kit', 'LUK', 24),
('Battery 12V 60Ah', 'Varta', 24);

---------------------------------------------------
INSERT INTO GenerationOptionPartFitment (Part_ID, GenerationOption_ID)
VALUES
-- Golf Mk5 / Mk6
(1, 1),   -- Oil Filter fits Golf Mk5
(2, 1),   -- Air Filter fits Golf Mk5
(3, 1),	  -- Cabin Filter fits Mk5
(3, 2),   -- Cabin Filter fits Mk6
(4, 2),   -- Front Brake Pads for Mk6

-- Passat B6 / B7
(5, 1),   -- Rear Brake Pads for Golf mk5
(5, 3),   -- Rear Brake Pads for B6
(6, 3),   -- Brake Disc Front B6
(7, 4),   -- Brake Disc Rear B7
(8, 4),   -- Spark Plug B7

-- Tiguan Gen1 / Gen2
(9, 5),   -- Ignition Coil Gen1
(10, 5),  -- Fuel Pump Gen1
(11, 6),  -- Alternator Gen2
(12, 6),  -- Starter Motor Gen2

-- Audi A3 8P / 8V
(13, 7),  -- Timing Belt Kit 8P
(14, 7),  -- Water Pump 8P
(15, 8),  -- Radiator 8V
(16, 8),  -- AC Compressor 8V

-- Audi A4 B8 / B9
(17, 9),  -- Front Shock Absorber B8
(18, 9),  -- Rear Shock Absorber B8
(19, 10), -- Clutch Kit B9
(20, 9), -- Battery Gen1 tiguan
(20, 8), -- Battery A3 8P
(20, 7), -- Battery B9
(20, 6), -- Battery B9
(20, 5); -- Battery B9

---------------------------------------------
INSERT INTO EnginePartFitment (Engine_ID, Part_ID)
VALUES
-- 1. 1.9 TDI (diesel VW)
(1, 1),   -- Oil Filter
(1, 2),   -- Air Filter

-- 2. 2.0 TDI
(2, 1),
(2, 5),   -- Rear Brake Pads

-- 3. 1.4 TSI (requires spark plugs & coil)
(3, 8),   -- Spark Plug
(3, 9),   -- Ignition Coil

-- 4. 2.0 TSI
(4, 8),
(4, 9),

-- 5. 1ZR-FAE (Toyota Corolla)
(5, 1),
(5, 14),  -- Water Pump

-- 6. 2AR-FE (Camry/RAV4)
(6, 1),
(6, 15),  -- Radiator

-- 7. A25A-FKS (Hybrid)
(7, 3),   -- Cabin Filter
(7, 16),  -- AC Compressor

-- 8. R18A (Honda Civic)
(8, 8),
(8, 13),  -- Timing Belt Kit

-- 9. K20A (Honda)
(9, 8),
(9, 14),

-- 10. L15B (Honda turbo)
(10, 8),
(10, 9),

-- 11. Duratec20 (Ford)
(11, 1),
(11, 10), -- Fuel Pump

-- 12. EcoBoost15
(12, 8),
(12, 9),

-- 13. Coyote50 (Mustang V8)
(13, 4),  -- Front Brake Pads
(13, 20), -- Battery

-- 14. Ecotec25 (Chevy)
(14, 1),
(14, 10),

-- 15. Duramax28 (Chevy diesel)
(15, 1),
(15, 10);

----------------------------------------------------------------------------
INSERT INTO CarPartOffer (BasePrice, PercentDiscount, ValidFrom, ValidTo, Part_ID)
VALUES
(29.99,  5, '2025-01-01', '2026-12-31', 1),   -- Oil Filter
(19.49,  0, '2025-01-01', '2026-12-31', 2),   -- Air Filter
(24.99, 10, '2025-01-01', '2026-12-31', 3),   -- Cabin Filter
(89.99, 15, '2025-01-01', '2026-12-31', 4),   -- Front Brake Pads
(79.99, 10, '2025-01-01', '2026-12-31', 5),   -- Rear Brake Pads
(129.99, 10, '2025-01-01', '2026-12-31', 6),  -- Brake Disc Front
(119.99, 10, '2025-01-01', '2026-12-31', 7),  -- Brake Disc Rear
(14.99,  0, '2025-01-01', '2026-12-31', 8),   -- Spark Plug
(59.99,  5, '2025-01-01', '2026-12-31', 9),   -- Ignition Coil
(149.99, 10, '2025-01-01', '2026-12-31', 10), -- Fuel Pump
(199.99, 10, '2025-01-01', '2026-12-31', 11), -- Alternator
(149.99,  5, '2025-01-01', '2026-12-31', 12), -- Starter Motor
(249.99, 20, '2025-01-01', '2026-12-31', 13), -- Timing Belt Kit
(99.99, 10, '2025-01-01', '2026-12-31', 14),  -- Water Pump
(189.99, 15, '2025-01-01', '2026-12-31', 15), -- Radiator
(229.99, 10, '2025-01-01', '2026-12-31', 16), -- AC Compressor
(89.99,  5, '2025-01-01', '2026-12-31', 17),  -- Front Shock Absorber
(79.99,  5, '2025-01-01', '2026-12-31', 18),  -- Rear Shock Absorber
(349.99, 15, '2025-01-01', '2026-12-31', 19), -- Clutch Kit
(299.99, 10, '2025-01-01', '2026-12-31', 20); -- Battery

-----------------------------------------------------------------------------------
INSERT INTO CarPartInventoryBatch (QuantityAvailable, QuantityReserved, UnitCost, Part_ID)
VALUES
(100, 10, 12.50, 1),   -- Oil Filter
(80,  5,  9.80,  2),   -- Air Filter
(60,  3, 11.20,  3),   -- Cabin Filter
(50,  8, 45.00, 4),    -- Front Brake Pads
(40,  6, 39.00, 5),    -- Rear Brake Pads
(30,  4, 70.00, 6),    -- Brake Disc Front
(30,  3, 65.00, 7),    -- Brake Disc Rear
(200, 15, 7.50,  8),   -- Spark Plug
(40,  5, 35.00, 9),    -- Ignition Coil
(25,  2, 95.00, 10),   -- Fuel Pump
(20,  3, 120.00, 11),  -- Alternator
(20,  2, 95.00, 12),   -- Starter Motor
(15,  2, 150.00, 13),  -- Timing Belt Kit
(25,  3, 55.00, 14),   -- Water Pump
(18,  2, 110.00, 15),  -- Radiator
(12,  1, 140.00, 16),  -- AC Compressor
(35,  4, 55.00, 17),   -- Front Shock Absorber
(35,  3, 50.00, 18),   -- Rear Shock Absorber
(10,  2, 190.00, 19),  -- Clutch Kit
(22,  3, 160.00, 20);  -- Battery 12V 60Ah

--------------------------------------------------------------------------------------------
INSERT INTO Customer (Name, Surname, Email, PhoneNumber, NIP)
VALUES
('Adam', 'Kowalski', 'adam.kowalski@example.com', '501234567', '1234567890'),
('Maria', 'Nowak', 'maria.nowak@example.com', '512345678', NULL),
('Piotr', 'Wiœniewski', 'piotr.wisniewski@example.com', '523456789', '9876543210'),
('Anna', 'Zieliñska', 'anna.zielinska@example.com', '534567890', NULL),
('Tomasz', 'Wójcik', 'tomasz.wojcik@example.com', '545678901', '1122334455'),
('Karolina', 'Lewandowska', 'karolina.lewandowska@example.com', '556789012', NULL),
('Marek', 'Szymañski', 'marek.szymanski@example.com', '567890123', '1029384756'),
('Natalia', 'D¹browska', 'natalia.dabrowska@example.com', '578901234', NULL),
('Pawe³', 'Krawczyk', 'pawel.krawczyk@example.com', '589012345', '5647382910'),
('Ewa', 'Kaczmarek', 'ewa.kaczmarek@example.com', '590123456', NULL),
('Krzysztof', 'Mazur', 'krzysztof.mazur@example.com', '601234567', NULL),
('Alicja', 'Jaworska', 'alicja.jaworska@example.com', '612345678', '0918273645'),
('Mateusz', 'Pawlak', 'mateusz.pawlak@example.com', '623456789', NULL),
('Olga', 'Sikora', 'olga.sikora@example.com', '634567890', '1928374650'),
('Jakub', 'Ostrowski', 'jakub.ostrowski@example.com', '645678901', NULL);


----------------------------------------------------------------------------------------------------
INSERT INTO Addresses (Line1, Line2, PostalCode, City, Customer_ID)
VALUES
('ul. Leœna 12',       NULL,       '80-001', 'Gdañsk',        1),
('ul. Wiosenna 5/3',   NULL,       '80-242', 'Gdañsk',        2),
('ul. D³uga 45',       'lok. 8',   '00-234', 'Warszawa',      3),
('ul. Kwiatowa 7',     NULL,       '02-326', 'Warszawa',      4),
('ul. Lipowa 14A',     NULL,       '30-011', 'Kraków',        5),
('ul. Krótka 2',       NULL,       '31-452', 'Kraków',        6),
('ul. S³oneczna 9',    NULL,       '60-108', 'Poznañ',        7),
('ul. Jesionowa 3/2',  NULL,       '61-350', 'Poznañ',        8),
('ul. £¹kowa 18',      'm. 12',    '40-221', 'Katowice',      9),
('ul. Polna 22',       NULL,       '40-600', 'Katowice',     10),
('ul. Nadmorska 5',    NULL,       '81-127', 'Gdynia',       11),
('ul. Morska 82',      'lok. 5',   '81-210', 'Gdynia',       12),
('ul. Piêkna 4',       NULL,       '50-305', 'Wroc³aw',      13),
('ul. Ogrodowa 6',     NULL,       '51-124', 'Wroc³aw',      14),
('ul. Spacerowa 9',    NULL,       '90-015', '£ódŸ',         15);

---------------------------------------------------------------------------
INSERT INTO PaymentMethod (PaymentName)
VALUES
('Card'),
('Cash'),
('Bank Transfer'),
('Online Payment'),
('Blik');

-----------------------------------------------------------------------------
INSERT INTO OrderStatus (StatusName)
VALUES
('New'),
('Processing'),
('Paid'),
('Shipped'),
('Delivered'),
('Cancelled');
------------------------------------------------------------------------------
INSERT INTO Orders (StatusName, CustomerNote, PaymentName, TotalCost, TransactionDate, Addresses_ID, Customer_ID)
VALUES
('New',        'Please ship as soon as possible.', 'Card',           149.99, '2025-01-05', 1,  1),
('Processing', NULL,                              'Online Payment',  89.50, '2025-01-08', 2,  2),
('Paid',       'Evening deli	very preferred.',     'Blik',           249.00, '2025-01-10', 3,  3),
('Shipped',    NULL,                              'Card',            59.99, '2025-01-12', 4,  4),
('Delivered',  'Thank you!',                      'Cash',           320.00, '2025-01-15', 5,  5),
('Cancelled',  'Order placed by mistake.',        'Online Payment', 145.00, '2025-01-17', 6,  6),
('Paid',       NULL,                              'Bank Transfer',  480.00, '2025-01-18', 7,  7),
('Processing', 'Please pack carefully.',          'Card',           199.99, '2025-01-20', 8,  8),
('New',        NULL,                              'Blik',            75.49, '2025-01-22', 9,  9),
('Delivered',  'Left with neighbor.',             'Card',           129.00, '2025-01-25', 10, 10),
('Paid',       NULL,                              'Cash',           349.99, '2025-01-26', 11, 11),
('Shipped',    'Please include a VAT invoice.',   'Bank Transfer',  220.00, '2025-01-28', 12, 12),
('Processing', NULL,                              'Card',            98.99, '2025-01-29', 13, 13),
('Delivered',  NULL,                              'Online Payment', 410.00, '2025-01-30', 14, 14),
('New',        'Urgent order – car in service.',  'Blik',           560.00, '2025-02-01', 15, 15),
('New',        'Urgent order – car in service.',  'Blik',           600.00, '2025-02-02', 15, 15);

---------------------------------------------------------------------------------------------------

INSERT INTO OrderedItem (QuantityOrdered, UnitPrice, Order_ID, Offer_ID)
VALUES
(2, 29.99 * 0.95, 1, 1),
(4, 19.49,        1, 2),
(6, 24.99 * 0.90, 2, 3),
(2, 89.99 * 0.85, 3, 4),
(1, 79.99 * 0.90, 4, 5),
(1, 129.99 * 0.90, 5, 6),
(1, 119.99 * 0.90, 5, 7),
(2, 14.99,         6, 8),
(1, 59.99 * 0.95,  7, 9),
(10, 149.99 * 0.90, 8, 10),
(1, 199.99 * 0.90, 9, 11),
(1, 149.99 * 0.95, 10, 12),
(1, 249.99 * 0.80, 11, 13),
(40, 99.99 * 0.90,  12, 14),
(1, 189.99 * 0.85, 12, 15),
(16, 229.99 * 0.90, 13, 16),
(1, 89.99 * 0.95,  14, 17),
(1, 79.99 * 0.95,  14, 18),
(1, 349.99 * 0.85, 15, 19),
(1, 299.99 * 0.90, 15, 19);

---------------------------------------------------------------------------------------------------------------
INSERT INTO DeliveryStatus (StatusName)
VALUES
('Pending'),
('Packed'),
('Shipped'),
('In Transit'),
('Out for Delivery'),
('Delivered'),
('Returned'),
('Lost'),
('Cancelled');
-----------------------------------------------------
INSERT INTO Delivery (StatusName, DeliveryCost, Order_ID)
VALUES
('Pending',          19.99,  1),
('Packed',           15.50,  2),
('Shipped',          12.00,  3),
('In Transit',       18.00,  4),
('Delivered',        20.00,  5),
('Cancelled',        10.00,  6),
('Shipped',          25.00,  7),
('Packed',           16.99,  8),
('Pending',          14.50,  9),
('Delivered',        21.00, 10),
('In Transit',       19.99, 11),
('Shipped',          17.49, 12),
('Packed',           13.99, 13),
('Delivered',        23.00, 14),
('Pending',          29.00, 15);
-----------------------------------------------------
INSERT INTO DeliveryItem (Delivery_ID, OrderedItem_ID)
VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 6),
(5, 7),
(6, 8),
(7, 9),
(8, 10),
(9, 11),
(10, 12),
(11, 13),
(12, 14),
(12, 15),
(13, 16),
(14, 17),
(14, 18),
(15, 19),
(15, 20);
---------------------------------------------------------------
INSERT INTO DeliveryItemBatch (ShippedQuantity, DeliveryItem_ID, Batch_ID)
VALUES
(1,  1,  1),
(1,  2,  2),
(1,  3,  3),
(2,  4,  4),
(1,  5,  5),
(1,  6,  6),
(1,  7,  7),
(2,  8,  8),
(1,  9,  9),
(1, 10, 10),
(1, 11, 11),
(1, 12, 12),
(1, 13, 13),
(1, 14, 14),
(1, 15, 15),
(1, 16, 16),
(1, 17, 17),
(1, 18, 18),
(1, 19, 19),
(1, 20, 20);
-----------------------------------------------------

