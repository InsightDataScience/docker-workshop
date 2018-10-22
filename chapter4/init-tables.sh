#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username me --dbname study <<-EOSQL
        CREATE TABLE participants (name VARCHAR(255), age int, score int);
        SELECT * FROM participants;
        INSERT INTO participants (name, age, score) VALUES ('Ronda', 33, 8), ('Jack', 44, 12);
EOSQL
