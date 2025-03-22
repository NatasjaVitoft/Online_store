# Online_store

## Denormalization & Partitions

### Exercise 1: Denormalizing Total Sales per Order

The pros of denormalization, where the sum of each order is calculated and saved in a column in the Orders table, are that both the database and those writing the queries avoid time-consuming calculations every time the sum is needed for an order. By writing a function that sums up the OrderDetails and stores the result in a column, and creating a trigger to update the column whenever the OrderDetails table is updated, deleted, or inserted into, you can peform this process automatically(the SQL script for the trigger can be found in the folder "Scripts").

The cons are that it introduces redundancy as the total amount is already present in the OrderDetails table if you just calculate using the SUM() function. So adding a new column for something that already exists in another table introduces the redundancy, but because its a total calculated amount it is still not a information that directly exist in another table, and therefor its not completely a redundancy issue. Another potential risk is that if the total_amount is not updated correctly or if there is an issue with the trigger, errors could occur, which could lead to incorrect results being shown when quering the orders table. 

Also, if the total_amount is not frequently needed, introducing a new column and a trigger could result in unnecessary operations in the database, which could lead to performance overhead that are not necessary. In those cases, it might only make sense to denormalize if the total amount is something that is often queried or needed by the users. 

### Exercise 2: Denormalizing Customer Data in Orders

The downsides of this approach is that we replicate a lot of redundant data into each row of the orders table. Information about customers is written several times, making is necessary to store unnecessary data, and breaking 3NF

I could be useful for avoiding joins on other tables, but we think this gain is very minimal in comparison to the cost of introducing redundacy. The original Customers table, has become completely useless, and future updates requires updates of both the customers table, and all corresponding rows in orders.

### Exercise 3: Using Partitioning for Sales Data

The pros of using partitioning is if you have a very large table containing many rows and a lot of data. By breaking the table into smaller parts it can improve the speed of the queries and also make it more managable for those writing the queries and accessing the data. 

If you try and insert a sale for a year that doesnt have a partition you get this error :  "ERROR:  Partition key of the failing row contains (EXTRACT(year FROM sale_date)) = (2020).no partition of relation "sales" found for row". So when a new year starts you have to create a new partition for that year or else the data for that year cannot be inserted. A good idea would be to implement this automatically so you dont suddenly have a situation where data cannot be inserted. 

### Exercise 4: Using List Partitioning for Regional Data

List partitions optimizes SELECT queries. Especially with conditional checks. To add a new region a new partition table has to be created for the new category. Future inserts will be distrbuted automatically. It depends on what kind of queries is usually run. if the range is the most often conditioned, it makes the most sense to partion it like that.


### Query Optimization Exercises
When running EXPLAIN or EXPLAIN ANALYSE in postgreSQL, is not available, but instead shows returned and filtered rows. It automatically decides which partition to examine, meaning there is no runtime difference between querying the "parent" table and the created partition directly.



