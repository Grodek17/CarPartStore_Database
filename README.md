# CarPartStore — Relational Database Project

A relational database designed for an automotive parts store, developed as part of a university Database Systems course.

The project models vehicle compatibility, product catalogues, inventory, customers, orders, and deliveries using **Microsoft SQL Server (T-SQL)**.

**ERD:** [View the Entity Relationship Diagram](assets/erd.pdf)

## Database Design

The database models several interconnected business processes:

- **Vehicle compatibility:** Car brands, models, generations, engine types, body types, and compatible replacement parts.
- **Product catalogue:** Automotive parts, manufacturers, pricing, discounts, and available offers.
- **Inventory management:** Stock batches, available quantities, reserved quantities, and acquisition costs.
- **Order processing:** Customers, addresses, orders, ordered items, and payment methods.
- **Delivery management:** Deliveries, delivery items, and stock batches used to fulfil orders.

The schema uses primary and foreign keys to establish relationships between entities, alongside constraints that enforce data integrity.

## Entity Relationship Diagram

The database structure is illustrated in the ERD below.

[View the Entity Relationship Diagram](assets/erd.pdf)

## Technologies

- Microsoft SQL Server
- T-SQL
- SQL Server Management Studio (SSMS)
- Relational database design and ERD modelling

## Project Structure

```text
CarPartStore_Database/
├── schema/
│   ├── create_database.sql
│   ├── create_tables.sql
│   └── drop_tables.sql
├── data/
│   └── sample_data.sql
├── queries/
│   └── analytical_queries.sql
├── tests/
│   └── referential_actions.sql
├── assets/
│   └── erd.pdf
├── .gitignore
└── README.md
```

## Setup Instructions

**Requirements:** Microsoft SQL Server and a SQL client supporting T-SQL batches, such as SQL Server Management Studio.

To recreate the database, connect to your SQL Server instance and execute the following scripts in order:

1. `schema/create_database.sql` — creates the `AutoPartsStore` database if it does not already exist.
2. `schema/create_tables.sql` — creates tables, relationships, and constraints.
3. `data/sample_data.sql` — inserts sample records.
4. `queries/analytical_queries.sql` — runs analytical queries against the populated database.

The scripts have been tested locally using SQL Server Express and SSMS.

**Note:** Run the setup scripts against a fresh database. The table creation and data insertion scripts are not designed to be executed repeatedly without resetting the existing tables.

## Example SQL Queries

The repository includes SQL queries demonstrating relational data retrieval and business-oriented analysis, such as:

- Finding automotive parts compatible with a selected vehicle model.
- Calculating sales revenue and estimated profit for individual products.
- Determining how many vehicle models are supported by different parts.
- Summarizing customer activity, order counts, and spending.
- Analyzing inventory and order-related information.

These queries demonstrate SQL joins, filtering, grouping, aggregation, and working with related tables.

## Data Integrity

The schema includes:

- Primary keys and foreign keys.
- `NOT NULL` and `CHECK` constraints.
- Relationships between master data, transactional records, and inventory.
- Referential action testing using `ON UPDATE` and `ON DELETE` scenarios.

The `tests/referential_actions.sql` file contains exercises used to examine referential integrity behaviour. It should be executed separately from the standard database setup.

## Verification

The database was reconstructed locally in Microsoft SQL Server Express.

The following steps were verified:

- Successful database creation.
- Successful execution of the table creation script.
- Successful insertion of sample data.
- Execution of analytical queries returning results.

As a basic verification, the populated database contained **15 customers and 16 orders**.

The SQL queries execute successfully, although individual business calculations have not undergone comprehensive independent validation.

## Project Background

This project was developed during my university coursework to practise relational database modelling and SQL programming.

It provided practical experience in translating business requirements into database structures, defining relationships and integrity constraints, inserting test data, and retrieving information through multi-table SQL queries.

The repository preserves the academic implementation with an organized structure and reproducible setup instructions.