/* Populate database with sample data. */

INSERT INTO animals VALUES (DEFAULT, 'Agumon', '2020-02-03', 0, '1', 10.23);
INSERT INTO animals VALUES (DEFAULT, 'Gabumon', '2018-11-15', 1, '0', 8);
INSERT INTO animals VALUES (DEFAULT, 'Pikachu', '2021-06-07', 0, '1', 15.04);
INSERT INTO animals VALUES (DEFAULT, 'Devimon', '2017-05-12', 5, '1', 11);
INSERT INTO animals VALUES (DEFAULT, 'Charmander', '2020-02-08', 0, '0', -11);
INSERT INTO animals VALUES (DEFAULT, 'Plantmon', '2021-11-15', 3, '0', -5.7);
INSERT INTO animals VALUES (DEFAULT, 'Squirtle', '1993-04-02', 1, '1', -12.13);
INSERT INTO animals VALUES (DEFAULT, 'Angemon', '2005-06-12', 1, '1', -45.13);
INSERT INTO animals VALUES (DEFAULT, 'Boarmon', '2005-06-07', 7, '1', 20.4);
INSERT INTO animals VALUES (DEFAULT, 'Blossom', '1998-10-13', 3, '1', 17);
INSERT INTO animals VALUES (DEFAULT, 'Ditto', '2022-05-14', 4, '1', 22);
--Owners table insertions
INSERT INTO owners VALUES (DEFAULT, 'Sam Smith', 34);
INSERT INTO owners VALUES (DEFAULT, 'Jennifer Orwell', 19);
INSERT INTO owners VALUES (DEFAULT, 'Bob', 45);
INSERT INTO owners VALUES (DEFAULT, 'Melody Pond', 77);
INSERT INTO owners VALUES (DEFAULT, 'Dean Winchester', 14);
INSERT INTO owners VALUES (DEFAULT, 'Jodie Whittaker ', 38);

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS null;
COMMIT;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SELECT * FROM animals;
SAVEPOINT deleteByBirth;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO deleteByBirth;
SELECT * FROM animals;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * FROM animals;
COMMIT;

--Species table insertions
INSERT INTO species VALUES (DEFAULT, 'Pokemon');
INSERT INTO species VALUES (DEFAULT, 'Digimon');

--Modify animals' rows so it includes the species_id value
BEGIN;
UPDATE animals SET species_id = species.id FROM species
WHERE animals.name LIKE '%mon'
AND species.name Like 'Digimon';
COMMIT;

BEGIN;
UPDATE animals SET species_id = species.id FROM species
WHERE animals.species_id IS NULL
AND species.name LIKE 'Pokemon'; 
COMMIT;
--Sam Smith owns Agumon.
BEGIN;
UPDATE animals SET owner_id = owners.id FROM owners
WHERE animals.name = 'Agumon'
AND owners.full_name = 'Sam Smith'; 
COMMIT;
--Jennifer Orwell owns Gabumon and Pikachu.
BEGIN;
UPDATE animals SET owner_id = owners.id FROM owners
WHERE animals.name = 'Pikachu'
AND owners.full_name = 'Jennifer Orwell'
OR animals.name = 'Gabumon'
AND owners.full_name = 'Jennifer Orwell'; 
COMMIT;
--Bob owns Devimon and Plantmon.
BEGIN;
UPDATE animals SET owner_id = owners.id FROM owners
WHERE animals.name = 'Plantmon'
AND owners.full_name = 'Bob'
OR animals.name = 'Devimon'
AND owners.full_name = 'Bob';
COMMIT;
--Melody Pond owns Charmander, Squirtle, and Blossom.
BEGIN;
UPDATE animals
   SET owner_id = (SELECT id from owners WHERE full_name = 'Melody Pond')
   WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
COMMIT;
--Dean Winchester owns Angemon and Boarmon.
BEGIN;
UPDATE animals SET owner_id = owners.id FROM owners
WHERE animals.name = 'Angemon'
AND owners.full_name = 'Dean Winchester'
OR animals.name = 'Boarmon'
AND owners.full_name = 'Dean Winchester';
COMMIT;
-- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
INSERT INTO vets ("name",age,date_of_graduation)
VALUES ('William Tatcher',45,'2000-04-23');
-- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
INSERT INTO vets ("name",age,date_of_graduation)
VALUES ('Maisy Smith',26,'2019-01-17');
-- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
INSERT INTO vets ("name",age,date_of_graduation)
VALUES ('Stephanie Mendez',64,'1981-05-04');
-- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
INSERT INTO vets ("name",age,date_of_graduation)
VALUES ('Jack Harkness',38,'2008-06-08'); 
 -- Vet William Tatcher is specialized in Pokemon.
INSERT INTO specializations (species_id, vet_id)
SELECT s.id, v.id
FROM species s
JOIN vets v
ON s.name = 'Pokemon' AND v.name = 'William Tatcher';
 -- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
