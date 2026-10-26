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
- main.dart
-models/
    - project.dart
-screens/
    - home_screen.dart
    - detail_screen.dart
-widgets/
    - project_card.dart
```

## Ejecutar
1. Instalar Flutter y configurar Android Studio/VS Code y un emulador o dispositivo.
2. Desde esta carpeta ejecutar `flutter doctor -v`.
3. Ejecutar `flutter pub get`.
4. Ejecutar `flutter run`.