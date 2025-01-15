import { ApiProperty } from '@nestjs/swagger';

export class CreateUserDto {
  @ApiProperty({
    description: 'ID único del usuario',
    example: 1,
    required: false, // Si el campo no es obligatorio, puedes especificarlo
  })
  id: number;

  @ApiProperty({
    description: 'Nombre del usuario',
    example: 'John',
  })
  name: string;

  @ApiProperty({
    description: 'Apellido del usuario',
    example: 'Doe',
  })
  surname: string;
}
