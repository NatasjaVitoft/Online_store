# Online_store


## Exercise 1: Denormalizing Total Sales per Order

### 

## Exercise 2: Denormalizing Customer Data in Orders

The downsides of this approach is that we replicate a lot of redundant data into each row of the orders table.
Information about customers is written several times, making is necessary to store unnecessary data, and breaking 3NF

I could be useful for avoiding joins on other tables, but we think this gain is very minimal in comparison to the cost of introducing redundacy. The original Customers table, has become completely useless, and future updates requires updates of both the customers table, and all corresponding rows in orders.
