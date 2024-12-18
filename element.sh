PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

INVALID_ELEMENT(){
echo -e "\n$1"
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
    ATOMIC_NUMBER_BY_SYMBOL=$($PSQL "SELECT ATOMIC_NUMBER FROM PROPERTIES WHERE SYMBOL=$1")
    if [[ -z $ATOMIC_NUMBER_BY_SYMBOL ]]
    then
      INVALID_ELEMENT "No such atomic symbol found"
    else
      ATOMIC_NUMBER=$ATOMIC_NUMBER_BY_SYMBOL;
    fi 
  elif [[ $1 =~ ^[A-Z][a-z]*$ ]]
  then
    ATOMIC_NUMBER_BY_NAME=$($PSQL "SELECT ATOMIC_NUMBER FROM PROPERTIES WHERE NAME=$1")
    if [[ -z $ATOMIC_NUMBER_BY_NAME ]]
    then
      INVALID_ELEMENT "No such atomic symbol found"
    else
      ATOMIC_NUMBER=$ATOMIC_NUMBER_BY_NAME;
    fi 
  fi
fi