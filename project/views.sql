CREATE VIEW PizzaOrdersView AS
SELECT
  o.id AS order_id,
  c.name AS client_name,
  c.address AS client_address,
  p.name AS pizza_name,
  p.price AS pizza_price,
  p.weight AS pizza_weight,
  d.name AS drink_name,
  d.price AS drink_price
FROM
  Order o
  INNER JOIN Client c ON o.client_phone_number = c.phone_number
  LEFT JOIN Pizza p ON o.pizza_id = p.id
  LEFT JOIN Drink d ON o.drink_id = d.id;

SELECT * FROM PizzaOrdersView;

CREATE VIEW PizzaOrdersUpdatable AS
SELECT * FROM Order o
WHERE o.PRICE > 15;

UPDATE PizzaOrdersUpdatable
SET price = 14.99
WHERE client_phone_number = '+1 (678) 901-2345';

SELECT * FROM PIZZAORDERSUPDATABLE;

CREATE VIEW PizzaCostMoreThanTen AS
SELECT * FROM Pizza p
WHERE p.price > 10
WITH CHECK OPTION;

INSERT INTO PizzaCostMoreThanTen (name, price, weight, PRODUCT_NAME)
VALUES ('pizza', 11, 0.9, 'Tomatoes');