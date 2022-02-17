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