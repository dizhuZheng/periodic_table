#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ -z $1 ]]
then
  echo -e "\nPlease provide an element as an argument.\n"
else
  if [[ $1 =~ ^[A-Z0-9]+ ]]
  then
    ELEMENT="$($PSQL "SELECT * FROM elements LEFT JOIN properties ON properties.atomic_number=elements.atomic_number WHERE properties.atomic_number=$1" )".
    # echo The element with atomic number $ELEMENT[0] is $ELEMENT[1]. It's a nonmetal, with a mass of  amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
    if [[ -z $ELEMENT ]]
    then
      echo -e "\nI could not find that element in the database."
    else
      echo $ELEMENT
    fi
  fi
fi