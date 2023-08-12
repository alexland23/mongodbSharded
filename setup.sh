#!/bin/bash

# Set database to shard
export dbName=MyDatabase

# Start compose 
docker compose up -d

# Configure config
echo "#############################"
echo "## Init config"
echo "#############################"
docker exec -it mongo-config-01 sh -c "cat /scripts/init-configserver.js | mongosh"

# Init each shard
echo "#############################"
echo "## Init shards"
echo "#############################"
docker exec -it shard-01-node-a sh -c "cat /scripts/init-shard01.js | mongosh"
docker exec -it shard-02-node-a sh -c "cat /scripts/init-shard02.js | mongosh"
docker exec -it shard-03-node-a sh -c "cat /scripts/init-shard03.js | mongosh"

# Wait for each shard to elect a primary
echo "#############################"
echo "## Sleeping for 60s"
echo "#############################"
sleep 60

# Init router (mongos)
echo "#############################"
echo "## Init router"
echo "#############################"
docker exec -it router-01 sh -c "cat /scripts/init-router.js | mongosh"

# Enable sharding
echo "#############################"
echo "## Enable sharding in db"
echo "#############################"
docker exec -it router-01 sh -c "echo 'sh.enableSharding(\"$dbName\")' | mongosh --port 27017"

# Check status to see if sharding worked
echo "#############################"
echo "## Check status"
echo "#############################"
docker exec -it router-01 sh -c "echo 'sh.status()' | mongosh --port 27017"