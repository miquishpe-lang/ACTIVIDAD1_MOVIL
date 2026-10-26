# Actividad Integradora 1 — Portafolio móvil

Prototipo móvil realizado con Flutter como adaptación del contenido del portafolio HTML de referencia.

## Funcionalidades
- Pantalla principal con presentación, habilidades y proyectos destacados.
- Tarjetas de proyectos reutilizables.
- Navegación mediante `Navigator.push` y `MaterialPageRoute`.
- Paso del objeto `Project` desde la pantalla principal a la pantalla de detalle.
- Formulario con validación de nombre, correo y mensaje.
- Regreso mediante `Navigator.pop`.

## Estructura
```text
lib/
├── main.dart
├── models/
│   └── project.dart
├── screens/
│   ├── home_screen.dart
│   └── detail_screen.dart
└── widgets/
    └── project_card.dart
```

## Ejecutar
1. Instalar Flutter y configurar Android Studio/VS Code y un emulador o dispositivo.
2. Desde esta carpeta ejecutar `flutter doctor -v`.
3. Ejecutar `flutter pub get`.
4. Ejecutar `flutter run`.

## Evidencias pendientes de generar localmente
Las capturas de `flutter doctor -v`, las pantallas ejecutándose y la URL pública del repositorio deben obtenerse desde el equipo del estudiante. No se incluyen capturas simuladas ni se afirma que el proyecto haya sido publicado.

## Registro progresivo sugerido para Git
Realiza los commits durante el desarrollo, no como un único commit final:
1. `chore: configurar estructura inicial del proyecto`
2. `feat: maquetar pantalla principal del portafolio`
3. `feat: crear modelo y tarjetas reutilizables de proyectos`
4. `feat: agregar detalle, formulario y paso de parámetros`
5. `docs: documentar ejecución y evidencias de la actividad`

## Declaración de uso de IA
Si se utilizó asistencia de IA, declarar en el informe qué herramienta se utilizó, para qué tareas y qué partes fueron revisadas, comprendidas, probadas y adaptadas personalmente. La declaración final debe reflejar el trabajo real del estudiante.

## Nota sobre el formulario
El formulario valida los campos y muestra una confirmación local. No envía mensajes a un servicio externo ni almacena información.
