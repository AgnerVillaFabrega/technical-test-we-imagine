# Comandos más usados de Terraform

## 1. `terraform init`
- Descripción Inicializa el directorio de trabajo de Terraform, descargando los proveedores necesarios y configurando el backend de estado.
- Uso Este comando debe ejecutarse al inicio de cualquier proyecto o cuando se agreguen nuevos proveedores.

```bash
terraform init
```

## 2. `terraform plan`
- Descripción Muestra el plan de ejecución de Terraform, es decir, qué cambios se harán en la infraestructura basándose en las configuraciones actuales y el estado de la infraestructura.
- Uso Utilizado para ver qué cambios se aplicarán antes de ejecutar `terraform apply`.

```bash
terraform plan
```

## 3. `terraform apply`
- Descripción Aplica los cambios a la infraestructura basados en el plan generado por `terraform plan`. Este comando es el que realmente realiza las modificaciones en la infraestructura.
- Uso Debe ejecutarse después de un `terraform plan` para aplicar los cambios.

```bash
terraform apply
```

## 4. `terraform destroy`
- Descripción Destruye la infraestructura que ha sido creada o gestionada por Terraform. Elimina todos los recursos definidos en los archivos de configuración.
- Uso Se utiliza para destruir todo lo que Terraform ha creado.

```bash
terraform destroy
```

## 5. `terraform show`
- Descripción Muestra el estado actual de la infraestructura gestionada por Terraform, ya sea en formato de texto o en formato JSON.
- Uso Utilizado para ver el estado detallado de la infraestructura.

```bash
terraform show
```

## 6. `terraform validate`
- Descripción Valida los archivos de configuración de Terraform para asegurarse de que la sintaxis y la configuración sean correctas.
- Uso Se utiliza para verificar si las configuraciones están correctas antes de ejecutar otros comandos.

```bash
terraform validate
```

## 7. `terraform output`
- Descripción Muestra los valores de las salidas definidas en el archivo `outputs.tf`, como direcciones IP, nombres de recursos, etc.
- Uso Utilizado para recuperar valores útiles de la infraestructura después de la creación o actualización.

```bash
terraform output
```

## 8. `terraform state`
- Descripción Permite manipular el estado de Terraform, como ver el estado, mover recursos dentro del estado, o cambiar el backend de estado.
- Uso Se utiliza para gestionar el estado de la infraestructura.

```bash
terraform state list
terraform state show resource_name
```

## 9. `terraform import`
- Descripción Importa recursos existentes en la infraestructura a Terraform, creando los archivos de configuración correspondientes para esos recursos.
- Uso Se utiliza cuando se desea gestionar un recurso que no fue creado inicialmente por Terraform.

```bash
terraform import resource_type.resource_name resource_id
```

## 10. `terraform taint`
- Descripción Marca un recurso para ser destruido y recreado en la siguiente ejecución de `terraform apply`.
- Uso Se utiliza cuando un recurso está en un estado inconsistente o necesita ser recreado.

```bash
terraform taint resource_type.resource_name
```

## 11. `terraform fmt`
- Descripción Da formato automáticamente a los archivos de configuración de Terraform (`.tf`) para que sigan una convención estándar de estilo.
- Uso Se utiliza para mantener un estilo uniforme en los archivos de configuración.

```bash
terraform fmt
```

## 12. `terraform providers`
- Descripción Muestra información sobre los proveedores que Terraform está utilizando en el proyecto.
- Uso Utilizado para ver qué proveedores están configurados y cuáles se están utilizando.

```bash
terraform providers
```

## 13. `terraform login`
- Descripción Permite autenticarse con HashiCorp Cloud, lo que es útil para almacenar el estado remoto y otros recursos en su plataforma.
- Uso Se utiliza para autenticar una cuenta en HashiCorp Cloud.

```bash
terraform login
```

## 14. `terraform workspace`
- Descripción Permite gestionar entornos o workspaces en Terraform. Un workspace es una forma de gestionar configuraciones en diferentes entornos (como desarrollo, producción, etc.).
- Uso Se utiliza para crear, listar y cambiar entre workspaces.

```bash
terraform workspace list
terraform workspace select workspace_name
