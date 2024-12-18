PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

INVALID_ELEMENT(){
echo -e "$1"
}

if [[ -z $1 ]]
then
  INVALID_ELEMENT "Please provide an element as an argument."

  else
  ATOMIC_NUMBER=0

  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$1;
    
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    ATOMIC_NUMBER_BY_SYMBOL=$($PSQL "SELECT ATOMIC_NUMBER FROM ELEMENTS WHERE SYMBOL='$1'")
    if [[ -z $ATOMIC_NUMBER_BY_SYMBOL ]]
    then
      INVALID_ELEMENT "I could not find that element in the database."
    else
      ATOMIC_NUMBER=$ATOMIC_NUMBER_BY_SYMBOL;
    fi 
  elif [[ $1 =~ ^[A-Z][a-z]*$ ]]
  then
    ATOMIC_NUMBER_BY_NAME=$($PSQL "SELECT ATOMIC_NUMBER FROM ELEMENTS WHERE NAME='$1'")
    if [[ -z $ATOMIC_NUMBER_BY_NAME ]]
    then
      INVALID_ELEMENT "I could not find that element in the database."
    else
      ATOMIC_NUMBER=$ATOMIC_NUMBER_BY_NAME;
    fi 
  else
    INVALID_ELEMENT "I could not find that element in the database."
  fi

  if [[ $ATOMIC_NUMBER -ne 0 ]]
  then
  PROPERTIES_BY_ATOMIC_NUMBER=$($PSQL"SELECT * FROM PROPERTIES WHERE ATOMIC_NUMBER=$ATOMIC_NUMBER")
  ELEMENT_BY_ATOMIC_NUMBER=$($PSQL "SELECT * FROM ELEMENTS WHERE ATOMIC_NUMBER=$ATOMIC_NUMBER")
  echo $PROPERTIES_BY_ATOMIC_NUMBER $ELEMENT_BY_ATOMIC_NUMBER
  IFS='|' read -r ATOMIC_NUM ATOMIC_WEIGHT MELTING_POINT BOILING_POINT ELEMENT_TYPE_ID<<< "$PROPERTIES_BY_ATOMIC_NUMBER"
  ELEMENT_TYPE=$($PSQL"SELECT TYPE FROM TYPES WHERE TYPE_ID=$ELEMENT_TYPE_ID")

  IFS='|' read -r ATMOIC_NUM SYMBOL NAME <<< "$ELEMENT_BY_ATOMIC_NUMBER"

  echo "The element with atomic number $ATOMIC_NUM is $NAME ($SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ATOMIC_WEIGHT amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

  fi

fi