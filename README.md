# Default Backend Server

This is a simple webserver that satisfies the ingress, which means it has to do two things:

 1. Serves a 404 page at `/`
 2. Serves 200 on a `/healthz`

Server respond JSON instead of plain text

Not found page:
```
$ curl http://localhost:8080
{"code":404,"message":"Not found"}
```

Status page:

```
$ curl http://localhost:8080/healthz
{"status":"ok"}
```

## Why?!

In my projects, it's important that alive server respond JSON, even if this is default backend server. This image is only 2mb which is extreamly small compare to others custom error images.

Also I personally think JSON response looks better than html error without formatting

Example usage:
```
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: default-http-backend
  labels:
    app: default-http-backend
  namespace: ingress-nginx
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: default-http-backend
    spec:
      terminationGracePeriodSeconds: 60
      containers:
      - name: default-http-backend
        image: stiks/defaultbackend-rest:1.0
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8080
            scheme: HTTP
          initialDelaySeconds: 30
          timeoutSeconds: 5
        ports:
        - containerPort: 8080
        resources:
          limits:
            cpu: 10m
            memory: 20Mi
          requests:
            cpu: 10m
            memory: 20Mi
---
apiVersion: v1
kind: Service
metadata:
  name: default-http-backend
  namespace: ingress-nginx
  labels:
    app: default-http-backend
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
  selector:
    app: default-http-backend
```