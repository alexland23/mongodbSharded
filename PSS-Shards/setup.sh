#!/bin/bash

# DB name to shard
export dbName=MyDatabase
# Mongo version to use
export mongoVersion=6.0.15

# Start compose 
docker compose up -d

# Wait for all containers to startup
echo -e "\n#############################"
echo "## Sleeping for 10s"
echo "#############################"
sleep 10

# Configure config
echo -e "\n#############################"
echo "## Init config"
echo "#############################"
docker exec -it configsvr01 sh -c "cat /scripts/initConfigServer.js | mongosh"

# Init each shard
echo -e "\n#############################"
echo "## Init shards"
echo "#############################"
docker exec -it shard01-a sh -c "cat /scripts/initShard01.js | mongosh"
docker exec -it shard02-a sh -c "cat /scripts/initShard02.js | mongosh"

# Sleeping to allow for shards to elect primary
echo -e "\n#############################"
echo "## Sleeping for 30s"
echo "#############################"
sleep 30

# Init router (mongos)
echo -e "\n#############################"
echo "## Init router"
echo "#############################"
docker exec -it router sh -c "cat /scripts/initRouter.js | mongosh"

# Enable sharding
echo -e "\n#############################"
echo "## Enable sharding in db"
echo "#############################"
docker exec -it router sh -c "echo 'sh.enableSharding(\"$dbName\")' | mongosh --port 27017"

# Check status to see if sharding worked
echo -e "\n#############################"
echo "## Check status"
echo "#############################"
docker exec -it router sh -c "echo 'sh.status()' | mongosh --port 27017"