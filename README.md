# mongodbSharded

A local example of a sharded MongoDB cluster running entirely in Docker. Each variant spins up two shards, a two-member config server replica set, and a `mongos` router.

## Cluster layout

- **Router (`mongos`)** — entry point for clients, exposed on `localhost:27017`
- **Config server replica set** — 2 members (`configsvr01`, `configsvr02`)
- **Shard 1** — 3-member replica set (`shard01-a`, `shard01-b`, `shard01-c`)
- **Shard 2** — 3-member replica set (`shard02-a`, `shard02-b`, `shard02-c`)

## Variants

| Folder | Replica set type | Shard members |
| --- | --- | --- |
| [`PSA-Shards`](PSA-Shards) | Primary-Secondary-Arbiter | 2 data-bearing nodes + 1 arbiter (no vote weight in data) |
| [`PSS-Shards`](PSS-Shards) | Primary-Secondary-Secondary | 3 data-bearing nodes |

PSA uses fewer resources since the third member only votes and doesn't hold data. PSS keeps a full data copy on all three members for stronger redundancy.

## Usage

1. `cd` into the variant you want (`PSA-Shards` or `PSS-Shards`).
2. Edit `setup.sh` to set `dbName` (the database to shard) and `mongoVersion` (the Mongo image tag).
3. Run `./setup.sh`. This brings up the containers with `docker compose`, initializes the config server and shard replica sets, registers the shards with the router, and enables sharding on `dbName`.
4. Connect to the cluster via `mongosh` at `localhost:27017`.

Each variant's `docker-compose.yml` and init scripts live under its own `scripts/` folder.
