#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Empty the rows on table
echo $($PSQL "TRUNCATE TABLE games,teams;")

# Read game.csv using cat to table 
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT W_GOALS O_GOALS

# First we need to insert teams data first
do
  # Exclude the first line
  if [[ $WINNER != "winner" ]]
  then 
    # get team_id if already have it
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    
   # If team_id is not found
    if [[ -z $TEAM_ID ]]
    then
      # Insert team's name into teams table
      INSERT_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if  [[ $INSERT_NAME == "INSERT 0 1" ]]
      then 
        echo Inserted into team table, $WINNER
      fi
    fi
  fi
  # Now we're checking if opponent team is already on table
    # Exclude the first line
  if [[ $OPPONENT != "opponent" ]]
  then
    # Get team_id if already have it too
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    
    # If can't find team_id
    if [[ -z $TEAM_ID ]]
    then 
      # Insert team's name into teams table
      INSERT_NAME=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')") 
      if  [[ $INSERT_NAME == "INSERT 0 1" ]]
      then 
        echo Inserted into teams, $OPPONENT
      fi
    fi
  fi
  # Now we have to insert data on table games
  
  #Exclude first line of year
  if [[ $YEAR != "year" ]]
  then
    # Fetch team_id for winner and opponent
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # Insert into table games
    INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
                                VALUES($YEAR,'$ROUND',$WINNER_ID, $OPPONENT_ID, $W_GOALS, $O_GOALS)")
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
     then
        echo "Inserted into games, $WINNER vs $OPPONENT"
     fi
  fi
done