# Online_store


## Exercise 1: Denormalizing Total Sales per Order

### Pros and cons of denormalizing

The pros of denormalization, where the sum of each order is calculated and saved in a column in the Orders table, are that both the database and those writing the queries avoid time-consuming calculations every time the sum is needed for an order. By writing a function that sums up the OrderDetails and stores the result in a column, and creating a trigger to update the column whenever the OrderDetails table is updated, deleted, or inserted into, you can peform this process automatically(the SQL script for the trigger can be found in the folder "Scripts").

The cons are that it introduces redundancy as the total amount is already present in the OrderDetails table if you just calculate using the SUM() function. So adding a new column for something that already exists in another table introduces the redundancy, but because its a total calculated amount it is still not a information that directly exist in another table, and therefor its not completely a redundancy issue. Another potential risk is that if the total_amount is not updated correctly or if there is an issue with the trigger, errors could occur, which could lead to incorrect results being shown when quering the orders table. 

Also, if the total_amount is not frequently needed, introducing a new column and a trigger could result in unnecessary operations in the database, which could lead to performance overhead that are not necessary. In those cases, it might only make sense to denormalize if the total amount is something that is often queried or needed by the users. 