-- **Q6.** Calculate the total cost of all book orders placed in 2024,
-- grouped by fulfillment status.

SELECT "FulfillmentStatus", SUM("Cost") AS "total cost"
FROM book_orders WHERE "OrderDate" >='2024-01-01'
GROUP BY "FulfillmentStatus";
