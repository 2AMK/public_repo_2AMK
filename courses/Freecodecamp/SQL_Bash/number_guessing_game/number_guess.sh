#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

MAIN() {
  # Ask for username
  echo "Enter your username:"
  read USERNAME

  # Query if username does exist in database
  # Fetch ID_user
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")


  if [[ -z $USER_ID ]]
  then
    # If it doesn't exist in database 
    echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."

    # And add it to database
    INSERT_USERNAME_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")

    # Get user_id of new user
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")

  else
    # If it does have in database, get more info about game_played and best_game  
    GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
    BEST_GAME=$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id=$USER_ID")

    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi

  GAME
}

GAME() {
  # Start the guessing game
  # Create a random number to guess
  SECRET_NUMBER=$(( RANDOM % 1000 + 1 ))

  echo "Guess the secret number between 1 and 1000:"
  read GUESS
  NUMBER_OF_GUESSES=1


    until [[ $GUESS -eq $SECRET_NUMBER ]]
    do
       # If value is not number
      if [[ ! $GUESS =~ ^[0-9]+$ ]]
      then
        echo "That is not an integer, guess again:"
        read GUESS

      # If value is incorrect
      elif [[ $GUESS -gt $SECRET_NUMBER ]]
      then
        echo "It's lower than that, guess again:"
        read GUESS
        (( NUMBER_OF_GUESSES++ ))
      
      # If value is incorrect
      elif [[ $GUESS -lt $SECRET_NUMBER ]]
      then
        echo "It's higher than that, guess again:"
        read GUESS
        (( NUMBER_OF_GUESSES++ ))
      fi
    done

  
  # When user got right number
  echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"

  # Insert game data into database
  INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(user_id, guesses) values($USER_ID, $NUMBER_OF_GUESSES)")
}

MAIN