import { NestFactory } from '@nestjs/core'
import { AppModule } from './app.module'
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger'

async function bootstrap() {
  const app = await NestFactory.create(AppModule)
  // Configuración de Swagger
  const config = new DocumentBuilder()
    .setTitle('API Users') // Título de la API
    .setDescription('Api from Users technical test ') // Descripción de la API
    .setVersion('1.0') // Versión de la API
    .addTag('users') // Puedes agregar tags a tu API
    .build()

  const document = SwaggerModule.createDocument(app, config) // Crear el documento Swagger
  SwaggerModule.setup('api', app, document) // Configurar la ruta donde estará Swagger
  await app.listen(3000)
}
bootstrap()
