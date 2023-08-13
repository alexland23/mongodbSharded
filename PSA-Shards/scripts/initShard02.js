rs.initiate({
    _id: "rs-shard-02",
    version: 1,
    members: [
        { _id: 0, host: "shard02-a:27017", priority: 20, votes: 1 },
        { _id: 1, host: "shard02-b:27017", priority: 10, votes: 1 },
        { _id: 2, host: "shard02-c:27017", priority: 0, votes: 1, arbiterOnly: true, },
    ]
})
