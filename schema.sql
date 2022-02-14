create database vet_clinic;

create table animals (
	id int,
	name varchar(20),
	date_of_birth date,
	escape_attempts int,
	neutered boolean,
	weight_kg decimal
);