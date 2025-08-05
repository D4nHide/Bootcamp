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
├── hosts                          # Inventario con IP del servidor y variables SSH
├── playbook.yml                   # Playbook principal
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
