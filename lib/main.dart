import 'package:flutter/material.dart';
import 'bienvenida.dart';
import 'login.dart';
import 'registro.dart';
import 'descripcion.dart';
import 'opciones.dart';
import 'main_screen.dart';
import 'perfil.dart';          // Importa el archivo Perfil
import 'sus_mascotas.dart';    // Importa el archivo SusMascotas

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Bienvenida(),
        '/login': (context) => Login(),
        '/registro': (context) => Registro(),
        '/descripcion': (context) => Descripcion(),
        '/opciones': (context) => Opciones(),
        '/mainScreen': (context) => MainScreen(),
        '/perfil': (context) => Perfil(),        // Nueva ruta para Perfil
        '/susMascotas': (context) => SusMascotas(),  // Nueva ruta para Mis Mascotas
      },
    );
  }
}
