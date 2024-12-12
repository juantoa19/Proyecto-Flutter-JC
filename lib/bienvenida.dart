import 'package:flutter/material.dart';

class Bienvenida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Encabezado con fondo degradado y texto "Welcome"
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple.shade200, const Color.fromARGB(255, 176, 92, 189)], // Fondo del título
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'WELCOME',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Text(
                    'Bienestar Canina 🐾',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'En nuestro espacio, nos apasiona brindarles a los perritos el amor y cuidado que merecen. Ya sea que busques consejos sobre salud, alimentación, adiestramiento o simplemente tips para mejorar su bienestar, aquí encontrarás todo lo que necesitas para ser el mejor amigo de tu mascota.'
                    '\n\nExplora nuestros recursos, únete a nuestra comunidad y juntos ayudemos a que nuestros peludos vivan felices y saludables. ¡Cada perrito merece ser cuidado con el corazón!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            // Fondo con imagen debajo del cuadro morado
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/illustration_dogs.jpg'), // Reemplaza con tu imagen
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  // Imagen ilustrativa central
                  Image.asset(
                    'assets/illustration_dogs.jpg', // Asegúrate de que la imagen esté en tu carpeta assets
                    height: 250,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported,
                        size: 100,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  // Botón de Login
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login'); // Ruta para el Login
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Botón de Sign Up
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/registro'); // Ruta para el Registro
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.purple),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                      ),
                      child: Text(
                        'Registrate',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
