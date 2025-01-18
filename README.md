# Prueba Técnica para DevOps

Este repositorio contiene la solución a una prueba técnica de DevOps, diseñada para demostrar habilidades en integración continua, despliegue continuo, infraestructura como código y monitoreo centralizado. A continuación, se detalla la estructura y funcionalidades del proyecto.

---

## **Contenido del Repositorio** 
```
Directory structure:
└── agnervillafabrega-technical-test-we-imagine/
    ├── README.md
    ├── Local setup/
    │   ├── eks/
    │   │   └── cluster.yaml                  # Configuración del clúster EKS para pruebas locales.
    │   ├── k8s/
    │   │   ├── deployment.yaml               # Configuración del despliegue Kubernetes.
    │   │   └── service.yaml                  # Configuración del servicio Kubernetes.
    │   └── sonar-local/
    │       └── docker-compose.yml            # Archivo para levantar SonarQube localmente.
    ├── docs/
    │   └── TerraformCommands.md              # Guía de comandos útiles de Terraform.
    ├── step-1/
    │   ├── README.md                         # Documentación del proyecto.
    │   ├── Dockerfile                        # Imagen Docker para la aplicación.
    │   ├── sonar-project.properties          # Configuración de SonarQube.en Git.
    │   ├── ...
    │   ├── src/
    │   │   ├── app.controller.spec.ts        # Pruebas unitarias del controlador principal.
    │   │   ├── app.controller.ts             # Controlador principal de la aplicación.
    │   │   ├── app.module.ts                 # Módulo principal de la aplicación.
    │   │   ├── app.service.ts                # Servicio principal de la aplicación.
    │   │   ├── main.ts                       # Punto de entrada de la aplicación.
    │   │   └── users/
    │   │       ├── users.controller.spec.ts  # Pruebas del controlador de usuarios.
    │   │       ├── users.controller.ts       # Controlador de usuarios.
    │   │       ├── users.module.ts           # Módulo de usuarios.
    │   │       ├── users.service.spec.ts     # Pruebas del servicio de usuarios.
    │   │       ├── users.service.ts          # Servicio de usuarios.
    │   │       ├── dto/
    │   │       │   ├── create-user.dto.ts    # DTO para creación de usuario.
    │   │       │   └── update-user.dto.ts    # DTO para actualización de usuario.
    │   │       └── entities/
    │   │           └── user.entity.ts        # Entidad de usuario.
    │   └── test/
    │       ├── app.e2e-spec.ts               # Pruebas end-to-end para la aplicación.
    │       ├── jest-e2e.json                 # Configuración Jest para pruebas e2e.
    │       └── users/
    │           └── users.e2e-spec.ts         # Pruebas e2e para el módulo de usuarios.
    ├── step-2/
    │   ├── README.md                         # Documentación de la infraestructura con Terraform.
    │   ├── databases.tf                      # Configuración de bases de datos.
    │   ├── eks.tf                            # Configuración del clúster EKS.
    │   ├── iam.tf                            # Configuración de roles IAM.
    │   ├── main.tf                           # Configuración principal de Terraform.
    │   ├── outputs.tf                        # Salidas de Terraform.
    │   ├── security.tf                       # Configuración de seguridad (SGs).
    │   ├── terraform.tfvars                  # Variables personalizadas.
    │   ├── terraform.tfvars.example          # Ejemplo de variables.
    │   ├── variables.tf                      # Variables reutilizables.
    │   ├── version.tf                        # Versión de Terraform.
    │   ├── vpc.tf                            # Configuración de la VPC.
    │   └── .gitignore                        # Archivos ignorados por Git en Terraform.
    ├── step-3/
    │   ├── README-SOLUTION.md                # Descripción del monitoreo centralizado.
    │   └── images/                           # Recursos gráficos para documentación.
    └── .github/
        └── workflows/
            ├── cicd.yaml                     # Configuración del pipeline CI/CD.
            └── pr.yaml                       # Pipeline para validación de PRs.
```

## **Requerimientos de la prueba**
### *Step-01*
1. **Pipeline de CI/CD con GitHub Actions**  
   - **Build:** Compilación del código del servicio web.  
   - **Test:** Ejecución de pruebas unitarias y análisis de código con SonarQube.  
   - **Deploy:** Despliegue del servicio web en un clúster EKS de AWS.  
   - Configuración completa del pipeline en el archivo `.github/workflows`.
   
### *Step-02*
2. **Infraestructura con Terraform**  
   - Archivos `.tf` para levantar una infraestructura base en AWS que incluye:
     - Red VPC con subnets públicas y privadas.
     - Security Groups configurados.
     - Un Internet Gateway y NAT Gateway.
   - Recursos principales:
     - Clúster EKS configurado con nodos escalables.
     - Base de datos RDS (PostgreSQL o MySQL).
     - Opcional: DocumentDB o buckets S3 según la variable `project_type`.
   - Configuración de IAM Roles y Policies necesarias para los servicios.

### *Step-03*
3. **Monitoreo Centralizado de Microservicios**  
   - Propuesta de una solución de monitoreo centralizado utilizando herramientas como Loki con Grafana o Elasticsearch con Kibana.
   - Configuración para la recolección y visualización de logs en tiempo real.
   - Proceso documentado para que los desarrolladores consulten fallos específicos.
   - Opcional: Métricas clave para monitorear la salud de los microservicios.
