# AWS-Lambda-Integration
Integracion de todos los lab de iac 
para lograr la integracion de 
terraform + AWS + lambda

# Infraestructura : Procesamiento de Imágenes

## 1. Resumen del Proyecto
Este proyecto usa Terraform con AWS para crear una arquitectura que permite subir imágenes y procesarlas automáticamente.

## 2. Arquitectura
- API Gateway
- Lambda
- S3
- SQS
- IAM

## 3. Entornos
- dev → Envs/dev.tfvars
- qa → Envs/qa.tfvars
- prod → Envs/prod.tfvars

## 4. Uso
Antes de usar Terraform, debes configurar tus credenciales de AWS.

### 1: Usando AWS CLI
```bash
aws configure
```
Luego ingresar:
- AWS Access Key ID  
- AWS Secret Access Key  
- Region (ejemplo: us-east-1)  
- Output format (json)

### Inicializar
```bash
cd Terraform
terraform init
```

### Desplegar (dev)
```bash
terraform apply -var-file="../Envs/dev.tfvars"
```

### Eliminar
```bash
terraform destroy -var-file="../Envs/dev.tfvars"
```

## 5. Estructura
- Modules/
- Envs/
- Terraform/