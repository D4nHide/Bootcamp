# Instrucciones
- Clonar repositorio

```
git clone --filter=blob:none --no-checkout https://github.com/D4nHide/Bootcamp.git
cd Bootcamp
git sparse-checkout init --cone
git sparse-checkout set "Desafíos/Desafío # 8"
git checkout
ls "Desafíos/Desafío # 8"
```
- Ir a la carpeta donde se encuentran los yamls y aplicar

```
kubectl apply -f deployment-dev.yaml
```
```
kubectl apply -f mongo-pvc.yaml       
```
```
kubectl apply -f service-app.yaml
```
```
kubectl apply -f service-mongo.yaml
```
- Verificamos

```
kubectl get all
```
```
kubectl port-forward service/nest-service --address=0.0.0.0 3000:3000
```

# ⚠️🖐️⚠️🖐️⚠️

No se debe usar --address=0.0.0.0 para entornos productivos

# Resultados

<img width="985" height="1098" alt="image" src="https://github.com/user-attachments/assets/0965b221-3f39-4981-83c8-0fd4fc2bafc2" />
<img width="987" height="114" alt="image" src="https://github.com/user-attachments/assets/50ad46d8-c459-4590-95ce-267903ed540c" />
<img width="914" height="100" alt="image" src="https://github.com/user-attachments/assets/8c6ac968-c79e-4e9e-aa1e-03ad9b66ce6c" />
<img width="1026" height="42" alt="image" src="https://github.com/user-attachments/assets/897736d2-1535-4a84-a135-ecf597cb79de" />

