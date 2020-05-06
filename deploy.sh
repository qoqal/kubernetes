docker build -t qoqal/multi-client:latest -t qoqal/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t qoqal/multi-server:latest -t qoqal/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t qoqal/multi-worker:latest -t qoqal/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push qoqal/multi-client:latest
docker push qoqal/multi-server:latest
docker push qoqal/multi-worker:latest

docker push qoqal/multi-client:$SHA
docker push qoqal/multi-server:$SHA
docker push qoqal/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=qoqal/multi-client:$SHA
kubectl set image deployments/server-deployment server=qoqal/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=qoqal/multi-worker:$SHA