# set custom namespace as default
```yml
kubectl config set-context --current --namespace=private
```

# This command allow to build image in minikube
```bash
eval $(minikube docker-env)

#to undo
eval $(minikube docker-env -u)
```

# This command will create rollout with custom cause
```bash
kubectl annotate deployment/<deployment-name> \
  kubernetes.io/change-cause="Was updated front" \
  --record
```


# Add ingress to minikube
```bash
minikube addons enable ingress
```

# Configure host to redirect to minikube
```bash
sudo nano /etc/hosts
<ip address of minikube>  application.com
```

