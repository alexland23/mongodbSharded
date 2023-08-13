# mongodbSharded
Repo was created as an example to run a sharded Mongodb cluster locally through docker.

Choose the replica set type (PSA or PSS) and run `./setup.sh` to bring up containers and run initial db commands.

# PSA-Shards
Creates a sharded cluster with two PSA shards, two config serves, and one router (mongos) server.

# PSS-Shards
Creates a sharded cluster with two PSS shards, two config serves, and one router (mongos) server.