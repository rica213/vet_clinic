/* Populate database with sample data. */

 /* Insertion inside table animals */
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, false, -11);
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-07-07', 7, true, 20.4);
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO ANIMALS (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);

/* Insertion inside owners table */
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age) VALUES ('Bob', 45);
INSERT INTO owners (full_name, age) VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age) VALUES ('Jodie Whittaker', 38);

/* Insertion inside table species */
INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

/* Update insertion animals that are digimon with species_id=2 */
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

/* Update insertion animals that are pokemon with species_id=3 */
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

/* Sam Smith owns Agumon */
(SELECT id FROM owners WHERE full_name = 'Sam Smith' LIMIT 1)
WHERE LIKE 'Agumon';

/* Jennifer Orwell owns Gabumon and Pikachu */
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell' LIMIT 1)
WHERE name LIKE 'Gabumon' OR name LIKE 'Pikachu';

/* Bob owns Devimon and Plantmon */
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob' LIMIT 1)
WHERE name LIKE 'Devimon' OR name LIKE 'Plantmon';

/* Melody Pond owns Charmander, Squirtle, and Blossom */
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond' LIMIT 1)
WHERE name LIKE 'Charmander' OR name LIKE 'Squirtle' OR name LIKE 'Blossom';

/* Dean Winchester owns Angemon and Boarmon */
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester' LIMIT 1)
WHERE name LIKE 'Angemon' OR name LIKE 'Boarmon';
