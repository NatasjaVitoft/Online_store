# Online_store


## Exercise 1: Denormalizing Total Sales per Order

### Pros and cons of denormalizing

The pros of denormalization, where the sum of each order is calculated and saved in a column in the Orders table, are that both the database and those writing the queries avoid time-consuming calculations every time the sum is needed for an order. By writing a function that sums up the OrderDetails and stores the result in a column, and creating a trigger to update the column whenever the OrderDetails table is updated, deleted, or inserted into, you can peform this process automatically(the SQL script for the trigger can be found in the folder "Scripts").

The cons are that it introduces redundancy as the total amount is already present in the OrderDetails table if you just calculate using the SUM() function. So adding a new column for something that already exists in another table introduces the redundancy, but because its a total calculated amount it is still not a information that directly exist in another table, and therefor its not completely a redundancy issue. Another potential risk is that if the total_amount is not updated correctly or if there is an issue with the trigger, errors could occur, which could lead to incorrect results being shown when quering the orders table. 

Also, if the total_amount is not frequently needed, introducing a new column and a trigger could result in unnecessary operations in the database, which could lead to performance overhead that are not necessary. In those cases, it might only make sense to denormalize if the total amount is something that is often queried or needed by the users. 
### 

## Exercise 2: Denormalizing Customer Data in Orders

The downsides of this approach is that we replicate a lot of redundant data into each row of the orders table.
Information about customers is written several times, making is necessary to store unnecessary data, and breaking 3NF

I could be useful for avoiding joins on other tables, but we think this gain is very minimal in comparison to the cost of introducing redundacy. The original Customers table, has become completely useless, and future updates requires updates of both the customers table, and all corresponding rows in orders.

## Exercise 4: Using List Partitioning for Regional Data

List partitions optimizes SELECT queries. Especially with conditional checks.
To add a new region a new partition table has to be created for the new category. Future inserts will be distrbuted automatically.
It depends on what kind of queries is usually run. if the range is the most often conditioned, it makes the most sense to partion it like that.

##  Exercise 5: Checking Query Performance with Partitioning

When running `EXPLAIN` or `EXPLAIN ANALYSE` in postgreSQL, is not available, but instead shows returned and filtered rows.
It automatically decides which partition to examine, meaning there is no runtime difference between querying the "parent" table and the created partition directly.


# Query Optimization Exercises

## Exercise 3: Identifying and Fixing the N+1 Query Problem

The N+1 problems happens becuase we have to make an extra query for every row returned by the original query,
making the operation inefficient

It can be optimized like so:

```sql
SELECT order_id, orders.customer_id, name
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id
WHERE order_date > '2023-01-01'
```

Where we get all the customers names as part of the first query by extending the result. Including null values among customer names, if not set!

## Exercise 4: Optimizing Aggregate Queries with Indexes

![Select Query](image.png)

By running the query we are sequentially scanning the table twice with a pretty high cost. This means it it not indexed. We can also se that no indexes are present in any of the tables.

After adding indexes to product_id ad category, we can se that the query cost is much lower:
![Optimized query](image-1.png)

The does not change at all by adding a composite index on product_id and total amount though.