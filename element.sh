#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 1
fi

ELEMENT_DATA=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number::TEXT='$1' OR symbol='$1' OR name='$1'")


if [[ -z $ELEMENT_DATA ]]
then
  echo "I could not find that element in the database."
  exit 1
fi

IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING <<< "$ELEMENT_DATA"
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu."
echo "$NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

