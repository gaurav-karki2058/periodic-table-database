PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

INVALID_ELEMENT(){
echo -e "\n$1"
}

if [[ -z $1 ]]
then
  INVALID_ELEMENT "Please provide an element as an argument."

  else
   
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ARGUMENT_QUERY_RESULT=$($PSQL "SELECT * FROM PROPERTIES WHERE ATOMIC_NUMBER=$1")
    if [[ -z $ARGUMENT_QUERY_RESULT ]]
    then
      echo "Not a valid atomic number"
    else
      echo $ARGUMENT_QUERY_RESULT
    fi
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
  echo "yay"

  fi
fi