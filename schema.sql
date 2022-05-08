/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
id			    INT GENERATED ALWAYS AS IDENTITY,
name			VARCHAR(250),
date_of_birth	DATE,
escape_attempts	INT,
neutered		BIT,
weight_kg		DECIMAL,
species     VARCHAR(250),
PRIMARY KEY(id)
);

CREATE TABLE owners(
  id           SERIAL PRIMARY KEY,
  full_name    VARCHAR(250),
  age          INT 
);

CREATE TABLE species(
id      SERIAL PRIMARY KEY,
name    VARCHAR(250)
);
