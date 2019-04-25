# Wesa Api Server
Wesa api.
## Getting Started
    git clone http://github.com/pinkjp/wesa.git
### Prerequisites
Docker version 18.06.0-ce, build 0ffa825
docker-compose version 1.21.0, build 5920eb0
### Dependencies
 1. docker installed
 2. docker-compose installed
 3. Copy paste both private.key and pubic.key to the root folder	
		
### Starting environment
    cd wesa
    make up
This will start the server in **localhost:3000**
#### Sample Request
    http://localhost:3000/wesa/api/v1/users/9567133536/all

### Connecting to database

    mysql -u wesa -h 127.0.0.1 -p

Password is `wesa` itself

    use wesa;

### Logs
#### Api logs

    docker-compose logs -f wesa

#### db logs
    docker-compose logs -f wesa-db

####
## Authors

*  **JPnMe** - *Initial work*
