/*Queries that provide answers to the questions from all projects.*/
/* PROJECT 1 */
/* Find all animals whose name ends in "mon" */
SELECT
  *
FROM
  animals
WHERE
  name LIKE '%mon';

/* List the name of all animals born between 2016 and 2019 */
SELECT
  name
FROM
  animals
WHERE
  EXTRACT(
    YEAR
    FROM
      date_of_birth
  ) BETWEEN 2016
  AND 2019;

/* List the name of all animals that are neutered and have less than 3 escape attempts */
SELECT
  name
FROM
  animals
WHERE
  neutered = true
  AND escape_attempts < 3;

/* List the date of birth of all animals named either "Agumon" or "Pikachu" */
SELECT
  date_of_birth
FROM
  animals
WHERE
  NAME = 'Agumon'
  OR NAME = 'Pikachu';

/* List name and escape attempts of animals that weigh more than 10.5kg */
SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weight_kg > 10.5;

/* Find all animals that are neutered */
SELECT
  *
FROM
  animals
WHERE
  neutered = true;

/* Find all animals not named Gabumon */
SELECT
  *
FROM
  animals
WHERE
  name NOT LIKE 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg) */
SELECT
  *
FROM
  animals
WHERE
  weight_kg BETWEEN 10.4
  AND 17.3;

/* PROJECT 2 */
/* TRANSACTION */
/* Open transaction */
BEGIN;

/* CREATE A SAVEPOINT */
SAVEPOINT before_renaming_species;

/* Update the animals table by setting the species column to unspecified */
ALTER TABLE
  animals RENAME COLUMN species TO unspecified;

/* Roll back the change */
ROLLBACK TO SAVEPOINT before_renaming_species;

/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon*/
UPDATE
  animals
SET
  species = 'Digimon'
WHERE
  name LIKE '%mon';

/* Update the animals table by setting the species column to pokemon for all animals that don't have species already set.*/
UPDATE
  animals
SET
  species = 'Pokemon'
WHERE
  species IS NULL;

/* Commit the transaction */
COMMIT;

/* Open transaction */
BEGIN;

/* Create a SAVEPOINT */
SAVEPOINT before_deleting_records;

/* Delete all records in the animals table */
DELETE FROM
  animals;

/* Roll back the transaction */
ROLLBACK TO SAVEPOINT before_deleting_records;

/* Release savepoint */
RELEASE SAVEPOINT before_deleting_records;

/* Create a SAVEPOINT */
SAVEPOINT before_updating;

/* Delete all animals born after Jan 1st, 2022 */
DELETE FROM
  animals
WHERE
  date_of_birth > '2022-01-01';

/* Create a SAVEPOINT */
SAVEPOINT before_multiplying_by_minus_one;

/* Update all animals' weight to be their weight multiplied by -1 */
UPDATE
  animals
SET
  weight_kg = weight_kg * -1;

/* Rollback to the savepoint */
ROLLBACK to SAVEPOINT before_multiplying_by_minus_one;

/* Update all animals' weights that are negative to be their weight multiplied by -1*/
UPDATE
  animals
SET
  weight_kg = weight_kg * -1
WHERE
  weight_kg < 0;

/* Commit transaction */
COMMIT;

/* AGGREGATION */
/* How many animals are there? */
SELECT
  COUNT(id) AS num_animals
FROM
  animals;

/* How many animals have never tried to escape? */
SELECT
  COUNT(id) AS num_animals
FROM
  animals
WHERE
  escape_attempts = 0;

/* What is the average weight of animals? */
SELECT
  AVG(weight_kg) AS avg_weight
FROM
  animals;

/* Who escapes the most, neutered or not neutered animals? */
SELECT
  neutered,
  SUM(escape_attempts) AS escapees
FROM
  animals
GROUP BY
  neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT
  species,
  MIN(weight_kg) AS min_weight,
  MAX(weight_kg) AS max_weight
FROM
  animals
GROUP BY
  species;

/* What is the average number of escape attempts per animal type of those born between 1990 and 2000? */
SELECT
  species,
  AVG(escape_attempts) AS avg_escapees
FROM
  animals
WHERE
  date_of_birth BETWEEN '1990-01-01'
  AND '2000-12-31'
GROUP BY
  species;

/* PROJECT 3 */
/* QUERIES IN MULTIPLE TABLES */
/* What animals belong to Melody Pond? */
SELECT
  *
FROM
  animals
WHERE
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name LIKE 'Melody Pond'
    LIMIT
      1
  );

/* List of all animals that are pokemon */
SELECT
  *
FROM
  animals
WHERE
  species_id = (
    SELECT
      id
    FROM
      species
    WHERE
      name LIKE 'Pokemon'
  );

