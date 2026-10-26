USE AutoPartsStore;
GO

-------------------------------------------Query No. 1 -------------------------------------------------------------------------------
-- Find all matching parts for Volkswagen Golf Mk5 2005 hatchback 1.9tdi. Show names, prices, and quantities aviable for pucharse.
--view
SELECT
    CarBrand.Name,
    CarModel.Name,
    ModelGeneration.Name,
    GenerationOption.BodyName,
    CarPartCatalogue.PartName, CarPartCatalogue.Manufacturer, CarPartCatalogue.WarrantyPeriod AS Warranty_Months,
    CarPartOffer.BasePrice,
    SUM(CarPartInventoryBatch.QuantityAvailable) AS TotalQuantityAvailable
FROM CarBrand
INNER JOIN CarModel ON CarBrand.Brand_ID = CarModel.Brand_ID
INNER JOIN ModelGeneration ON ModelGeneration.Model_ID = CarModel.Model_ID
INNER JOIN GenerationOption ON GenerationOption.Generation_ID = ModelGeneration.ModelGeneration_ID
INNER JOIN GenerationOptionPartFitment ON GenerationOption.GenerationOption_ID = GenerationOptionPartFitment.GenerationOption_ID
INNER JOIN CarPartCatalogue ON CarPartCatalogue.Part_ID = GenerationOptionPartFitment.Part_ID
INNER JOIN CarPartOffer ON CarPartOffer.Part_ID = CarPartCatalogue.Part_ID
INNER JOIN CarPartInventoryBatch ON CarPartInventoryBatch.Part_ID = CarPartOffer.Part_ID
WHERE CarBrand.Name = 'Volkswagen' AND CarModel.Name = 'Golf'
  AND ModelGeneration.YearFrom <= 2005 AND (ModelGeneration.YearTo >= 2005 OR ModelGeneration.YearTo IS NULL)
  AND '2025-01-14' BETWEEN CarPartOffer.ValidFrom AND CarPartOffer.ValidTo
GROUP BY
    CarBrand.Name,
    CarModel.Name,
    ModelGeneration.Name,
    GenerationOption.BodyName,
    GenerationOption.Engine_ID,
    CarPartCatalogue.PartName,
    CarPartCatalogue.Manufacturer,
    CarPartCatalogue.WarrantyPeriod,
    CarPartOffer.BasePrice
HAVING SUM(CarPartInventoryBatch.QuantityAvailable) > 0
ORDER BY CarPartOffer.BasePrice ASC;


-------------------------------------------Query No. 2 -------------------------------------------------------------------------------
-- Top 5 most buyed things in the 2025, and their profit --

SELECT  TOP (5) CarPartCatalogue.PartName, CarPartCatalogue.Manufacturer , SUM(OrderedItem.QuantityOrdered) AS Units_sold, 
SUM(OrderedItem.QuantityOrdered * OrderedItem.UnitPrice ) AS revenue,
SUM(OrderedItem.QuantityOrdered * (OrderedItem.UnitPrice - CarPartInventoryBatch.UnitCost) ) AS net_profit
FROM OrderedItem
INNER JOIN CarPartOffer ON CarPartOffer.Offer_ID = OrderedItem.Offer_ID
INNER JOIN CarPartCatalogue ON CarPartCatalogue.Part_ID = CarPartOffer.Part_ID
INNER JOIN Orders ON Orders.Order_ID = OrderedItem.Order_ID
INNER JOIN CarPartInventoryBatch ON CarPartInventoryBatch.Part_ID = CarPartCatalogue.Part_ID
WHERE Orders.TransactionDate >= '2025-01-14' AND Orders.TransactionDate <= '2025-12-31'
GROUP BY CarPartCatalogue.PartName, CarPartCatalogue.Manufacturer
ORDER BY SUM(OrderedItem.QuantityOrdered * (OrderedItem.UnitPrice - CarPartInventoryBatch.UnitCost) ) DESC

-------------------------------------------Query No. 3--------------------------------------------------------------------------------
-- Car part compatible with most Car Models and their generations--

SELECT  CarPartCatalogue.PartName, CarPartCatalogue.Manufacturer , COUNT(CarModel.Model_ID) AS fitting_car_models
FROM CarPartCatalogue
INNER JOIN GenerationOptionPartFitment ON GenerationOptionPartFitment.Part_ID = CarPartCatalogue.Part_ID
INNER JOIN GenerationOption ON GenerationOption.GenerationOption_ID = GenerationOptionPartFitment.GenerationOption_ID
INNER JOIN ModelGeneration ON ModelGeneration.ModelGeneration_ID = GenerationOption.Generation_ID
INNER JOIN CarModel ON CarModel.Model_ID = ModelGeneration.Model_ID
INNER JOIN CarBrand ON CarBrand.Brand_ID = CarModel.Brand_ID
GROUP BY CarPartCatalogue.PartName, CarPartCatalogue.Manufacturer
ORDER BY COUNT(CarModel.Model_ID) DESC

