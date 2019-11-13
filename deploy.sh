docker build -t vasanth195500/multi-client:latest -t vasanth195500/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vasanth195500/multi-server:latest -t vasanth195500/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vasanth195500/multi-worker:latest -t vasanth195500/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vasanth195500/multi-client:latest
docker push vasanth195500/multi-server:latest
docker push vasanth195500/multi-worker:latest

docker push vasanth195500/multi-client:$SHA
docker push vasanth195500/multi-server:$SHA
docker push vasanth195500/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vasanth195500/multi-server:$SHA
kubectl set image deployments/client-deployment client=vasanth195500/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vasanth195500/multi-worker:$SHA
