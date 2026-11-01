# Nexo Portfolio — Actividad Integradora 2

**Base de trabajo:** este proyecto reutiliza y mejora la aplicación Flutter de la Actividad Integradora 1 (portafolio móvil). Se conservan la presentación, las habilidades, las tarjetas de proyectos, la navegación al detalle y el formulario, y se agregan servicios nativos desacoplados.

## Identidad visual
- Nombre comercial: **Nexo Portfolio**.
- Paleta: azul noche `#101827`, turquesa `#20D9D2`, verde lima `#C7F36B` y fondo claro `#F5F7FA`.
- Identificador Android/iOS: `com.mikequishpe.nexoportfolio`.
- Icono de aplicación y splash actualizados.

## Funcionalidades
- Portafolio responsive, habilidades, proyectos y navegación a detalle.
- Monitor de conectividad con stream reactivo y banner cuando no hay interfaz de red.
- Persistencia local del estado de conectividad, borrador de contacto y ruta de última imagen con `shared_preferences`.
- Captura desde cámara y selección desde galería, solicitud de permiso de cámara en tiempo de ejecución, recorte y compresión JPEG.
- Notificaciones locales con canal Android `nexo_events` y solicitud de autorización en iOS/Android.

> La detección de conectividad indica disponibilidad de una interfaz de red; no garantiza que un servidor de Internet responda. La prueba real de conectividad debe verificarse en el dispositivo.

## Arquitectura
- `screens/`: presentación y navegación.
- `widgets/`: componentes visuales reutilizables y banner offline.
- `services/`: conectividad, imágenes/permisos y notificaciones.
- `repositories/`: persistencia local.
- `models/`: modelo de proyecto.

Los servicios no dependen de widgets de pantalla. La UI invoca los servicios y representa el resultado; `LocalRepository` centraliza las preferencias locales. La aplicación usa `StatefulWidget`/`setState` para el estado de conectividad global, sin añadir un framework de estado innecesario.

## Requisitos
- Flutter SDK compatible con `environment.sdk` de `pubspec.yaml`.
- Android Studio o VS Code, Android SDK y emulador/dispositivo.
- Para compilar iOS se requiere macOS con Xcode.

## Instalación y ejecución
```bash
cd ecotec_app
flutter doctor -v
flutter pub get
flutter analyze
flutter test
flutter run
```

## Pruebas manuales recomendadas
1. Desactivar Wi-Fi y datos móviles: debe mostrarse el banner rojo de desconexión; el contenido estático sigue visible.
2. Abrir **Servicios del dispositivo** y tomar una foto: verificar permiso, captura, recorte y previsualización.
3. Abrir la galería: seleccionar una imagen, recortarla y comprobar la previsualización.
4. Pulsar **Enviar notificación de prueba**: aceptar permiso y comprobar la alerta del sistema.
5. Cerrar y reabrir la app para comprobar persistencia del último estado de red y de la ruta de imagen (la ruta puede dejar de existir si el sistema limpia el archivo temporal).

## Permisos nativos
- Android: `INTERNET`, `CAMERA`, `POST_NOTIFICATIONS`.
- iOS: textos de propósito para cámara, biblioteca de fotos y adición a biblioteca.
- La selección de fotos usa el selector del sistema cuando está disponible; los permisos varían según la versión del SO.

## Git y entrega
La rama estable propuesta es `main`; el trabajo de integración está en `develop` y las funciones pueden separarse en `feature/connectivity`, `feature/media-permissions` y `feature/local-notifications`. Los commits locales y las ramas deben publicarse en una cuenta GitHub/GitLab del estudiante para disponer de una URL pública verificable. No se afirma que este paquete se haya publicado automáticamente.

## Limitaciones a verificar en el entorno de entrega
- Ejecutar `flutter pub get`, `flutter analyze` y `flutter test` con la versión instalada de Flutter.
- Probar cámara/notificaciones en un dispositivo o emulador compatible; algunas funciones no operan plenamente en el simulador.
- Actualizar el enlace del repositorio y agregar capturas reales en el informe después de publicar y ejecutar las pruebas.
