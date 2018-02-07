# MySQL Notes

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
