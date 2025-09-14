##  Arquitectura del Proyecto en Kubernetes

```text
Kubernetes Cluster
├── Namespace: default
│   ├── Deployment: mongo
│   │   ├── Pod: mongo-xxxxxx
│   │   │   ├── Container: mongo (image: mongo:6.0)
│   │   │   └── VolumeMount: /data/db (mongo-storage)
│   │   └── PersistentVolumeClaim: mongo-pvc
│   │       └── PersistentVolume: local-path
│   ├── Service: mongo
│   │   └── Type: ClusterIP (puerto 27017)
│   ├── Deployment: nest-dev
│   │   ├── Pod: nest-dev-xxxxxx
│   │   │   ├── Container: nest (image: tuusuario/nest-app)
│   │   │   └── Env: MONGO_URI=mongodb://mongo:27017/nest
│   ├── Service: nest-service
│   │   └── Type: ClusterIP (puerto 3000)
│   └── kubectl port-forward
│       └── Localhost:3000 → nest-service:3000
```
