CREATE DATABASE vet_clinic;

CREATE TABLE animals (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(20),
	date_of_birth DATE,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL
);

ALTER TABLE animals
ADD COLUMN species varchar(20);

CREATE TABLE owners (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	full_name VARCHAR(20),
	age INT
);

CREATE TABLE species (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(20)
);

ALTER TABLE animals 
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT,
ADD CONSTRAINT fk_animals_species FOREIGN KEY(species_id) REFERENCES species(id);