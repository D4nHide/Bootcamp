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
│   │   │   ├── Container: nest (jhantoe/desafio-nest:latest)
│   │   │   └── Env: MONGO_URI=mongodb://mongo:27017/nest
│   ├── Service: nest-service
│   │   └── Type: ClusterIP (puerto 3000)
│   └── kubectl port-forward
│       └── Localhost:3000 → nest-service:3000
```
## Requisitos 
- Cluster de Kubernetes
- Kubectl



<img width="1269" height="326" alt="image" src="https://github.com/user-attachments/assets/44eb97ea-98c2-4632-a0b8-9545f97321b8" />
<img width="1355" height="133" alt="image" src="https://github.com/user-attachments/assets/237a2f29-508f-45d9-a4b3-414ce7d99da8" />
<img width="1260" height="220" alt="image" src="https://github.com/user-attachments/assets/e0de917f-edda-44a9-9295-a04da38d4056" />
<img width="1374" height="49" alt="image" src="https://github.com/user-attachments/assets/6f9378f7-b5d8-4aab-975b-24ed42c887d7" />

