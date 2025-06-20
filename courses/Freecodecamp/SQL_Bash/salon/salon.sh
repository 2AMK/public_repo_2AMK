#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo -e "Welcome to My Salon, how can I help you?\n"  

MAIN_MENU() {

  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
     
  # Show available services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services")
  echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
  SERVICE_MENU
}

SERVICE_MENU() {
  # Ask for user to select a service
  read SERVICE_ID_SELECTED

  SERVICE_AVAILIABILITY=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  # If input is not available
  if [[ -z $SERVICE_AVAILIABILITY ]]
  then
    # Send to main menu 
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    # Get customer info
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

    # If customer doesn't exist
    if [[ -z $CUSTOMER_NAME ]]
    then
      # Get customer name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME

      # Insert into table customers
      INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name,phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
    fi
  
  # Get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # Ask for time
  echo -e "\nWhat time would you like your $(echo $SERVICE_AVAILIABILITY | sed -r 's/^ *//g'), $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME

  # Insert all info into appointments
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $(echo $SERVICE_AVAILIABILITY | sed -r 's/^ *//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
  fi

}

MAIN_MENU