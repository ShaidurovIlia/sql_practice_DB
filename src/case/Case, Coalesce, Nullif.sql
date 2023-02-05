/*
 * Вывести имя контакта заказчика, его город и страну,
 * отсортировав по возрастанию по имени контакта и городу,
 * а если город равен NULL, то по имени контакта и стране.
*/

SELECT contact_name, city, country
FROM customers
ORDER BY contact_name,
(
	CASE WHEN city IS NULL THEN country
		 ELSE city
	END
);

/*
 * Вывести наименование продукта, цену продукта и столбец со значениями
 * too expensive если цена >= 100
 * average если цена >=50 но < 100 low price если цена < 50
*/

SELECT product_name, unit_price,
CASE WHEN unit_price >= 100 THEN 'too expensive'
	 WHEN unit_price >= 50 AND unit_price < 100 THEN 'average'
	 ELSE 'low price'
END AS price
FROM products
ORDER BY unit_price DESC;

/*
 * Найти заказчиков, не сделавших ни одного заказа.
 * Вывести имя заказчика и значение 'no orders' если order_id = NULL.
*/

SELECT DISTINCT contact_name, COALESCE(order_id::text, 'no orders')
FROM customers
LEFT JOIN orders USING(customer_id)
WHERE order_id IS NULL;

/*
 * Вывести ФИО сотрудников и их должности.
 * В случае если должность = Sales Representative вывести вместо неё Sales Stuff.
*/

SELECT CONCAT(last_name, ' ', first_name),
        COALESCE(NULLIF(title, 'Sales Representative'), 'Sales Stuff') AS title
FROM employees;