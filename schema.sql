DROP TABLE IF EXISTS owners CASCADE;
DROP TABLE IF EXISTS species CASCADE;
DROP TABLE IF EXISTS vets CASCADE;
DROP TABLE IF EXISTS animals CASCADE;
DROP TABLE IF EXISTS specializations;
DROP TABLE IF EXISTS visits;
--Create animals table
CREATE TABLE animals(
id			    INT GENERATED ALWAYS AS IDENTITY,
name			  VARCHAR(250),
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
  full_name    VARCHAR(250) NOT NULL,
  age          INT 
);
--Create a table named species
CREATE TABLE species(
id      SERIAL PRIMARY KEY,
name    VARCHAR(250) NOT NULL,
);

--Remove column species
ALTER TABLE animals DROP COLUMN species;

--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species (id);

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners (id);

--Create a table named vets
CREATE TABLE vets (
  id      SERIAL PRIMARY KEY,
  name    VARCHAR(50),
  age     INT,
  date_of_graduation DATE
);

--Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
    vet_id int NOT NULL,
    species_id int NOT NULL,
    CONSTRAINT specializations_pk PRIMARY KEY (vet_id,species_id),
    CONSTRAINT specializations_fk FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT specializations_fk_1 FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE RESTRICT ON UPDATE CASCADE
);
--Create a "join table" called visits 
CREATE TABLE visits (
    date_of_visit DATE NULL,
    vet_id        INT NULL,
    animal_id     INT NULL,
    CONSTRAINT visits_fk_1 FOREIGN KEY (vet_id) REFERENCES vets(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT visits_fk FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);
--Update visits table to add id column
ALTER TABLE visits ADD COLUMN id INT GENERATED ALWAYS AS IDENTITY;
-- Add Non-clustered index for tables
CREATE INDEX animal_id_index ON visits (animal_id);
CREATE INDEX vet_id_id_index ON visits (vet_id);
CREATE INDEX email_id_index ON owners (email);

CREATE TABLE treatment_histories(
  id INT GENERATED ALWAYS AS IDENTITY,
  medical_history_id INT,
  treatment_id INT,
  CONSTRAINT fk_medical_history_id
      FOREIGN KEY(medical_history_id)
        REFERENCES medical_histories(id)
          ON DELETE CASCADE,
  CONSTRAINT fk_treatment_id
      FOREIGN KEY(treatment_id)
        REFERENCES treatments(id)
          ON DELETE CASCADE,
  PRIMARY KEY(id)
);

CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL NOT NULL,
  quantity INT NOT NULL,
  total_price DECIMAL NOT NULL,
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id
     FOREIGN KEY(invoice_id)
       REFERENCES invoices(id)
         ON DELETE CASCADE,
  CONSTRAINT fk_treatment_id
      FOREIGN KEY(treatment_id)
        REFERENCES treatments(id)
          ON DELETE CASCADE,
  PRIMARY KEY (id)
);
