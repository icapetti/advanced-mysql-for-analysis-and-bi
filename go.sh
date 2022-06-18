# This is a helper script to turn simple the common operations with the Docker application 

case "$1" in
   "setup") echo "Creating and starting containers..." 
   docker compose up -d
   ;;
   "start") echo "Starting app..." 
   docker compose start
   ;;
   "stop") echo "Stopping app..." 
   docker compose stop
   ;;
   "kill") echo "Killing app..." 
   docker compose kill
   ;;
   "down") echo "Stopping and removing containers, networks, volumes, and images created for this app..." 
   docker compose down
   ;;
   "bash") echo "Starting app bash..." 
   docker exec -it mysql-advanced-course-db-1 bash
   ;;
   *) echo "Enter with a valid option: setup, start, stop, kill" ;;
esac