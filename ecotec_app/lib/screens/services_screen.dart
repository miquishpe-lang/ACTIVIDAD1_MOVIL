import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart'
    as permission_handler;

import '../repositories/local_repository.dart';
import '../services/image_service.dart';
import '../services/notification_service.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final ImageService _images = ImageService();
  final LocalRepository _repository = LocalRepository();

  String? _imagePath;
  bool _working = false;

  @override
  void initState() {
    super.initState();
    _restoreImage();
  }

  // Restaurar la última imagen guardada localmente.
  Future<void> _restoreImage() async {
    try {
      final path = await _repository.readImagePath();

      if (mounted && path != null && File(path).existsSync()) {
        setState(() {
          _imagePath = path;
        });
      }
    } catch (error) {
      debugPrint('Error al restaurar imagen: $error');
    }
  }

  // Abrir los ajustes de permisos del dispositivo.
  Future<void> _openAppSettings() async {
    await permission_handler.openAppSettings();
  }

  // Capturar una fotografía o seleccionar una imagen.
  Future<void> _selectImage(ImageSource source) async {
    if (_working) return;

    setState(() {
      _working = true;
    });

    try {
      final path = await _images.captureOrChoose(source);

      if (path != null) {
        await _repository.saveImagePath(path);

        if (mounted) {
          setState(() {
            _imagePath = path;
          });

          _message('Imagen preparada y guardada localmente.');
        }
      }
    } on ImagePermissionException catch (error) {
      _message(
        error.message,
        action: error.permanentlyDenied ? 'Ajustes' : null,
        onAction:
            error.permanentlyDenied ? _openAppSettings : null,
      );
    } catch (error) {
      _message(
        'No fue posible procesar la imagen. '
        'Verifica los permisos e inténtalo nuevamente.',
      );

      debugPrint('Error de imagen: $error');
    } finally {
      if (mounted) {
        setState(() {
          _working = false;
        });
      }
    }
  }

  // Solicitar permisos y enviar una notificación de prueba.
  Future<void> _notify() async {
    try {
      final granted =
          await NotificationService.instance.requestPermission();

      if (!granted) {
        _message(
          'Las notificaciones están desactivadas. '
          'Habilítalas en Ajustes.',
        );
        return;
      }

      await NotificationService.instance.showTestNotification();

      _message(
        'Notificación local enviada. '
        'Revisa el centro de notificaciones.',
      );
    } catch (error) {
      _message('No se pudo enviar la notificación.');

      debugPrint('Error de notificación: $error');
    }
  }

  // Mostrar mensajes mediante SnackBar.
  void _message(
    String text, {
    String? action,
    VoidCallback? onAction,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        action: action == null
            ? null
            : SnackBarAction(
                label: action,
                onPressed: onAction ?? () {},
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Servicios del dispositivo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Funciones nativas',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          const Text(
            'Prueba la cámara, la galería, el procesamiento '
            'local de imágenes y las notificaciones del sistema.',
          ),

          const SizedBox(height: 20),

          // SECCIÓN DE CÁMARA Y GALERÍA.
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.photo_camera_back_outlined),
                      SizedBox(width: 10),
                      Text(
                        'Cámara y galería',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Solicita permisos cuando corresponde, '
                    'permite previsualizar y recortar, '
                    'y comprime la imagen en JPEG.',
                  ),

                  const SizedBox(height: 14),

                  // PREVISUALIZACIÓN DE LA IMAGEN.
                  if (_imagePath != null &&
                      File(_imagePath!).existsSync()) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.file(
                        File(_imagePath!),
                        height: 230,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ] else
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colors.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.image_outlined,
                        size: 48,
                      ),
                    ),

                  const SizedBox(height: 12),

                  // BOTONES DE CÁMARA Y GALERÍA.
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _working
                              ? null
                              : () => _selectImage(
                                    ImageSource.camera,
                                  ),
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                          ),
                          label: const Text('Tomar foto'),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _working
                              ? null
                              : () => _selectImage(
                                    ImageSource.gallery,
                                  ),
                          icon: const Icon(
                            Icons.photo_library_outlined,
                          ),
                          label: const Text('Galería'),
                        ),
                      ),
                    ],
                  ),

                  // INDICADOR DE PROCESAMIENTO.
                  if (_working)
                    const Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: LinearProgressIndicator(),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // SECCIÓN DE NOTIFICACIONES.
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.notifications_active_outlined),
                      SizedBox(width: 10),
                      Text(
                        'Notificaciones locales',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Solicita autorización y emite una alerta '
                    'local mediante el canal nativo de la aplicación.',
                  ),

                  const SizedBox(height: 14),

                  FilledButton.icon(
                    onPressed: _notify,
                    icon: const Icon(Icons.notifications),
                    label: const Text(
                      'Enviar notificación de prueba',
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // INFORMACIÓN DE CONECTIVIDAD.
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.wifi_tethering),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'La conectividad se supervisa en segundo '
                      'plano desde el servicio global de la aplicación. '
                      'Al perder la red, aparece una banda informativa '
                      'y el portafolio estático continúa disponible.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
