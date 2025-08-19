# EJERCICIOS PARA PRACTICAR TERRAFORM.
### Se solicitó a ChatGPT una serie de ejercicios para el aprendizaje de esta herramienta.

🟢 Nivel 1: Fundamentos

- Hello EC2
Crea una instancia EC2 t2.micro con una AMI de Ubuntu o Amazon Linux.
Agrega un tag Name = "hello-terraform".
Conéctate vía SSH para verificar.
- Variables básicas
Define variables para la región y el tipo de instancia en variables.tf.
Usa terraform.tfvars para cambiar fácilmente la región o el tipo.
- Outputs
Expón la IP pública y el hostname privado de la instancia con output "public_ip" {}.
Ejecuta terraform output y valida.

🟡 Nivel 2: Redes y almacenamiento
- Security Group
Crea un aws_security_group que permita:
SSH (22) desde tu IP
HTTP (80) desde cualquier lado
Asigna ese SG a tu instancia EC2.
- S3 Bucket
Crea un bucket S3 con nombre único (ej: mi-bucket-${random_id}).
Agrega versioning y un tag Environment = "Dev".
Usa aws_s3_bucket_object para subir un archivo de prueba.
- Par clave SSH
Genera un tls_private_key con Terraform.
Exporta el .pem y úsalo para conectarte a la instancia.

🔵 Nivel 3: Infraestructura completa
- Instancia con user_data
Lanza una EC2 que ejecute un script de user_data para instalar Apache y mostrar un mensaje en http://<public_ip>.
Output = URL de acceso.
- Módulos
Crea un módulo ec2-instance que reciba:
AMI
Tipo de instancia
Tags
Usa el módulo 2 veces para lanzar dos instancias con diferentes nombres.
- VPC + Subnet + EC2
(Un poco más avanzado) Crea tu propia VPC con:
1 VPC
1 Subnet pública
1 Internet Gateway
1 Route Table
Lanza una EC2 dentro de esa subnet.
Valida que tenga salida a Internet.

🔴 Nivel 4: Integración y práctica real
- Autoscaling básico con Terraform + Free Tier
Define un Launch Template con Ubuntu y Nginx.
Crea un Auto Scaling Group con mínimo 1 instancia y máximo 2.
Usa un Elastic Load Balancer (ALB) para balancear tráfico.
(Tip: todo esto está dentro del Free Tier si usas t2.micro).
- Infra multi-región
Crea un bucket en us-east-1 y otro en us-west-2.
Configura provider con alias y prueba replicación manual.
Terraform State remoto
Guarda tu estado en un bucket S3.
Activa dynamodb_table para bloqueo de estado.
