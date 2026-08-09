# PSA-Shards

Sharded MongoDB cluster using the **Primary-Secondary-Arbiter (PSA)** replica set pattern: each shard has two data-bearing nodes and one arbiter (votes in elections but holds no data).

## Topology

- **Router (`mongos`)** — `localhost:27017`
- **Config server replica set** — `configsvr01`, `configsvr02`
- **Shard 1** (`rs-shard-01`) — `shard01-a` (priority 20), `shard01-b` (priority 10), `shard01-c` (arbiter)
- **Shard 2** (`rs-shard-02`) — `shard02-a`, `shard02-b`, `shard02-c` (arbiter)

Because the third member of each shard is an arbiter, it never becomes primary and holds no data — this trades redundancy for a lighter footprint.

## Usage

1. Edit `setup.sh` to set `dbName` (the database to shard) and `mongoVersion` (the Mongo image tag).
2. Run `./setup.sh`. This will:
   - Start all containers with `docker compose up -d`
   - Initiate the config server replica set
   - Initiate both shard replica sets
   - Set the cluster's default write concern to `majority`
   - Add both shards to the router and enable sharding on `dbName`
3. Connect via `mongosh` at `localhost:27017`.

The init scripts run by `setup.sh` live in [`scripts/`](scripts).
