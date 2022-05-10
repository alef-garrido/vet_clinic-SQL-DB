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

--Create a table named owners 
CREATE TABLE owners(
  id           SERIAL PRIMARY KEY,
  full_name    VARCHAR(250),
  age          INT 
);
--Create a table named species
CREATE TABLE species(
id      SERIAL PRIMARY KEY,
name    VARCHAR(250)
);

--Remove column species
ALTER TABLE animals DROP COLUMN species;

--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species (id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners (id);