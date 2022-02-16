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