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

ALTER TABLE animals
ADD COLUMN owner_id INT,
ADD CONSTRAINT fk_animals_owners FOREIGN KEY(owner_id) REFERENCES owners(id);

CREATE TABLE vets (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(255),
	age INT,
	date_of_graduation DATE
);

CREATE TABLE specializations (
	species_id INT, 
	vets_id INT,
	FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY (species_id, vets_id)
);

CREATE TABLE visits (
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	animals_id INT, 
	vets_id INT,
	date_of_the_visits DATE,
	FOREIGN KEY (animals_id) REFERENCES animals (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX animals_visits_idx ON visits(animals_id);

CREATE INDEX vets_visits_idx ON visits(vets_id);