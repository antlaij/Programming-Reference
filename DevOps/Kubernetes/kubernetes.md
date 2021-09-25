# Kubernetes:

## Get Version
```batch
kubectl version
```

#### All Componments
```batch
kubectl get all
kubectl --kubeconfig /home/.kube/config get all
```

#### List all nodes
```batch
kubectl get nodes
kubectl --kubeconfig /home/.kube/config get nodes
```

### Namespaces
#### List all namespaces
```batch
kubectl get namespaces

kubectl --kubeconfig /home/.kube/config get namespaces
```
#### get Single namespaces
```batch
kubectl --kubeconfig /home/.kube/config get namespaces
```

### Pod
#### List all pods
```batch
kubectl get pods --all-namespaces
kubectl get pods --show-labels -n namespace-name

kubectl --kubeconfig /home/.kube/config get pod 
kubectl --kubeconfig /home/.kube/config get pod -n namespace-name
```
#### Describe pod
```batch
kubectl describe pod -n angular portal-7c97d5c758-z9w2l

```

#### List all Services
```batch
kubectl get services

kubectl --kubeconfig /home/.kube/config get services
```

### Deployment
#### List all deployments ( application )
```batch
kubectl get deployments --all-namespaces
kubectl get deployment -n nodejs

kubectl --kubeconfig /home/.kube/config get deployments
```
#### Create deployment
```batch
kubectl --kubeconfig /home/.kube/config create deployment nginx-depl --image=nginx
```
#### Delete deployment
```batch
kubectl --kubeconfig /home/.kube/config  delete deploy nginx-depl
```

### Replicaset
#### Get Replicaset
```batch
kubectl get replicaset -n nodejs

kubectl --kubeconfig /home/.kube/config get replicaset
```

### Logs
#### Sample
```
kubectl logs -n namespaceName pod-name
kubectl --kubeconfig /home/.kube/config logs -n namespaceName pod-name

kubectl --namespace=nodejs logs --selector app=my-microservice --since=1m
kubectl --kubeconfig /home/.kube/config --namespace=nodejs logs --selector app=my-microservice
```
#### View log from pod
```batch
kubectl --kubeconfig /home/.kube/config logs -n nodejs my-microservice-589b95cbc9-cmn5x
```


### exec -it
#### my-microservice
```
kubectl exec -it pod-name
kubectl exec -it my-microservice-589b95cbc9-cmn5x

kubectl exec -it my-microservice-589b95cbc9-cmn5x -n nodejs -- sh
kubectl exec -it portal-7c97d5c758-z9w2l -n angular -- sh
kubectl --kubeconfig /home/.kube/config exec -it -n angular portal-6f784b477-sk6tn
kubectl --kubeconfig /home/.kube/config exec -it -n angular portal-6f784b477-sk6tn -- bin/bash
```


### Debug application
```
kubectl exec -it my-microservice-589b95cbc9-cmn5x -n nodejs -- sh
```

### Apply
#### 
```
kubectl apply -f config-file.yaml
```

### Apply
#### 
```
kubectl get deployment nginx-deploym -o yaml
```

