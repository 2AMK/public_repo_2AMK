[[SQL]]
[[PostgreSQL]]
[[Bash]]
Última atualização: [[2025-06-24]]

___
Os códigos abaixo são os exemplos de automação com Bash e SQL, elaborados durante o curso de FreeCodeCamp.


Exemplo de automação de inserção de dados do arquivo .csv ao banco de dados de SQL
```sh
#!/bin/bash

# Script to insert data from courses.csv and students.csv into students database

PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

echo $($PSQL "TRUNCATE students, majors, courses, majors_courses;")


cat courses.csv | while IFS="," read MAJOR COURSE
do
  if [[ $MAJOR != "major" ]]
  then
    # get major_id
    MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")

    # if not found
    if [[ -z $MAJOR_ID ]]
    then
      # insert major
      INSERT_MAJOR_RESULT=$($PSQL "INSERT INTO majors(major) VALUES('$MAJOR')")
      if [[ $INSERT_MAJOR_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into majors, $MAJOR
      fi

      # get new major_id
      MAJOR_ID=$($PSQL "SELECT major_id FROM majors WHERE major='$MAJOR'")
    fi

    # get course_id
    COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")

    # if not found
    if [[ -z $COURSE_ID ]]
    then
      # insert course
      INSERT_COURSE_RESULT=$($PSQL "INSERT INTO courses(course) VALUES('$COURSE')")
      if [[ $INSERT_COURSE_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into courses, $COURSE
      fi
      # get new course_id
      COURSE_ID=$($PSQL "SELECT course_id FROM courses WHERE course='$COURSE'")
    fi

    # insert into majors_courses
    INSERT_MAJORS_COURSES_RESULT=$($PSQL "INSERT INTO majors_courses(major_id, course_id) VALUES($MAJOR_ID, $COURSE_ID)")
    if [[ $INSERT_MAJORS_COURSES_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into majors_courses, $MAJOR : $COURSE

    fi
  fi
done

cat students.csv | while IFS="," read FIRST LAST MAJOR GPA
do
  if [[ $FIRST != first_name ]]
  then
    #get major_id
    MAJOR_ID=$($PSQL "SELECT major_id from majors WHERE major='$MAJOR'")
    

    #if not found
    if [[ -z $MAJOR_ID ]]
    then
      # set to null
      MAJOR_ID=null
    fi

    #insert student
    INSERT_STUDENT_RESULT=$($PSQL "INSERT INTO students(first_name, last_name, major_id, gpa) VALUES('$FIRST', '$LAST', $MAJOR_ID, $GPA)")
      if [[ $INSERT_STUDENT_RESULT == "INSERT 0 1" ]]
      then
        echo "Inserted into students, $FIRST $LAST"
      fi
  fi
done
```

