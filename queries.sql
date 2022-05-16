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
-- Who was the last animal seen by William Tatcher?
SELECT v.date, a.name as pokemon, v2."name" as vet 
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
WHERE v2."name" = 'William Tatcher'
ORDER BY v."date" desc limit 1;
-- How many different animals did Stephanie Mendez see?
SELECT count(distinct v.animal_id), v2."name" as vet
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
WHERE v2."name" = 'Stephanie Mendez'
GROUP by v2."name";
-- List all vets and their specialties, including vets with no specialties.
SELECT v."name", s2."name" 
FROM vets v 
LEFT JOIN specializations s on s.vet_id = v.id 
LEFT JOIN species s2 on s.species_id = s2.id ;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT v.date, a.name as pokemon, v2."name" as vet 
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
WHERE v2."name" = 'Stephanie Mendez' AND v."date" BETWEEN 'apr-01-2020' AND 'aug-30-2020';
-- What animal has the most visits to vets?
SELECT max(mycount.count), mycount.name

FROM (
	SELECT count(v."date"), a."name" 
	FROM visits v 
	JOIN animals a ON v.animal_id = a.id
	GROUP BY a."name"
) AS mycount

GROUP BY mycount.name

HAVING max(mycount.count) = (
	SELECT max(mycount.count)
	FROM (
		SELECT count(v."date"), a."name" 
		FROM visits v 
		JOIN animals a ON v.animal_id = a.id 
		GROUP BY a."name"
	) AS mycount
);
-- Who was Maisy Smith's first visit?
SELECT v.date, a.name AS pokemon, v2."name" AS vet 
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
WHERE v2."name" = 'Maisy Smith'
ORDER BY v."date" ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT v.date, a.name AS pokemon, v2."name" AS vet
FROM visits v 
JOIN animals a ON v.animal_id = a.id 
JOIN vets v2 ON v.vet_id = v2.id
ORDER BY v."date" DESC LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT v.date, animals, vets
FROM visits v 
JOIN animals ON v.animal_id = animals.id 
JOIN vets ON v.vet_id = vets.id
ORDER BY v."date" DESC LIMIT 1;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT count(visits.animal_id), species."name" AS specie
FROM visits
JOIN animals ON visits.animal_id = animals.id 
JOIN species ON animals.species_id = species.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets."name" = 'Maisy Smith'
GROUP BY  species."name"
ORDER BY count(visits.animal_id ) DESC LIMIT 1;