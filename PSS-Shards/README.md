# PSS-Shards

Sharded MongoDB cluster using the **Primary-Secondary-Secondary (PSS)** replica set pattern: each shard has three data-bearing nodes, giving every member a full copy of the data.

## Topology

- **Router (`mongos`)** — `localhost:27017`
- **Config server replica set** — `configsvr01`, `configsvr02`
- **Shard 1** (`rs-shard-01`) — `shard01-a` (priority 30), `shard01-b` (priority 20), `shard01-c` (priority 10)
- **Shard 2** (`rs-shard-02`) — `shard02-a`, `shard02-b`, `shard02-c`

All three members of each shard hold data, so this variant gives stronger redundancy than PSA at the cost of running an extra full data node per shard.

## Usage

1. Edit `setup.sh` to set `dbName` (the database to shard) and `mongoVersion` (the Mongo image tag).
2. Run `./setup.sh`. This will:
   - Start all containers with `docker compose up -d`
   - Initiate the config server replica set
   - Initiate both shard replica sets
   - Add all shard members to the router and enable sharding on `dbName`
3. Connect via `mongosh` at `localhost:27017`.

The init scripts run by `setup.sh` live in [`scripts/`](scripts).