INSERT INTO specializations (species_id, vet_id) 
SELECT s.id, v.id 
FROM species s 
JOIN vets v 
ON s.name = 'Pokemon' AND v.name = 'Stephanie Mendez';

INSERT INTO specializations (species_id, vet_id) 
SELECT s.id, v.id 
FROM species s 
JOIN vets v 
ON s.name = 'Digimon' AND v.name = 'Stephanie Mendez';
 -- Vet Jack Harkness is specialized in Digimon.
INSERT INTO specializations (species_id, vet_id) 
SELECT s.id, v.id 
FROM species s 
JOIN vets v 
ON s.name = 'Digimon' AND v.name = 'Jack Harkness';
-- Agumon visited William Tatcher on May 24th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-05-24' 
FROM animals a 
JOIN vets v 
ON a.name = 'Agumon' AND v.name = 'William Tatcher';
-- Agumon visited Stephanie Mendez on Jul 22th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-07-22' 
FROM animals a 
JOIN vets v 
ON a.name = 'Agumon' AND v.name = 'Stephanie Mendez';
-- Gabumon visited Jack Harkness on Feb 2nd, 2021.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2021-02-02' 
FROM animals a 
JOIN vets v 
ON a.name = 'Gabumon' AND v.name = 'Jack Harkness';
-- Pikachu visited Maisy Smith on Jan 5th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-01-05' 
FROM animals a 
JOIN vets v 
ON a.name = 'Pikachu' AND v.name = 'Maisy Smith';
-- Pikachu visited Maisy Smith on Mar 8th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-03-08' 
FROM animals a 
JOIN vets v 
ON a.name = 'Pikachu' AND v.name = 'Maisy Smith';
-- Pikachu visited Maisy Smith on May 14th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-05-14' 
FROM animals a 
JOIN vets v 
ON a.name = 'Pikachu' AND v.name = 'Maisy Smith';
-- Devimon visited Stephanie Mendez on May 4th, 2021.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2021-05-04' 
FROM animals a 
JOIN vets v 
ON a.name = 'Devimon' AND v.name = 'Stephanie Mendez';
-- Charmander visited Jack Harkness on Feb 24th, 2021.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2021-02-24' 
FROM animals a 
JOIN vets v 
ON a.name = 'Charmander' AND v.name = 'Jack Harkness';
-- Plantmon visited Maisy Smith on Dec 21st, 2019.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2019-12-21' 
FROM animals a 
JOIN vets v 
ON a.name = 'Plantmon' AND v.name = 'Maisy Smith';
-- Plantmon visited William Tatcher on Aug 10th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-08-10' 
FROM animals a 
JOIN vets v 
ON a.name = 'Plantmon' AND v.name = 'William Tatcher';
-- Plantmon visited Maisy Smith on Apr 7th, 2021.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2021-04-07' 
FROM animals a 
JOIN vets v 
ON a.name = 'Plantmon' AND v.name = 'Maisy Smith';
-- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2019-09-29' 
FROM animals a 
JOIN vets v 
ON a.name = 'Squirtle' AND v.name = 'Stephanie Mendez';
-- Angemon visited Jack Harkness on Oct 3rd, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-10-03' 
FROM animals a 
JOIN vets v 
ON a.name = 'Angemon' AND v.name = 'Jack Harkness';
-- Angemon visited Jack Harkness on Nov 4th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-11-04' 
FROM animals a 
JOIN vets v 
ON a.name = 'Angemon' AND v.name = 'Jack Harkness';
-- Boarmon visited Maisy Smith on Jan 24th, 2019.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2019-01-24' 
FROM animals a 
JOIN vets v 
ON a.name = 'Boarmon' AND v.name = 'Maisy Smith';
-- Boarmon visited Maisy Smith on May 15th, 2019.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2019-05-15' 
FROM animals a 
JOIN vets v 
ON a.name = 'Boarmon' AND v.name = 'Maisy Smith';
-- Boarmon visited Maisy Smith on Feb 27th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-02-27' 
FROM animals a 
JOIN vets v 
ON a.name = 'Boarmon' AND v.name = 'Maisy Smith';
-- Boarmon visited Maisy Smith on Aug 3rd, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-08-03' 
FROM animals a 
JOIN vets v 
ON a.name = 'Boarmon' AND v.name = 'Maisy Smith';
-- Blossom visited Stephanie Mendez on May 24th, 2020.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-05-24' 
FROM animals a 
JOIN vets v 
ON a.name = 'Blossom' AND v.name = 'Stephanie Mendez';
-- Blossom visited William Tatcher on Jan 11th, 2021.
INSERT INTO visits (animal_id, vet_id, date) 
SELECT a.id, v.id, '2020-01-11' 
FROM animals a 
JOIN vets v 
ON a.name = 'Blossom' AND v.name = 'William Tatcher';