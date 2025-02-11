# Infraestructura AWS con Terraform

Este proyecto contiene la configuración de Terraform para desplegar una infraestructura completa en AWS, incluyendo VPC, EKS, RDS/DocumentDB y recursos relacionados.

## Requisitos Previos

- Terraform >= 1.10.4
- AWS CLI configurado con las credenciales apropiadas
- kubectl (para interactuar con el cluster EKS)

## Componentes Principales

1. **VPC y Networking**
   - VPC con subnets públicas y privadas
   - Internet Gateway y NAT Gateway
   - Tablas de rutas configuradas

2. **EKS (Elastic Kubernetes Service)**
   - Cluster EKS con nodos auto-escalables
   - IAM roles y políticas necesarias
   - Security Groups configurados

3. **Base de Datos**
   - RDS (PostgreSQL/MySQL) o DocumentDB según configuración
   - Subnet groups y security groups dedicados

4. **Storage (Opcional)**
   - Bucket S3 con versionamiento y encriptación
   - IAM roles para acceso

## Estructura del Proyecto
```
.
├── main.tf           # Archivo principal y recursos core
├── variables.tf      # Declaración de variables
├── outputs.tf        # Outputs/salidas del proyecto
├── versions.tf       # Versiones de providers
├── vpc.tf           # Configuración de red
├── security.tf      # Grupos de seguridad
├── databases.tf     # Recursos de bases de datos
├── eks.tf          # Configuración del cluster EKS
├── iam.tf          # Roles y políticas IAM
└── terraform.tfvars.example  # Ejemplo de variables
```

## Explicación Detallada por Archivo

### 1. main.tf (Archivo Principal)
El archivo `main.tf` es el punto de entrada principal de la configuración y contiene:

1. **Backend Configuration**: 
   - Configuración para almacenar el estado de Terraform en S3 (comentado por defecto)
   - Crucial para trabajar en equipo y mantener el estado seguro

2. **Data Sources**:
   - `aws_caller_identity`: Obtiene información de la cuenta AWS actual
   - `aws_region`: Obtiene la región AWS actual
   - `aws_availability_zones`: Obtiene zonas disponibles

3. **Recursos Core**:
   - KMS Key para encriptación
   - VPC Endpoints para servicios AWS (S3, ECR)
   - Parámetros SSM para almacenar información

4. **Locals**:
   - Define variables locales reutilizables
   - Establece lógica condicional para tipos de proyecto
   - Define tags comunes

### 2. versions.tf
Define las versiones de los providers necesarios:
- AWS Provider
- Kubernetes Provider
- Versión mínima de Terraform

Propósito: Asegurar consistencia y compatibilidad entre diferentes entornos.

### 3. variables.tf
Declara todas las variables utilizadas en el proyecto:

1. **Variables de Proyecto**:
   - `project_name`
   - `environment`
   - `project_type`

2. **Variables de Red**:
   - CIDRs
   - Zonas de disponibilidad
   - Configuración de subnets

3. **Variables de EKS**:
   - Versión del cluster
   - Configuración de nodos
   - Tipos de instancia

4. **Variables de Base de Datos**:
   - Tipo de instancia
   - Motor de base de datos
   - Versión del motor

### 4. vpc.tf
Configura toda la infraestructura de red:

1. **VPC Principal**:
   - CIDR block principal
   - DNS hostnames y support

2. **Subnets**:
   - Subnets públicas (para balanceadores y NAT Gateway)
   - Subnets privadas (para EKS y RDS)
   - Tags específicos para Kubernetes

3. **Gateways**:
   - Internet Gateway para acceso a internet
   - NAT Gateway para subnets privadas

4. **Tablas de Ruteo**:
   - Rutas públicas hacia Internet Gateway
   - Rutas privadas hacia NAT Gateway
   - Asociaciones de subnets

### 5. security.tf
Define los grupos de seguridad:

1. **EKS Security Group**:
   - Reglas de ingreso para el API server
   - Reglas de egreso para los nodos

2. **RDS Security Group**:
   - Acceso desde el cluster EKS
   - Puertos específicos según el motor (5432/3306)

### 6. databases.tf
Configura recursos de base de datos:

1. **RDS**:
   - Instancia de base de datos
   - Subnet group
   - Configuración de backup

2. **DocumentDB (Opcional)**:
   - Cluster DocumentDB
   - Instancias del cluster

3. **S3 (Opcional)**:
   - Bucket con versionamiento
   - Encriptación por defecto

### 7. eks.tf
Implementa el cluster Kubernetes:

1. **Cluster EKS**:
   - Configuración del control plane
   - Networking
   - Endpoint access

2. **Node Group**:
   - Configuración de auto-scaling
   - Tipos de instancia
   - IAM roles asociados

### 8. iam.tf
Gestiona todos los permisos:

1. **Roles EKS**:
   - Role para el cluster
   - Role para los nodos

2. **Políticas**:
   - Políticas para EKS
   - Políticas para nodos
   - Políticas para S3 (opcional)

## Flujo de Despliegue

1. **Preparación**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Editar terraform.tfvars con valores específicos
   ```

2. **Inicialización**:
   ```bash
   terraform init
   ```

3. **Planificación**:
   ```bash
   terraform plan
   ```

4. **Aplicación**:
   ```bash
   terraform apply
   ```
5. **Eliminar todos los recursos creados**
   ```bash
   terraform destroy
   ```

# Outputs de Terraform

## Descripción General
El archivo `outputs.tf` define los valores que serán mostrados después de aplicar la configuración de Terraform y que pueden ser utilizados por otros módulos o para referencia.

## Uso de los Outputs

### Consulta de Outputs
```bash
# Ver todos los outputs
terraform output

# Ver un output específico
terraform output vpc_id
```