Exemplo de consultas ao banco de dados em SQL usando Bash:
```sh
#!/bin/bash

# Info about my computer science students from students database

echo -e "\n~~ My Computer Science Students ~~\n"

PSQL="psql -X --username=freecodecamp --dbname=students --no-align --tuples-only -c"

echo -e "\nFirst name, last name, and GPA of students with a 4.0 GPA:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE gpa = 4.0")"

echo -e "\nAll course names whose first letter is before 'D' in the alphabet:"
echo "$($PSQL "SELECT course FROM courses WHERE course < 'D'")"

echo -e "\nFirst name, last name, and GPA of students whose last name begins with an 'R' or after and have a GPA greater than 3.8 or less than 2.0:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE last_name >= 'R' AND (gpa > 3.8 OR gpa < 2.0)")"

echo -e "\nLast name of students whose last name contains a case insensitive 'sa' or have an 'r' as the second to last letter:"
echo "$($PSQL "SELECT last_name FROM students WHERE last_name ILIKE '%sa%' OR last_name ILIKE '%r_'")"

echo -e "\nFirst name, last name, and GPA of students who have not selected a major and either their first name begins with 'D' or they have a GPA greater than 3.0:"
echo "$($PSQL "SELECT first_name, last_name, gpa FROM students WHERE major_id IS NULL AND (first_name LIKE 'D%' OR gpa > 3.0)")"

echo -e "\nCourse name of the first five courses, in reverse alphabetical order, that have an 'e' as the second letter or end with an 's':"
echo "$($PSQL "SELECT course FROM courses WHERE course LIKE '_e%' OR course LIKE '%s' ORDER BY course DESC LIMIT 5")"

echo -e "\nAverage GPA of all students rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(gpa), 2) FROM students")"

echo -e "\nMajor ID, total number of students in a column named 'number_of_students', and average GPA rounded to two decimal places in a column name 'average_gpa', for each major ID in the students table having a student count greater than 1:"
echo "$($PSQL "SELECT major_id, COUNT(*) AS number_of_students, ROUND(AVG(gpa), 2) AS average_gpa FROM students GROUP BY major_id HAVING COUNT(*) > 1")"

echo -e "\nList of majors, in alphabetical order, that either no student is taking or has a student whose first name contains a case insensitive 'ma':"
echo "$($PSQL "SELECT major FROM students FULL JOIN majors ON students.major_id = majors.major_id WHERE major IS NOT NULL AND (student_id IS NULL OR first_name ILIKE '%ma%') ORDER BY major")"

echo -e "\nList of unique courses, in reverse alphabetical order, that no student or 'Obie Hilpert' is taking:"
echo "$($PSQL "SELECT DISTINCT(course) FROM students RIGHT JOIN majors USING(major_id) INNER JOIN majors_courses USING(major_id) INNER JOIN courses USING(course_id) WHERE (first_name = 'Obie' AND last_name = 'Hilpert') OR student_id IS NULL ORDER BY course DESC")"

echo -e "\nList of courses, in alphabetical order, with only one student enrolled:"
echo "$($PSQL "SELECT course FROM students RIGHT JOIN majors USING(major_id) INNER JOIN majors_courses USING(major_id) INNER JOIN courses USING(course_id) group by course having count(student_id) = 1 ORDER BY course")"
```

Exemplo da atividade que fiz no curso para automatizar a inserção dos dados no banco de dados de SQL e realizar as consultas ao banco de dados usando Bash:
insert_data.sh
```sh
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
```

queries.sh
```sh
#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) from games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals>2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT teams.NAME FROM games JOIN teams ON games.winner_id=teams.team_id WHERE year=2018 AND round='Final'")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT teams.NAME FROM games JOIN teams ON games.winner_id=teams.team_id WHERE year=2014 AND round='Eighth-Final' UNION SELECT teams.NAME FROM games JOIN teams ON games.opponent_id=teams.team_id WHERE year=2014 AND round='Eighth-Final'")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(teams.NAME) FROM games JOIN teams ON games.winner_id=teams.team_id WHERE winner_id=team_id ORDER BY teams.name")"
 
echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT games.year, teams.NAME FROM games JOIN teams ON games.winner_id=teams.team_id WHERE round='Final' AND (year = 2014 or year = 2018) ORDER BY year")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%'")"

```

