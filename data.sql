INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES 
	('Agumon', '2020-02-03', 0, false, 10.23),
	('Gabumon', '2018-11-15', 2, true, 8),
	('Pikachu', '2021-01-07', 1, true, 15.04), 
	('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)  
VALUES 
	('Charmander', '2020-02-08', 0, false, -11),
	('Plantmon', '2022-11-15', 2, true, -5.7),
	('Squirtle', '1993-04-02', 3, false, -12.13),
	('Angemon', '2005-06-12', 1, true, -45),
	('Boarmon', '2005-06-07', 7, true, 20.4),
	('Blossom', '1998-08-13', 3, true, 17);

INSERT INTO owners (full_name, age)  
VALUES 
	('Sam Smith', 34),
	('Jennifer Orwell', 19),
	('Bob', 45),
	('Melody Pond', 77),
	('Dean Winchester', 14),
	('Jodie Whittaker', 38);

INSERT INTO species (name)  
VALUES 
	('Pokemon'),
	('Digimon');

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE name NOT LIKE '%mon';

UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name in ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = 3
WHERE name in ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = 4
WHERE name in ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = 5
WHERE name in ('Angemon', 'Boarmon');

INSERT INTO vets (name, age, date_of_graduation) 
VALUES
	('William Tatcher', 45, '2000-4-23'),
	('Maisy Smith', 26, '2013-1-17'),
	('Stephanie Mendez', 64, '1981-5-4'),
	('Jack Harkness', 38, '2008-6-8');

INSERT INTO specializations (species_id, vets_id) 
VALUES
	((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
	((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
	((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
	((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));

INSERT INTO visits (animals_id, vets_id, date_of_the_visits) 
VALUES
	((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-5-24'),
	((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-7-22'),
	((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-2-2'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-1-5'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-3-8'),
	((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-3-14'),
	((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-3-4'),
	((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-2-24'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-8-10'),
	((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-4-7'),
	((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-9-29'),
	((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-3'),
	((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-4'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-1-24'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-5-15'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-2-27'),
	((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-8-3'),
	((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-8-24'),
	((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-1-11');

INSERT INTO visits (animals_id, vets_id, date_of_the_visits) 
	SELECT * FROM (SELECT id FROM animals) animal_ids, 
	(SELECT id FROM vets) vets_ids, 
	generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

INSERT INTO owners (full_name, email) 
	SELECT 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';

