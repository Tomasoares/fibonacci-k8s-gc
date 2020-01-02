docker build -t tomasoares/fibonacci-client:latest -t tomasoares/fibonacci-client:$SHA -f ./client/Dockerfile ./client
docker build -t tomasoares/fibonacci-server:latest -t tomasoares/fibonacci-server:$SHA -f ./server/Dockerfile ./server
docker build -t tomasoares/fibonacci-worker:latest -t tomasoares/fibonacci-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tomasoares/fibonacci-client:latest
docker push tomasoares/fibonacci-server:latest
docker push tomasoares/fibonacci-worker:latest

docker push tomasoares/fibonacci-client:$SHA
docker push tomasoares/fibonacci-server:$SHA
docker push tomasoares/fibonacci-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/worker-deployment worker=tomasoares/fibonacci-worker:$SHA
kubectl set image deployments/server-deployment server=tomasoares/fibonacci-server:$SHA
kubectl set image deployments/client-deployment client=tomasoares/fibonacci-client:$SHA