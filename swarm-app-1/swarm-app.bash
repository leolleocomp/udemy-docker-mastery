# frontend network
docker network create -d overlay frontend

#backend network
docker network create -d overlay backend

# voting service
docker service create -p 80:80 --replicas 2 --network frontend --name voting-app dockersamples/examplevotingapp_vote:before

# redis service
docker service create --network frontend --name redis redis:3.2

# PostgreSQL db
docker service create --network backend --name db --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4

# .NET worker
docker service create --network frontend --network backend --name worker dockersamples/examplevotingapp_worker 

# result service
docker service create -p 8080:80 --network backend --name result dockersamples/examplevotingapp_result:before
