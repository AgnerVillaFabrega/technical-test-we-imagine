import { Controller, Get } from '@nestjs/common';
import { ApiTags, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AppService } from './app.service';

@ApiTags('app') // Esta etiqueta agrupa las rutas relacionadas con "app"
@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @ApiOperation({ summary: 'Obtener mensaje de bienvenida' })
  @ApiResponse({ status: 200, description: 'Operación exitosa', type: String })
  getHello(): string {
    return this.appService.getHello();
  }
}