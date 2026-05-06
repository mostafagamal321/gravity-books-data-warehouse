SELECT 
    c.customer_id,
    ca.address_id,
    LTRIM(RTRIM(c.first_name))     AS first_name,
    LTRIM(RTRIM(c.last_name))      AS last_name,
    c.email,
    LTRIM(RTRIM(c.first_name)) + ' ' + 
        LTRIM(RTRIM(c.last_name))  AS full_name,
    a.street_number,
    a.street_name,
    a.city,
    co.country_name
FROM customer c
INNER JOIN customer_address ca  ON c.customer_id  = ca.customer_id
INNER JOIN address a            ON ca.address_id   = a.address_id
INNER JOIN country co           ON a.country_id    = co.country_id
WHERE ca.status_id = (
    SELECT status_id FROM address_status 
    WHERE address_status = 'Active'
)

SELECT 
    c.customer_id,
    ca.address_id,
    c.first_name,
    c.last_name,
    c.email,
    a.street_number,
    a.street_name,
    a.city,
    co.country_name,
    ast.address_status
FROM customer c
INNER JOIN customer_address ca ON c.customer_id = ca.customer_id
INNER JOIN address a           ON ca.address_id = a.address_id
INNER JOIN country co          ON a.country_id = co.country_id
INNER JOIN address_status ast  ON ca.status_id = ast.status_id
WHERE ast.address_status = 'Active'   -- Only current/active addresses

select * from gravity_dwh.dbo.Dim_Customer;


SELECT 
    c.customer_id,
    ca.address_id,
    c.first_name,
    c.last_name,
    c.email,
    ca.status_id,
    ca.address_id AS addr_lookup_id
FROM customer c
INNER JOIN customer_address ca 
    ON c.customer_id = ca.customer_id


ALTER TABLE Dim_Customer
ADD address_id INT;



ALTER TABLE Dim_Customer ALTER COLUMN start_date DATETIME NULL;
ALTER TABLE Dim_Customer ALTER COLUMN end_date   DATETIME NULL;


ALTER TABLE Dim_Customer ALTER COLUMN full_name  NVARCHAR(MAX);



select * from Bridge_BookAuthor;

SELECT 
    MIN(ol.line_id)                     AS line_id,
    o.order_id,
    CAST(o.order_date AS DATE)          AS order_date,
    o.customer_id,
    o.shipping_method_id,
    ol.book_id,
    ol.price,
    COUNT(*)                            AS quantity,    -- aggregated
    COALESCE(sm.cost, 0)                AS shipping_cost,
    oh.status_id
FROM cust_order o
INNER JOIN order_line ol        
    ON o.order_id = ol.order_id
INNER JOIN shipping_method sm   
    ON o.shipping_method_id = sm.method_id
LEFT JOIN order_history oh      
    ON o.order_id = oh.order_id
    AND oh.status_date = (
        SELECT MAX(oh2.status_date) 
        FROM order_history oh2 
        WHERE oh2.order_id = oh.order_id
    )
GROUP BY 
    o.order_id, o.order_date, o.customer_id,
    o.shipping_method_id, ol.book_id, ol.price,
    sm.cost, oh.status_id





    ALTER TABLE Fact_OrderLine
DROP COLUMN quantity



select * from Fact_OrderLine;