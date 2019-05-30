docker build -t wuxfsh/multi-cleint:latest -t wuxfsh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t wuxfsh/multi-server -t wuxfsh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t wuxfsh/multi-worker -t wuxfsh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push wuxfsh/multi-client:latest
docker push wuxfsh/multi-server:latest
docker push wuxfsh/multi-worker:latest

docker push wuxfsh/multi-client:$SHA
docker push wuxfsh/multi-server:$SHA
docker push wuxfsh/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=wuxfsh/multi-server:$SHA
kubectl set image deployments/server-deployment server=wuxfsh/multi-client:$SHA
kubectl set image deployments/server-deployment server=wuxfsh/multi-worker:$SHA