Empaquetado de aplicación con helm

# Estructura

``` text 
|-- desafio9
|   |-- Chart.yaml
|   |-- charts
|   |-- templates
|   |   |-- deployment-dev.yaml
|   |   |-- mongo-deployment.yaml
|   |   |-- mongo-pvc.yaml
|   |   |-- service-app.yaml
|   |   |-- service-mongo.yaml
|   |-- values.yaml
|-- desafio9-0.1.0.tgz
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
# Empaqueta la aplicación 
```
helm package desafio9
```
