/* Database schema to keep the structure of entire database. */

CREATE TABLE ANIMALS(
 id int GENERATED BY DEFAULT AS IDENTITY,
 name varchar(100) NOT NULL,
 date_of_birth date,
 escape_attempts int NOT NULL,
 neutered boolean NOT NULL,
 weight_kg decimal NOT NULL
);
