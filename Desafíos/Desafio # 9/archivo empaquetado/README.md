# Clona el repositorio
```
git clone --filter=blob:none --no-checkout https://github.com/D4nHide/Bootcamp.git
cd Bootcamp
git sparse-checkout init --cone
git sparse-checkout set "Desafíos/Desafio # 9"
git checkout
ls "Desafíos/Desafio # 9"
```
<img width="805" height="349" alt="image" src="https://github.com/user-attachments/assets/0723565f-a498-4a8e-b496-bf60494f5826" />

# Asegurate de tener instalado helm
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
# Instala la aplicación
```
helm install desafio9-release ./desafio9-0.1.0.tgz
```
<img width="944" height="187" alt="image" src="https://github.com/user-attachments/assets/a92e5881-b838-4442-9ff0-93e699b2d5ba" />

# Verifica el deploy
```
kubectl get all
```
<img width="705" height="268" alt="image" src="https://github.com/user-attachments/assets/6537692e-6f1d-4420-ac62-7834d76647a2" />

# Port-forward de la aplicación
```
kubectl port-forward service/nest-service --address=0.0.0.0 3000:3000
```
# ⚠️🖐️⚠️🖐️⚠️
No se debe usar --address=0.0.0.0 para entornos productivos
<img width="951" height="104" alt="image" src="https://github.com/user-attachments/assets/c79e50db-bc59-4659-a2f7-3dbf7044ab50" />

# Resultado
<img width="948" height="123" alt="image" src="https://github.com/user-attachments/assets/3954161a-cd71-4551-bd39-67fe0320efee" />
<img width="951" height="856" alt="image" src="https://github.com/user-attachments/assets/923312d0-538e-494c-a01b-71a743645629" />


