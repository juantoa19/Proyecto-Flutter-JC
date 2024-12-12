import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart'; // Configuración de Firebase

// Importa todas las pantallas que usarás en tu aplicación
import 'bienvenida.dart';
import 'login.dart';
import 'registro.dart';
import 'descripcion.dart';
import 'opciones.dart';
import 'main_screen.dart';
import 'perfil.dart';
import 'sus_mascotas.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase con la configuración actual de la plataforma
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, // Configuración desde firebase_options.dart
    );
    runApp(MyApp());
  } catch (e) {
    // Imprime el error si Firebase no se inicializa correctamente
    print("Error al inicializar Firebase: $e");
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de depuración
      initialRoute: '/', // Ruta inicial de la aplicación
      routes: {
        '/': (context) => Bienvenida(), // Pantalla de bienvenida
        '/login': (context) => Login(), // Pantalla de login
        '/registro': (context) => Registro(), // Pantalla de registro
        '/descripcion': (context) => Descripcion(), // Pantalla de descripción
        '/opciones': (context) => Opciones(), // Pantalla de opciones
        '/mainScreen': (context) => MainScreen(), // Pantalla principal
        '/perfil': (context) => Perfil(), // Pantalla de perfil
        '/susMascotas': (context) => SusMascotas(), // Pantalla de gestión de mascotas
      },
    );
  }
}
