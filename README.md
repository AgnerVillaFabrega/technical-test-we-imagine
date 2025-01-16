# Prueba Técnica para DevOps

Este repositorio contiene la solución a una prueba técnica de DevOps, diseñada para demostrar habilidades en integración continua, despliegue continuo, infraestructura como código y monitoreo centralizado. A continuación, se detalla la estructura y funcionalidades del proyecto.

---

## **Contenido del Repositorio** 
```

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