-------------------------------------------Query No. 4--------------------------------------------------------------------------------
--Clients Dashboard: Number of orders, Total money spent, average order cost, last order date--

SELECT Customer.Customer_ID, Customer.Name, Customer.Surname, Customer.PhoneNumber, COUNT(Orders.Order_ID) AS OrdersCount, SUM(Orders.TotalCost) AS TotalSpend, 
    ROUND(AVG(Orders.TotalCost), 2) AS average_order_cost, MAX(Orders.TransactionDate) AS LastOrderDate
FROM Customer
INNER JOIN Orders ON Orders.Customer_ID = Customer.Customer_ID
WHERE Orders.StatusName <> 'Cancelled'
GROUP BY Customer.Customer_ID, Customer.Name, Customer.Surname, Customer.PhoneNumber
ORDER BY AVG(Orders.TotalCost) DESC


-------------------------------------------Query No. 5--------------------------------------------------------------------------------
--Parts not sold in the last year--

SELECT CarPartCatalogue.PartName, CarPartCatalogue.Manufacturer, CarPartOffer.BasePrice
FROM CarPartCatalogue
INNER JOIN CarPartOffer
    ON CarPartOffer.Part_ID = CarPartCatalogue.Part_ID
LEFT JOIN OrderedItem
    ON OrderedItem.Offer_ID = CarPartOffer.Offer_ID
LEFT JOIN Orders
    ON Orders.Order_ID = OrderedItem.Order_ID
   AND Orders.TransactionDate >= '2025-01-01'
   AND Orders.TransactionDate <  '2026-01-01'
WHERE Orders.Order_ID IS NULL;

-------------------------------------------Query No. 6--------------------------------------------------------------------------------
--Orders not fully realised in 2025 --

SELECT
    Orders.Order_ID,
    Orders.TransactionDate,
    Customer.Name,
    Customer.Surname,
    SUM(OrderedItem.QuantityOrdered) AS OrderedQty,
    ISNULL(ShippedTotals.ShippedQty, 0) AS ShippedQty,
    SUM(OrderedItem.QuantityOrdered) - ISNULL(ShippedTotals.ShippedQty, 0) AS MissingQty
FROM Orders
INNER JOIN Customer
    ON Customer.Customer_ID = Orders.Customer_ID
INNER JOIN OrderedItem
    ON OrderedItem.Order_ID = Orders.Order_ID
LEFT JOIN (
    SELECT
        Delivery.Order_ID,
        SUM(DeliveryItemBatch.ShippedQuantity) AS ShippedQty
    FROM Delivery
    INNER JOIN DeliveryItem
        ON DeliveryItem.Delivery_ID = Delivery.Delivery_ID
    INNER JOIN DeliveryItemBatch
        ON DeliveryItemBatch.DeliveryItem_ID = DeliveryItem.DeliveryItem_ID
    GROUP BY Delivery.Order_ID
) AS ShippedTotals
    ON ShippedTotals.Order_ID = Orders.Order_ID
WHERE Orders.StatusName <> 'Cancelled'
  AND Orders.TransactionDate >= '2025-01-01'
  AND Orders.TransactionDate <  '2025-12-31'
GROUP BY
    Orders.Order_ID,
    Orders.TransactionDate,
    Customer.Name,
    Customer.Surname,
    ShippedTotals.ShippedQty
HAVING SUM(OrderedItem.QuantityOrdered) - ISNULL(ShippedTotals.ShippedQty, 0) > 0
ORDER BY MissingQty DESC, Orders.TransactionDate ASC;

-------------------------------------------Query No. 7--------------------------------------------------------------------------------
--Delivery "snapshot" at the end of 2025--

SELECT
    Delivery.StatusName,
    COUNT(Delivery.Delivery_ID) AS DeliveriesCount,
    SUM(Delivery.DeliveryCost) AS TotalDeliveryCost,
    ROUND(AVG(Delivery.DeliveryCost), 2) AS AvgDeliveryCost,
    MIN(Delivery.DeliveryCost) AS MinDeliveryCost,
    MAX(Delivery.DeliveryCost) AS MaxDeliveryCost
FROM Delivery
INNER JOIN Orders
    ON Orders.Order_ID = Delivery.Order_ID
WHERE Orders.TransactionDate >= '2025-01-01'
  AND Orders.TransactionDate <  '2025-12-31'
GROUP BY Delivery.StatusName
HAVING COUNT(*) >= 1
ORDER BY DeliveriesCount DESC, AvgDeliveryCost DESC;
