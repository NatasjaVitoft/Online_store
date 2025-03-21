CREATE TABLE sales (
    sale_id SERIAL,         
    region_id INT NOT NULL,
    sale_date DATE NOT NULL,
    total DECIMAL(10,2) NOT NULL
) PARTITION BY RANGE (EXTRACT(YEAR FROM sale_date));

CREATE TABLE sales_2022 PARTITION OF sales
    FOR VALUES FROM (2022) TO (2023);

CREATE TABLE sales_2023 PARTITION OF sales
    FOR VALUES FROM (2023) TO (2024);

CREATE TABLE sales_2024 PARTITION OF sales
    FOR VALUES FROM (2024) TO (2025);

ALTER TABLE sales_2022 ADD CONSTRAINT unique_id_2022 UNIQUE (sale_id);
ALTER TABLE sales_2023 ADD CONSTRAINT unique_id_2023 UNIQUE (sale_id);
ALTER TABLE sales_2024 ADD CONSTRAINT unique_id_2024 UNIQUE (sale_id);

INSERT INTO Sales (region_id, sale_date, total)
VALUES (5, '2024-10-10', 100),
       (3, '2023-10-10', 200),
       (1, '2022-10-10', 300);


SELECT * FROM Sales_2023