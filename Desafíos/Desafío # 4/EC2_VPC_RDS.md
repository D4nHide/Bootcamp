## 1) Crear VPC

![image](https://github.com/user-attachments/assets/313e7a0b-ee34-4e02-8349-11616420a444)

VPC Public Subnet values:

- IPv4 CIDR block: 10.0.0.0/16 
- IPv6 CIDR block: No IPv6 CIDR Block
-​ VPC name: tutorial-vpc
- ​Public subnet’s IPv4 CIDR: 10.0.0.0/24
- Public subnet’s IPv4 CIDR: 10.0.0.0/24
- Availability Zone: No preference
- Public subnet name: Tutorial public

Setear los valores y crear VPC deberá quedar como las imágenes a continuación

![image](https://github.com/user-attachments/assets/843f0a56-0980-49e5-823b-caf224bc3d9d)
![image](https://github.com/user-attachments/assets/d63bc7c2-59fa-4578-a5d8-d5dba4b89a3a)
![image](https://github.com/user-attachments/assets/857990fe-03a5-4c86-9b23-99040ad17135)

## 2) Configurar Security Group

Ir a security group y seleccionar nuestra vpc creada

- Agregar una nueva rules
- Type: All traffic
- Source Anywhere-IPV4

![image](https://github.com/user-attachments/assets/be1e918b-9610-4a77-81b4-eb3f4096296d)
![image](https://github.com/user-attachments/assets/dbd50ce6-5814-431d-8405-4ef2e593179d)
![image](https://github.com/user-attachments/assets/06212677-a938-4df7-971a-b03dd7d67919)

Para mayor seguridad podemos escoger:

- Agregar una nueva rules
- Type: MYSQL/Aurora
- Source My IP

![image](https://github.com/user-attachments/assets/3beb394c-efe3-48f1-b4f6-a30ee37ff7b0)


## 3) Añadir otra subred

![image](https://github.com/user-attachments/assets/39c09e04-23c6-4b49-b66e-99c62001c2e3)

Nuestras subredes se verán de esta manera

![image](https://github.com/user-attachments/assets/e97457d1-3d8e-4599-939d-900f2bc901ed)

- Seleccione el panel de VPC y vaya a subredes, acto seguido seleccione la primera subred creada para la VPC
- Debajo de la lista de subredes, elija Route Table para ver el valor de la Tabla de enrutamiento.
- En la lista de subredes, anule la selección de la primera subred privada.
- En la lista de subredes, seleccione la segunda subred que acabamos de crear y vaya a tablas de ruteo.

![image](https://github.com/user-attachments/assets/e6df58de-a384-4d4a-ba77-c4f5c31e29d5)

Si la tabla de ruteo actual no es la misma que primera subred desplegue la lista y escoja la asignada en la primera (Guardar).

![image](https://github.com/user-attachments/assets/a21f5c9d-d4bc-4400-9678-6d37b3862448)
![image](https://github.com/user-attachments/assets/e4820785-fe77-48e5-8bf1-85ea30454012)

## 4) Crear un grupo de subredes de base de datos

![image](https://github.com/user-attachments/assets/a727d411-4998-4767-b21b-0093f83e5215)

Establezca los siguientes valores:
​
- Name: tutorial-db-subnet-group
- Description: Tutorial DB Subnet Group
- VPC: tutorial-vpc (vpc-identifier)​
- En la sección Agregar subredes elija las Zonas de disponibilidad y Subredes.​
- En este tutorial, elija us-east-1a y us-east-1b para las Zonas de disponibilidad. A continuación, elija todas las subredes para Subredes.

![image](https://github.com/user-attachments/assets/7f3a7a53-f496-425d-ada0-d3f106a8fce1)

Se verá un resultado como el siguiente:

![image](https://github.com/user-attachments/assets/2ccb218d-1025-4eb3-9150-62447ce7352a)


## 5) Crear la instancia de base de datos en la VPC

![image](https://github.com/user-attachments/assets/7091e103-3339-4e5f-89d0-dae7c619a567)


Usaremos la opción Standard Create, que permite seleccionar la VPC, además de
configuraciones como disponibilidad, seguridad, copias de seguridad y
mantenimiento. La opción Easy Create siempre utilizará la VPC por defecto, por lo
que en nuestro caso no nos sirve.​​ 

- Engine Type: Seleccionamos el motor de BD que vayamos a utilizar en esta instancia. En nuestro caso MariaDB.​


![image](https://github.com/user-attachments/assets/00956f19-f96e-45cd-9990-7201459546d9)

- DB instance size: Seleccionamos Free tier para economizar gastos.​
- Indicamos un nombre para la instancia de BD y el nombre del usuario administrador de la BD.​
- Auto generate a password. Cuando creemos la BD nos mostrará en ese único momento la contraseña, que deberemos guardar. Si desea indicar manualmente una contraseña desmarque esta opción.​

![image](https://github.com/user-attachments/assets/aa65f516-c73b-4466-9ea9-4bfbcec2fa84)

- ​Las siguientes opciones las dejaremos como aparecen por defecto.​
- ​En Connectivity seleccionamos la VPC que hemos creado en el apartado anterior.
- Seleccionamos el DB Subnet group que hemos creado anteriormente.​
- En Public access seleccionamos Yes para que podamos acceder a la BD desde cualquier equipo en Internet.​

![image](https://github.com/user-attachments/assets/6bee2b68-b76b-4020-bd45-783e000afbb0)


​Las siguientes opciones dejarlas por defecto, acto seguido ​pulsamos el botón Create database al final de la página.​ y nos aparecerá la siguiente pantalla donde se creara la instancia, esperar unos minutos,

![image](https://github.com/user-attachments/assets/e362595e-042b-4d38-a25b-714a22239178)

- Pulsamos el botón View credential details. Se abrirá una ventana para ver:
- La contraseña creada para el usuario administrador.
- La dirección (Endpoint) de la instancia a la que nos conectaremos con nuestro cliente.

![image](https://github.com/user-attachments/assets/0d065fe6-67ab-4c33-8d66-81dfa2ccfe9a)
![image](https://github.com/user-attachments/assets/34f29f12-9ce9-45cb-8910-a2c8f84a941b)

## 6) Comprobar el acceso a la instancia

Una vez teniendo los datos del paso annterior procedemos a conectarnos a la instancia:

```
mariadb -h mariadb-1.cwgngyaqkn0q.us-east-1.rds.amazonaws.com -u admin -p
```

![image](https://github.com/user-attachments/assets/913b2f56-44aa-49a9-b5a9-6ff39a6283f2)

