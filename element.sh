#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
if [[ -z $1 ]]
then
  echo -e "\nPlease provide an element as an argument.\n"
else
  if [[ $1 =~ ^[A-Z0-9]+ ]]
  then
    string=$1
    if [[ $1 =~ [0-9] ]]
    then
      ELEMENT="$($PSQL "SELECT * FROM elements FULL JOIN properties USING (atomic_number) FULL JOIN types USING (type_id) WHERE properties.atomic_number=$1")"
    elif [ $1=~^[A-Z][a-z]$ ] && [ ${#string} -le 2 ]
      then
        ELEMENT="$($PSQL "SELECT * FROM elements FULL JOIN properties USING (atomic_number) FULL JOIN types USING (type_id) WHERE elements.symbol='$1'")"
    else
      ELEMENT="$($PSQL "SELECT * FROM elements FULL JOIN properties USING (atomic_number) FULL JOIN types USING (type_id) WHERE elements.name='$1'")"
    fi
    if [[ -z $ELEMENT ]]
    then
      echo -e "\nI could not find that element in the database.\n"
    else 
      IFS='|' read -r A B C D E F G H <<< "$ELEMENT" 
      echo -e "\nThe element with atomic number $B is $D ($C). It's a $H, with a mass of $E amu. $D has a melting point of $F celsius and a boiling point of $G celsius.\n"
    fi
  else
    echo -e "\nI could not find that element in the database.\n"
  fi
fi