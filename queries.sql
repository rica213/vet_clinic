/*Queries that provide answers to the questions from all projects.*/

/* PROJECT 1 */

/* Find all animals whose name ends in "mon" */
SELECT * FROM animals WHERE name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019 */
SELECT name  FROM animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

/* List the name of all animals that are neutered and have less than 3 escape attempts */
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

/* List the date of birth of all animals named either "Agumon" or "Pikachu" */
SELECT date_of_birth FROM animals WHERE NAME='Agumon' OR NAME='Pikachu';

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/* Find all animals that are neutered */
SELECT * FROM animals WHERE neutered=true;

/* Find all animals not named Gabumon */
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


/* PROJECT 2 */

/* TRANSACTION */

/* Open transaction */
BEGIN;

/* CREATE A SAVEPOINT */
SAVEPOINT before_renaming_species;

/* Update the animals table by setting the species column to unspecified */
ALTER TABLE animals RENAME COLUMN species TO unspecified;

/* Roll back the change */
ROLLBACK TO SAVEPOINT before_renaming_species;

/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon*/
UPDATE animals SET species = 'Digimon' WHERE name LIKE '%mon';

/* Update the animals table by setting the species column to pokemon for all animals that don't have species already set.*/
UPDATE animals SET species = 'Pokemon' WHERE species IS NULL;

/* Commit the transaction */
COMMIT;

/* Open transaction */
BEGIN;

/* Create a SAVEPOINT */
SAVEPOINT before_deleting_records;

/* Delete all records in the animals table */
DELETE FROM animals;

/* Roll back the transaction */
ROLLBACK TO SAVEPOINT before_deleting_records;

/* Release savepoint */
RELEASE SAVEPOINT before_deleting_records;

/* Create a SAVEPOINT */
SAVEPOINT before_updating;

/* Delete all animals born after Jan 1st, 2022 */
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

/* Create a SAVEPOINT */
SAVEPOINT before_multiplying_by_minus_one;

/* Update all animals' weight to be their weight multiplied by -1 */
UPDATE animals SET weight_kg = weight_kg * -1;

/* Rollback to the savepoint */
ROLLBACK to SAVEPOINT before_multiplying_by_minus_one;

/* Update all animals' weights that are negative to be their weight multiplied by -1*/
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg <0;

/* Commit transaction */
COMMIT;

/* AGGREGATION */

/* How many animals are there? */
SELECT COUNT(id) AS num_animals FROM animals;

/* How many animals have never tried to escape? */
SELECT COUNT(id) AS num_animals FROM animals WHERE escape_attempts = 0;

/* What is the average weight of animals? */
SELECT AVG(weight_kg) AS avg_weight FROM animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT neutered,SUM(escape_attempts) AS escapees FROM animals GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT species,AVG(escape_attempts) AS avg_escapees FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'  GROUP BY species;
