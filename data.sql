/* Populate database with sample data. */
/* PROJECT 1 */
/* Insertion inside table animals */
INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Devimon', '2017-05-12', 5, true, 11);

/* PROJECT 2 */
INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Charmander', '2020-02-08', 0, false, -11);

INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Plantmon', '2021-11-15', 2, true, -5.7);

INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Squirtle', '1993-04-02', 3, false, -12.13);

INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Boarmon', '2005-07-07', 7, true, 20.4);

INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Blossom', '1998-10-13', 3, true, 17);

INSERT INTO
  ANIMALS (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES
  ('Ditto', '2022-05-14', 4, true, 22);

/* Insertion inside owners table */
INSERT INTO
  owners (full_name, age)
VALUES
  ('Sam Smith', 34);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Jennifer Orwell', 19);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Bob', 45);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Melody Pond', 77);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Dean Winchester', 14);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Jodie Whittaker', 38);

/* Insertion inside table species */
INSERT INTO
  species (name)
VALUES
  ('Pokemon');

INSERT INTO
  species (name)
VALUES
  ('Digimon');

/* Update insertion animals that are digimon with species_id=2 */
UPDATE
  animals
SET
  species_id = 2
WHERE
  name LIKE '%mon';

/* Update insertion animals that are pokemon with species_id=3 */
UPDATE
  animals
SET
  species_id = 1
WHERE
  species_id IS NULL;

/* Sam Smith owns Agumon */
(
  SELECT
    id
  FROM
    owners
  WHERE
    full_name = 'Sam Smith'
  LIMIT
    1
)
WHERE
  LIKE 'Agumon';

/* Jennifer Orwell owns Gabumon and Pikachu */
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Jennifer Orwell'
    LIMIT
      1
  )
WHERE
  name LIKE 'Gabumon'
  OR name LIKE 'Pikachu';

/* Bob owns Devimon and Plantmon */
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Bob'
    LIMIT
      1
  )
WHERE
  name LIKE 'Devimon'
  OR name LIKE 'Plantmon';

/* Melody Pond owns Charmander, Squirtle, and Blossom */
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Melody Pond'
    LIMIT
      1
  )
WHERE
  name LIKE 'Charmander'
  OR name LIKE 'Squirtle'
  OR name LIKE 'Blossom';

/* Dean Winchester owns Angemon and Boarmon */
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Dean Winchester'
    LIMIT
      1
  )
WHERE
  name LIKE 'Angemon'
  OR name LIKE 'Boarmon';

/* PROJECT 3 */
/* Data insertion into vets */
INSERT INTO
  vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, '2000-04-23'),
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08');

/* Data insertion into specializations */
INSERT INTO
  specializations (vet_id, species_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    )
  );

/* Data insertion into visits */
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2020-05-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2020-07-22'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Gabumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2021-02-02'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-01-05'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-03-08'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-05-14'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Devimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2021-05-04'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Charmander'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2021-02-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-12-21'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2020-08-10'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2021-04-07'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Squirtle'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2019-09-29'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2020-10-03'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    '2020-11-04'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-01-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2019-05-15'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-02-27'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    '2020-08-03'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    '2020-05-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    '2021-01-11'
  );

/* PROJECT 5 */
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO
  visits (animal_id, vet_id, date_of_visit)
SELECT
  *
FROM
  (
    SELECT
      id
    FROM
      animals
  ) animal_ids,
  (
    SELECT
      id
    FROM
      vets
  ) vets_ids,
  generate_series(
    '1980-01-01' :: timestamp,
    '2021-01-01',
    '4 hours'
  ) visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into
  owners (full_name, email)
select
  'Owner ' || generate_series(1, 2500000),
  'owner_' || generate_series(1, 2500000) || '@mail.com';