Exemplo de aluguel de bike interativa:
```sh
#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=bikes --tuples-only -c"

echo -e "\n~~~~~ Bike Rental Shop ~~~~~\n"

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

  echo "How may I help you?" 
  echo -e "\n1. Rent a bike\n2. Return a bike\n3. Exit"
  read MAIN_MENU_SELECTION

  case $MAIN_MENU_SELECTION in
    1) RENT_MENU ;;
    2) RETURN_MENU ;;
    3) EXIT ;;
    *) MAIN_MENU "Please enter a valid option." ;;
  esac
}

RENT_MENU() {
  # get available bikes
  AVAILABLE_BIKES=$($PSQL "SELECT bike_id, type, size FROM bikes WHERE available = true ORDER BY bike_id")

  # if no bikes available
  if [[ -z $AVAILABLE_BIKES ]]
  then
    # send to main menu
    MAIN_MENU "Sorry, we don't have any bikes available right now."
  else
    # display available bikes
    echo -e "\nHere are the bikes we have available:"
    echo "$AVAILABLE_BIKES" | while read BIKE_ID BAR TYPE BAR SIZE
    do
      echo "$BIKE_ID) $SIZE\" $TYPE Bike"
    done

    # ask for bike to rent
    echo -e "\nWhich one would you like to rent?"
    read BIKE_ID_TO_RENT

    # if input is not a number
    if [[ ! $BIKE_ID_TO_RENT =~ ^[0-9]+$ ]]
    then
      # send to main menu
      MAIN_MENU "That is not a valid bike number."
    else
      # get bike availability
      BIKE_AVAILABILITY=$($PSQL "SELECT available FROM bikes WHERE bike_id = $BIKE_ID_TO_RENT AND available = true")

      # if not available
      if [[ -z $BIKE_AVAILABILITY ]]
      then
        # send to main menu
        MAIN_MENU "That bike is not available."
      else
        # get customer info
        echo -e "\nWhat's your phone number?"
        read PHONE_NUMBER

        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$PHONE_NUMBER'")

        # if customer doesn't exist
        if [[ -z $CUSTOMER_NAME ]]
        then
          # get new customer name
          echo -e "\nWhat's your name?"
          read CUSTOMER_NAME

          # insert new customer
          INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$PHONE_NUMBER')") 
        fi

        # get customer_id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$PHONE_NUMBER'")

        # insert bike rental
        INSERT_RENTAL_RESULT=$($PSQL "INSERT INTO rentals(customer_id, bike_id) VALUES($CUSTOMER_ID, $BIKE_ID_TO_RENT)")

        # set bike availability to false
        SET_TO_FALSE_RESULT=$($PSQL "UPDATE bikes SET available = false WHERE bike_id = $BIKE_ID_TO_RENT")

        # get bike info
        BIKE_INFO=$($PSQL "SELECT size, type FROM bikes WHERE bike_id = $BIKE_ID_TO_RENT")
        BIKE_INFO_FORMATTED=$(echo $BIKE_INFO | sed 's/ |/"/')
        
        # send to main menu
        MAIN_MENU "I have put you down for the $BIKE_INFO_FORMATTED Bike, $( echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
      fi
    fi
  fi
}

RETURN_MENU() {
  # get customer info
  echo -e "\nWhat's your phone number?"
  read PHONE_NUMBER
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone= '$PHONE_NUMBER'")

  # if not found
  if [[ -z $CUSTOMER_ID ]]
  then
    # send to main menu
    MAIN_MENU "I could not find a record for that phone number."
  else
    # get customer's rentals
    CUSTOMER_RENTALS=$($PSQL "SELECT bike_id, type, size FROM bikes INNER JOIN rentals USING(bike_id) INNER JOIN customers USING(customer_id) WHERE phone = '$PHONE_NUMBER' AND date_returned IS NULL ORDER BY bike_id")

    # if no rentals
    if [[ -z $CUSTOMER_RENTALS ]]
    then
      # send to main menu
      MAIN_MENU "You do not have any bikes rented."
    else
      # display rented bikes
      echo -e "\nHere are your rentals:"
      echo "$CUSTOMER_RENTALS" | while read BIKE_ID BAR TYPE BAR SIZE
      do
        echo "$BIKE_ID) $SIZE\" $TYPE Bike"
      done

      # ask for bike to return
      echo -e "\nWhich one would you like to return?"
      read BIKE_ID_TO_RETURN

      # if not a number
      if [[ ! $BIKE_ID_TO_RETURN =~ ^[0-9]+$ ]]
      then
      # send to main menu
      MAIN_MENU "That is not a valid bike number."
      
      else
        # check if input is rented
        RENTAL_ID=$($PSQL "SELECT rental_id FROM rentals INNER JOIN customers USING(customer_id) WHERE phone = '$PHONE_NUMBER' AND bike_id = $BIKE_ID_TO_RETURN AND date_returned IS NULL;")

        # if input not rented
        if [[ -z $RENTAL_ID ]]
        then 
          # send to main menu
          MAIN_MENU "You do not have that bike rented."
        else
          # update date_returned
          RETURN_BIKE_RESULT=$($PSQL "UPDATE rentals SET date_returned = NOW() WHERE rental_id = $RENTAL_ID")

          # set bike availability to true
          SET_TO_TRUE_RESULT=$($PSQL "UPDATE bikes SET available = true WHERE bike_id = $BIKE_ID_TO_RETURN")

          # send to main menu
          MAIN_MENU "Thank you for returning your bike."
        fi
      fi
    fi
  fi  
}

EXIT() {
  echo -e "\nThank you for stopping in.\n"
}

MAIN_MENU

```

