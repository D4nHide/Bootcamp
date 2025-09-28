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
<img width="1014" height="736" alt="image" src="https://github.com/user-attachments/assets/130a47d2-19f3-463d-9252-0407f430d478" />

# Setear configmap (Killercoda)
ArgoCD, por defecto, redirige a HTTPS si detecta que no se accede vía https. En entornos como killercoda, eso puede causar bucles (To many redirect).

```
kubectl patch configmap argocd-cmd-params-cm -n argocd --type merge -p '{"data":{"server.insecure":"true"}}'
```
<img width="972" height="51" alt="image" src="https://github.com/user-attachments/assets/0c1dab85-b45a-490a-83bc-f6daf46fdd74" />

# Reiniciar pod
```
kubectl -n argocd rollout restart deployment argocd-server
```
<img width="981" height="36" alt="image" src="https://github.com/user-attachments/assets/c6888e3b-2684-4ec3-967e-3567d2a8e1ec" />

# Port-forward 
```
kubectl port-forward svc/argocd-server -n argocd --address=0.0.0.0 8000:80
```
# ⚠️🖐️⚠️🖐️⚠️
No se debe usar --address=0.0.0.0 para entornos productivos

# Acceso a Argo

<img width="1794" height="724" alt="image" src="https://github.com/user-attachments/assets/9bf297ed-97bf-4c97-b184-39a5b7335e1e" />

# Conectando repositorio púbblico
- Choose your connection method: HTTP/HTTPS
- Repository URL
```
https://github.com/D4nHide/mi-app-k8s
```
<img width="1651" height="568" alt="image" src="https://github.com/user-attachments/assets/99ceaa36-d722-4ebf-8ea4-8f875e83c3fe" />
<img width="1904" height="370" alt="image" src="https://github.com/user-attachments/assets/24e4624a-f311-42d9-ac3d-4f8c5bc65032" />


# Crear APP en Argo por UI o por yaml

- YAML
```
kubectl apply -f mi-app-argocd.yaml
```
- UI Argo

| Campo            | Valor                                          |
| ---------------- | ---------------------------------------------- |
| Application Name | `mi-app`                                       |
| Project          | `default`                                      |
| Sync Policy      | Manual o Automática                            |
| Repository URL   | [https://github.com/D4nHide/mi-app-k8s](https://github.com/D4nHide/mi-app-k8s) |
| Revision         | `main`                                |
| Path             | `.`                                            |
| Cluster          | `https://kubernetes.default.svc`               |
| Namespace        | `default`                                      |




# Resultados
<img width="977" height="237" alt="image" src="https://github.com/user-attachments/assets/a8137d05-b48a-43fd-887f-949da0fb152a" />
<img width="1918" height="550" alt="image" src="https://github.com/user-attachments/assets/1272fe43-2024-4978-89f4-4269c59bacf1" />
<img width="1086" height="248" alt="image" src="https://github.com/user-attachments/assets/ed1eed89-5cb1-470a-a390-b6a935b0cd62" />


