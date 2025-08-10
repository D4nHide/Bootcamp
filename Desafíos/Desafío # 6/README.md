Playbook en ansible para desplegar un servidor LAMP + Wordpress


```
			┌────────────────────────────────────────────┐
			│           🖥️ Servidor Ansible              │
            └────────────────────┬───────────────────────┘
			                     │ SSH (clave: vockey.pem)
			                     ▼
			┌────────────────────────────────────────────┐
			│      ☁️ Instancia EC2 (Ubuntu Server)      │
			│                                            │
			│                                            │
			│    ┌──────────────┐   ┌───────────────┐    │
			│    │   Apache     │   │     PHP       │    │
			│    │  (apache2)   │   │  (php, mods)  │    │
			│    └──────┬───────┘   └──────┬────────┘    │
			│           │                  │             │
			│           ▼                  ▼             │
			│                                            │
			│ ┌──────────────────────────────────────┐   │
			│ |             MySQL Server             │   │
			│ │   - Base de datos: wordpress         │   │
			│ └──────────────────────────────────────┘   │
			└────────────────────────────────────────────┘
```
```
ansible-wordpress/
├── hosts                          # Inventario hosts IP y variables SSH
├── playbook.yml                   # Playbook
├── group_vars/
│   └── all.yml                    # Variables globales (MySQL, WordPress)
├── roles/
│   ├── apache/
│   │   └── tasks/
│   │       └── main.yml           # Instala y configura Apache
│   ├── php/
│   │   └── tasks/
│   │       └── main.yml           # Instala PHP y sus módulos
│   ├── mysql/
│   │   └── tasks/
│   │       └── main.yml           # Instala y asegura MySQL
│   └── wordpress/
│       └── tasks/
│           └── main.yml           # Descarga y configura WordPress
├── wp-config.php.j2               # Plantilla Jinja2 
└── vockey.pem                     # Clave privada para conectarte al EC2
```

# Para usar este playbook:
- Cambia la ip en el achivo hosts
- Copiar la clave privado al archivo vockey.pem
- Solo funciona para distros Debian (apt)

# Correr Playbook
```
ansible-playbook -i hosts playbook.yml
```
