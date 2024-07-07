#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
then
  if [[ $1 =~ [0-9]+ ]]
  then 
      ELEMENT_INFO=$($PSQL "SELECT name, symbol, type, atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = $1 ")
      if [[ ! -z $ELEMENT_INFO ]]
      then
        echo "$ELEMENT_INFO" | while read NAME BAR SYMBOL BAR TYPE BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
        done
      fi
  else
      ELEMENT_INFO=$($PSQL "SELECT name, symbol, type, atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) FULL JOIN types USING(type_id) WHERE name = '$1' OR symbol = '$1'")
      if [[ ! -z $ELEMENT_INFO ]]
        then
        echo "$ELEMENT_INFO" | while read NAME BAR SYMBOL BAR TYPE BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS
          do
            echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
          done
      fi
    fi
  if [[ -z $ELEMENT_INFO ]]
  then 
    echo "I could not find that element in the database."
  fi
else
echo "Please provide an element as an argument."
fi 