Desplegar Argo CD y configurar un repositorio


# Deploy Argo
```
kubectl create namespace argocd
```
```
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```
# Verificar el deploy
```
kubectl get all -n argocd
```
# Port-forward
```
kubectl port-forward svc/argocd-server -n argocd --address=0.0.0.0 8000:80
```
# ⚠️🖐️⚠️🖐️⚠️
No se debe usar --address=0.0.0.0 para entornos productivos
# Clave de acceso
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
# Setear configmap (Killercoda)
ArgoCD, por defecto, redirige a HTTPS si detecta que no se accede vía https. En entornos como killercoda, eso puede causar bucles.
- Directo
```
kubectl patch configmap argocd-cmd-params-cm -n argocd --type merge -p '{"data":{"server.insecure":"true"}}'
```
- Editando argocd-cm
```
kubectl -n argocd edit configmap argocd-cm
```
```yaml
data:
  server.insecure: "true"
```
# Reiniciar pod
```
kubectl -n argocd rollout restart deployment argocd-server
```
