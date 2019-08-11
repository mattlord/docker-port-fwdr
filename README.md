# docker-port-fwdr
Creates a simple container image for port forwarding.

This can, for example, serve as a sort of jump host when accessing services through a k8s cluster from your local machine. Here's an example for MySQL admins (at this point you will have already connected and auth'd with your k8s cluster):
```
# run the port forwarder pod in your k8s cluster
$ kubectl run -it --rm -n <namespace> --image=mattalord/port-fwdr --restart=Never port-fwdr 3306 <cloud endpoint>:3306

# forward your local port to the new relay pod
$ kubectl port-forward -n <namespace> pod/port-fwdr 3306:3306 &
```

Then you can use your favorite MySQL client, e.g. [MySQL Workbench](https://www.mysql.com/products/workbench/), on your local machine to access the remote database instance using TLS.

If you need an SSL tunnel between the pod and the endpoint -- for example when using the redis-cli to connect to a TLS enabled Cloud Redis service such as ElastiCache -- then you can add an optional third parameter of "stunnel":
```
# run the port forwarder pod in your k8s cluster
$ kubectl run -it --rm -n <namespace> --image=mattalord/port-fwdr --restart=Never port-fwdr 3306 <cloud endpoint>:3306 stunnel
```

Then you can use the local redis client to connect to the TLS'd redis service. For example:
```
$ kubectl run -it --rm -n $NAMESPACE --image=mattalord/port-fwdr --restart=Never redis-port-fwdr 6379 <cloud endpoint>:6379 stunnel
$ kubectl port-forward -n $NAMESPACE pod/redis-port-fwdr 6379:6379
```
