/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE neutered  IN  ('1') AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name  IN  ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered IN ('1');
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.3 AND 17.4;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) as attempts FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
--What animals belong to Melody Pond?
SELECT a.name, a.owner_id, o.id, o.full_name
FROM animals a 
LEFT  JOIN owners o
ON a.owner_id = o.id 
WHERE o.full_name = 'Melody Pond';
--List of all animals that are pokemon (their type is Pokemon).
SELECT *
FROM animals a
INNER JOIN species s
ON a.species_id = s.id
WHERE s.name = 'Pokemon';
--List all owners and their animals, remember to include those that don't own any animal.
SELECT a.name, o.full_name
FROM animals a
RIGHT JOIN owners o
ON a.owner_id = o.id;
--How many animals are there per species?
SELECT COUNT(a.name), s.name
FROM animals a
INNER JOIN species s
ON a.species_id = s.id
GROUP BY s.name;
--List all Digimon owned by Jennifer Orwell.
SELECT a.name
FROM animals a
LEFT JOIN owners o
ON a.owner_id = o.id
WHERE o.full_name = 'Jennifer Orwell'
AND a.species_id = 2; 
--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name
FROM animals a
LEFT JOIN owners o
ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester'
AND a.escape_attempts = 0; 
--Who owns the most animals?
SELECT COUNT(a.owner_id) as owned, o.full_name
FROM animals a
INNER JOIN owners o
ON a.owner_id = o.id
GROUP BY o.full_name;