/* List all owners and their animals, including those that don't own any animal */
SELECT
  owners.full_name,
  animals.name
FROM
  owners
  LEFT JOIN animals ON owners.id = animals.owner_id;

/* How many animals are there per species? */
SELECT
  species.name,
  COUNT(*)
FROM
  animals
  JOIN species ON animals.species_id = species.id
GROUP BY
  species.id,
  species.name;

/* List all Digimon owned by Jennifer Orwell */
SELECT
  *
FROM
  animals
WHERE
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name LIKE 'Jennifer Orwell'
  )
  AND species_id = (
    SELECT
      id
    FROM
      species
    WHERE
      name LIKE 'Digimon'
  );

/* List all animals owned by Dean Winchester that haven't tried to escape 
 */
SELECT
  *
FROM
  animals
WHERE
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      name LIKE 'Dean Winchester'
  )
  AND escape_attempts = 0;

/* Who owns the most animals */
SELECT
  owners.full_name,
  COUNT(*) AS num_animals
FROM
  owners
  JOIN animals ON owners.id = animals.owner_id
GROUP BY
  owners.id
ORDER BY
  num_animals DESC
LIMIT
  1;

/* PROJECT 3 */
/* Who was the last animal seen by William Tatcher? */
SELECT
  *
FROM
  animals
  INNER JOIN visits ON visits.animals_id = animals.id
  INNER JOIN vets ON vets.id = visits.vets_id
WHERE
  vets.name = 'William Tatcher'
ORDER BY
  date_of_visit desc
LIMIT
  1;

/* How many different animals did Stephanie Mendez see? */
SELECT
  DISTINCT *
FROM
  animals
  INNER JOIN visits ON visits.animals_id = animals.id
  INNER JOIN vets ON vets.id = visits.vets_id
WHERE
  vets.name = 'Stephanie Mendez';

/* List all vets and their specialties, including vets with no specialties */
SELECT
  *
FROM
  vets
  LEFT JOIN specializations ON specializations.vet_id = vets.id
  LEFT JOIN species ON species.id = specializations.specie_id;

/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020 */
SELECT
  *
FROM
  animals
  INNER JOIN visits ON visits.animals_id = animals.id
  INNER JOIN vets ON vets.id = visits.vets_id
WHERE
  vets.name = 'Stephanie Mendez'
  AND date_of_visit BETWEEN '2020-04-01'
  AND '2020-04-30';

/* What animal has the most visits to vets? */
SELECT
  animals.name AS animal_name,
  COUNT(animals.name) AS number_of_visited
FROM
  animals
  INNER JOIN visits ON visits.animals_id = animals.id
  INNER JOIN vets ON vets.id = visits.vets_id
GROUP BY
  animals.name
ORDER BY
  number_of_visited DESC
LIMIT
  1;

/* Who was Maisy Smith's first visit? */
SELECT
  *
FROM
  animals
  INNER JOIN visits ON visits.animals_id = animals.id
  INNER JOIN vets on vets.id = visits.vets_id
WHERE
  vets.name = 'Maisy Smith'
ORDER BY
  date_of_visit ASC
LIMIT
  1;

/* Details for most recent visit: animal information, vet information, and date of visit. */
SELECT
  *
FROM
  animals
  INNER JOIN visits ON visits.animals_id = animals.id
  INNER JOIN vets ON vets.id = visits.vets_id
ORDER BY
  date_of_visit DESC
LIMIT
  1;

/* How many visits were with a vet that did not specialize in that animal's species? */
SELECT
  COUNT(visits.id) AS number_of_visits
FROM
  animals
  INNER JOIN visits ON visits.animals_id = animals.id
  INNER JOIN vets ON vets.id = visits.vets_id
  LEFT JOIN specializations ON specializations.vet_id = vets.id
WHERE
  specializations.specie_id IS NULL;

/* What specialty should Maisy Smith consider getting? Look for the species she gets the most.*/
SELECT
  species.name,
  COUNT(species.name) AS num_visit_by_Maisy_Smith
FROM
  animals
  INNER JOIN visits ON visits.animals_id = animals.id
  INNER JOIN species ON species.id = animals.species_id
  INNER JOIN vets ON vets.id = visits.vets_id
  LEFT JOIN specializations ON specializations.vet_id = vets.id
WHERE
  vets.name = 'Maisy Smith'
GROUP BY
  species.name;

/* PROJECT 5 */
SELECT
  COUNT(*)
FROM
  visits
where
  animal_id = 4;

SELECT
  *
FROM
  visits
where
  vet_id = 2;

SELECT
  *
FROM
  owners
where
  email = 'owner_18327@mail.com';