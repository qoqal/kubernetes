docker build -t qosha/multi-client:latest -t qosha/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t qosha/multi-server:latest -t qosha/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t qosha/multi-worker:latest -t qosha/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push qosha/multi-client:latest
docker push qosha/multi-server:latest
docker push qosha/multi-worker:latest

docker push qosha/multi-client:$SHA
docker push qosha/multi-server:$SHA
docker push qosha/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=qosha/multi-client:$SHA
kubectl set image deployments/server-deployment server=qosha/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=qosha/multi-worker:$SHA