Creación de un Helm chart & Empaquetado de aplicación con helm

# Estructura

``` text 
|-- desafio9
|   |-- Chart.yaml
|   |-- charts
|   |-- templates
|   |   |-- _helpers.tpl
|   |   |-- deployment-dev.yaml
|   |   |-- mongo-deployment.yaml
|   |   |-- mongo-pvc.yaml
|   |   |-- service-app.yaml
|   |   `-- service-mongo.yaml
|   `-- values.yaml
`-- desafio9-0.1.0.tgz
```
# Clona el repositorio
```
git clone --filter=blob:none --no-checkout https://github.com/D4nHide/Bootcamp.git
cd Bootcamp
git sparse-checkout init --cone
git sparse-checkout set "Desafíos/Desafío # 8"
git checkout
ls "Desafíos/Desafío # 8"
```
# Crea directorio
```
mkdir helmcharts
```
# Instala Helm
```
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
```
# Crea tu chart
```
helm create desafio9
```
<img width="387" height="34" alt="image" src="https://github.com/user-attachments/assets/1bd2f1dd-3499-4f2d-86ca-7bc2b8ef640b" />

# Empaqueta la aplicación 
```
helm package desafio9
```
<img width="640" height="65" alt="image" src="https://github.com/user-attachments/assets/7833f18b-7cab-4715-aa45-488db2922bdf" />

# Instala la aplicación
```
helm install desafio9-release ./desafio9-0.1.0.tgz
```
<img width="618" height="112" alt="image" src="https://github.com/user-attachments/assets/57853d56-033a-4e36-92d5-e19749f2d256" />

# Verifica el despliegue
```
kubectl get all
```
<img width="663" height="276" alt="image" src="https://github.com/user-attachments/assets/37112031-f75b-483a-8f80-86df7c97e6b6" />

# Port-forward de la aplicación
```
kubectl port-forward service/nest-service --address=0.0.0.0 3000:3000
```
# ⚠️🖐️⚠️🖐️⚠️
No se debe usar --address=0.0.0.0 para entornos productivos
<img width="781" height="93" alt="image" src="https://github.com/user-attachments/assets/5f1064b0-1dfb-42db-9bbb-5819ce330b8d" />

# Resultado
<img width="723" height="738" alt="image" src="https://github.com/user-attachments/assets/16b3a90a-4409-433a-9f32-9f0ed856ceaf" />
<img width="721" height="128" alt="image" src="https://github.com/user-attachments/assets/470c6cfc-a88f-47d9-ae0a-d163800eae84" />


