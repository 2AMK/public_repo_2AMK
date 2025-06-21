#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

arg1=$1

ASK_ELEMENT() {
  if [[ -z $arg1 ]]
  then
    echo "Please provide an element as an argument."
  else
    # Verify if input is a number:
    if [[ $arg1 =~ ^[0-9]+$ ]]
    then
      # Make a query into periodic table
      ELEMENT_AVAILABILITY=$($PSQL "SELECT atomic_number,symbol, name FROM elements WHERE atomic_number = $arg1")
      
      # Verify if query does exist
      if [[ ! -z $ELEMENT_AVAILABILITY ]]
      then
        # And then look up their properties
        ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types using(type_id) WHERE atomic_number = $arg1")
        
        # Read those properties into echo
        echo "$ELEMENT_INFO" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS M_POINT B_POINT
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."    
        done
      
      # In case query doesn't exist
      else
        echo "I could not find that element in the database."
      fi

    else
      # If it is not number
      ELEMENT_AVAILABILITY=$($PSQL "SELECT atomic_number,symbol, name FROM elements WHERE symbol = '$arg1' OR name = '$arg1'")
      
      # Verify if query does exist
      if [[ ! -z $ELEMENT_AVAILABILITY ]]
      then
        # And then look up their properties
        ELEMENT_INFO=$($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types using(type_id) WHERE symbol = '$arg1' OR name = '$arg1'")

        # Read those properties into echo
        echo "$ELEMENT_INFO" | while IFS="|" read ATOMIC_NUMBER SYMBOL NAME TYPE ATOMIC_MASS M_POINT B_POINT
        do
          echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $M_POINT celsius and a boiling point of $B_POINT celsius."    
        done
      else
        echo "I could not find that element in the database."
      fi
    fi
  fi
}

ASK_ELEMENT