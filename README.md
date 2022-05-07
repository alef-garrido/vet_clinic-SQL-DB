![](https://img.shields.io/badge/Microverse-blueviolet)
![](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

# curriculum-databases-projects-template

>  RDB built using PostgreSQL, themed on a Veterinary Clinic.

## Getting Started

### Pre-Requirements
  PostgreSQL installation is needed. Version 14.2 was used for this project.

  - [Official Downloads](https://www.postgresql.org/download)

### Setup

You can run it on your local machine by cloning the project:
- Click on the green "Code" button above.
- Copy the link.
- On your Terminal run `git clone $<LINK>` replacing `$<LINK>` with the link you just copied.
- cd to the folder where you cloned the repo.
- Now you can run the commnads below as needed.

This repository includes files with plain SQL that can be used to recreate a database:

1. Run this in your bash terminal to gain access to postgres command line
~~~ bash
$ psql postgres
~~~

2. Create a new database with any name ('vet-clinic' is suggested), and connect to that database.
~~~ postgres
# CREATE DATABASE <database_name>;
# \c <database_name>
~~~

3. Use [schema.sql](./schema.sql) to create all tables. Copy and paste the content of this file into the postgres command line. That should create the tables in your database.
Now verify it. The following command displays all tables in your database:
~~~ postgres
# \d
~~~

4.  Use [data.sql](./data.sql) to populate tables with sample data. Copy and paste the content of this file into the postgres command line. That should create the tables in your database.
Now verify it. The following command displays all content in your selected table:
~~~ postgres
# SELECT * FROM <table_name>;
~~~

5. Check [queries.sql](./queries.sql) for examples of queries that can be run on a newly created database. Copy and paste the content of this file into the postgres command line. That should create the display an enormous list of queries that I prepared. It's recommended to run them individually for better understanding.
**Important note: this file might include queries that make changes in the database (e.g., remove records). Use them responsibly!**


## Authors

👤 Alef Garrido

- GitHub: [lef-garrido](https://github.com/alef-garrido)
- Twitter: [Alef_Garrido](https://twitter.com/Alef_Garrido)
- LinkedIn: [alef-g](https://www.linkedin.com/in/alef-g/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Microverse's Curriculum project
- Thanks to all code reviewers
- https://learnsql.com/
- https://www.tutorialspoint.com/sql

## 📝 License

This project is [MIT](./MIT.md) licensed.
