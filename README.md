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
