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




