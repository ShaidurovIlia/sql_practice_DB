/*
 * Вывести продукты количество которых в продаже
 * меньше самого малого среднего количества продуктов в деталях заказов.
*/
SELECT product_name, units_in_stock
FROM products
WHERE units_in_stock < ALL
	  (SELECT AVG(quantity)
	   FROM order_details
	   GROUP BY product_id)
ORDER BY units_in_stock DESC;

/*
 * Напишите запрос, который выводит общую сумму фрахтов заказов для компаний-заказчиков для заказов,
 * стоимость фрахта которых больше или равна средней величине стоимости фрахта всех заказов,
 * а также дата отгрузки заказа должна находится во второй половине июля 1996 года.
*/
SELECT o.customer_id, SUM(o.freight) AS freight_sum
  FROM orders AS o
       INNER JOIN (SELECT customer_id, AVG(freight) AS freight_avg
                    FROM orders
                    GROUP BY customer_id) AS oa
       USING(customer_id)
 WHERE o.freight > oa.freight_avg
   AND o.shipped_date BETWEEN '1996-07-16' AND '1996-07-31'
 GROUP BY o.customer_id
 ORDER BY freight_sum;

/*
 * Вывести все товары (уникальные названия продуктов),
 * которых заказано ровно 10 единиц (используя подзапрос и без подзапроса).
*/
SELECT product_name
FROM products
WHERE product_id = ANY (SELECT product_id FROM order_details WHERE quantity = 10);

SELECT distinct product_name, quantity
FROM products
join order_details using(product_id)
where order_details.quantity = 10