---
title: MySQL Reference
date: "2018-02-28"
publish: true
tags: ["databases", "mysql"]
---

## Logging in

1. `ssh` into the server with the MySQL database or use a program like `DataGrip`

```bash
ssh <USERNAME>@<SERVER_ADDRESS>
```

2. Connect to MySQL

```bash
mysql --user=<USERNAME> --password=<PASSWORD>
```

## Useful commands

- Listing all databases

```bash
# The terminal should look like `mysql>` if you are successfully logged in
show databases;
```

- Setting a database as active

```bash
use <DATABASE_NAME>;
```

- Showing the tables a database has

```bash
show tables;
```

- Show information about the connection such as the version, current user, current database, etc.

```bash
status;
```

- Show the column headers for all tables

```sql
select * from information_schema.columns
where table_schema = 'your_db'
order by table_name,ordinal_position
```