import 'package:flutter/material.dart';
import '../models/project.dart';

class DetailScreen extends StatefulWidget {
  final Project project;
  const DetailScreen({super.key, required this.project});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gracias, ${_nameController.text.trim()}. Formulario validado.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del proyecto')),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(radius: 29, backgroundColor: colors.primary.withValues(alpha: 0.13), child: Icon(project.icon, size: 30, color: colors.primary)),
          const SizedBox(height: 16),
          Text(project.category.toUpperCase(), style: TextStyle(color: colors.secondary, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 12)),
          const SizedBox(height: 8),
          Text(project.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, height: 1.2)),
          const SizedBox(height: 14),
          const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Text(project.description, style: const TextStyle(height: 1.5, fontSize: 15)),
          const SizedBox(height: 16),
          const Text('Tecnologías utilizadas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Text(project.technologies, style: TextStyle(color: colors.secondary, fontWeight: FontWeight.w600)),
        ]))),
        const SizedBox(height: 20),
        const Text('Formulario de contacto', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('Completa los campos para validar tu mensaje. Esta demostración no envía datos a un servidor.', style: TextStyle(color: Color(0xFF626873), height: 1.4)),
        const SizedBox(height: 14),
        Form(key: _formKey, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nombre', hintText: 'Tu nombre', prefixIcon: Icon(Icons.person_outline), border: OutlineInputBorder()), validator: (value) => value == null || value.trim().isEmpty ? 'Ingresa tu nombre.' : null),
          const SizedBox(height: 13),
          TextFormField(controller: _emailController, keyboardType: TextInputType.emailAddress, decoration: const InputDecoration(labelText: 'Correo electrónico', hintText: 'tu@email.com', prefixIcon: Icon(Icons.email_outlined), border: OutlineInputBorder()), validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Ingresa tu correo.';
            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) return 'Ingresa un correo válido.';
            return null;
          }),
          const SizedBox(height: 13),
          TextFormField(controller: _messageController, maxLines: 4, decoration: const InputDecoration(labelText: 'Mensaje', hintText: 'Escribe tu mensaje...', alignLabelWithHint: true, border: OutlineInputBorder()), validator: (value) => value == null || value.trim().isEmpty ? 'Escribe un mensaje.' : null),
          const SizedBox(height: 16),
          FilledButton.icon(onPressed: _sendMessage, icon: const Icon(Icons.send), label: const Text('Validar y enviar')),
          const SizedBox(height: 8),
          OutlinedButton.icon(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back), label: const Text('Volver al portafolio')),
        ])),
      ]),
    );
  }
}
