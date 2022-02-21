SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-30';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name NOT IN('Gabumon');

SELECT * FROM animals WHERE weight_kg BETWEEN '10.4' AND '17.3';

-- Transaction update species column to unspecified and rollback
BEGIN;
  UPDATE animals
  SET species = 'unspecified';
ROLLBACK;

-- Transaction update species column to pokemon or digimon and commit
BEGIN;
  UPDATE animals
  SET species = 'digimon'
  WHERE name LIKE '%mon';

  UPDATE animals
  SET species = 'pokemon'
  WHERE name NOT LIKE '%mon';
COMMIT;

-- Transaction delete all animals and rollback
BEGIN;
  DELETE FROM animals
ROLLBACK;

-- Transaction that updates negative weights
BEGIN;
	DELETE FROM animals WHERE date_of_birth > '2022-01-01';

	SAVEPOINT DELETE_ALL_ANIMALS_SAVEPOINT;

	UPDATE animals
	SET weight_kg = weight_kg * -1;

	ROLLBACK TO DELETE_ALL_ANIMALS_SAVEPOINT;

	UPDATE animals
	SET weight_kg = weight_kg * -1
	WHERE weight_kg < 0;
COMMIT;

-- Select all animals numbers
SELECT COUNT(*) AS "Animals Count" FROM animals;
-- Select all animals that never tried to escape
SELECT COUNT(*) AS "Animals Count" FROM animals 
WHERE escape_attempts = 0;
-- Select average weight of all animals
SELECT CONCAT(ROUND(AVG(weight_kg), 2), ' kg') AS "Average Weight" FROM animals; 
-- Display animal with maximum escape attempts
SELECT * FROM animals 
WHERE escape_attempts 
IN (SELECT MAX(escape_attempts) FROM animals); 
-- Display the minimum and maximum weight of each type of animal
SELECT species, 
MIN(weight_kg) AS "Min Weight", 
MAX(weight_kg) AS "Max Weight" 
FROM animals 
GROUP BY species;
-- Display the average number of escape attempts per animal type 
-- of those born between 1990 and 2000
SELECT species, 
AVG(escape_attempts) AS "Average Escape Attempts"
FROM animals 
Where date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Get animals belong to Melody Pond
SELECT animals.name AS "Animals Name" FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon
SELECT animals.name AS "Animals Name" FROM animals 
INNER JOIN species 
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, and include those that don't own any animal
SELECT owners.full_name AS "Owner Name",
animals.name AS "Animals Name"
FROM owners 
LEFT JOIN animals 
ON animals.owner_id = owners.id;

-- How many animals are there per species
SELECT species.name AS "Species Name",
COUNT(*) AS "Count"
FROM animals 
INNER JOIN species 
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell
SELECT owners.full_name AS "Owner Name",
animals.name AS "Animal Name"
FROM animals 
INNER JOIN species 
ON animals.species_id = species.id
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' 
AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.name AS "Animals Name" FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

-- Who owns the most animals
SELECT owners.full_name AS "Owner Name",
COUNT(animals.id) AS "Animals Count" 
FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(animals.id) DESC LIMIT 1;

-- The last animal seen by William Tatche
SELECT animals.name AS "Animal Name",
visits.date_of_the_visits AS "Date of visits"
FROM animals 
INNER JOIN visits
ON animals.id = visits.animals_id
INNER JOIN vets
ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_the_visits DESC
LIMIT 1; 

-- Different animals Stephanie Mendez see
SELECT COUNT(DISTINCT animals) AS "Animal COUNT"
FROM animals 
INNER JOIN visits
ON animals.id = visits.animals_id
INNER JOIN vets
ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez'; 

-- List all vets and their specialties, including vets with no specialties
SELECT vets.name AS "Vets Name",
STRING_AGG(species.name, ' , ') AS "Species Name"
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vets_id
LEFT JOIN species
ON species.id = specializations.species_id
GROUP BY vets.name; 

-- all animals that visited Stephanie Mendez between April 1st and August 30th, 2020
SELECT animals.name AS "Animal Name"
FROM animals 
INNER JOIN visits
ON animals.id = visits.animals_id
INNER JOIN vets
ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND visits.date_of_the_visits BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets
SELECT animals.name AS "Animal Name",
COUNT(animals) AS "Animals Count"
FROM animals 
INNER JOIN visits
ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY COUNT(animals) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit
SELECT animals.name AS "Animal Name",
visits.date_of_the_visits AS "Date of visits"
FROM animals 
INNER JOIN visits
ON animals.id = visits.animals_id
INNER JOIN vets
ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_the_visits
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit
SELECT animals.name AS "Animal Name",
visits.date_of_the_visits AS "Date of visits",
vets.name AS "Vets Name"
FROM animals 
INNER JOIN visits
ON animals.id = visits.animals_id
INNER JOIN vets
ON visits.vets_id = vets.id
ORDER BY visits.date_of_the_visits DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species
SELECT COUNT(visits) AS "Number of visits"
FROM vets
LEFT JOIN visits
ON visits.vets_id = vets.id
LEFT JOIN specializations
ON specializations.vets_id = vets.id
LEFT JOIN species
ON species.id = specializations.species_id
WHERE species IS NULL;

-- specialty should Maisy Smith consider getting
SELECT species.name AS "Species Name",
COUNT(species.name) AS "Number of visits"
FROM vets
INNER JOIN visits
ON visits.vets_id = vets.id
INNER JOIN animals
ON animals.id = visits.animals_id
INNER JOIN species
ON species.id = animals.species_id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.name) DESC
LIMIT 1;

-- Analyze animals_id
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animals_id = 4;

-- Analyze vets_id
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;