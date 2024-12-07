import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cuidado de Perros')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/perrito.jpg'), // Imagen del perfil
                  ),
                  SizedBox(height: 10),
                  Text(
                    '¡Bienvenido!',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
            // Opción para "Perfil"
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Perfil'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/perfil');
              },
            ),
            // Opción para "Mis Mascotas"
            ListTile(
              leading: Icon(Icons.pets),
              title: Text('Mis Mascotas'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/susMascotas');
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Información del Proyecto'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/descripcion');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Opciones'),
              onTap: () {
                Navigator.popAndPushNamed(context, '/opciones');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Cerrar Sesión'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/fondo_huellitas.jpg', // Ruta de la imagen de fondo
              fit: BoxFit.cover,
            ),
          ),
          // Contenido de la pantalla
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Título de bienvenida
                  Text(
                    'Bienvenido a la guía de cuidado de perritos',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(height: 20),

                  // Cuadro con información sobre comida hipoalergénica
                  _infoCard(
                    'assets/comida_hipoalergenica.jpg',
                    '¿Qué es la comida de perro hipoalergénica?',
                    'La comida hipoalergénica para perros está diseñada para perros con sensibilidad alimentaria. Usualmente se utiliza para perros con alergias a ciertos ingredientes, como el pollo o el trigo.',
                    Colors.green, // Borde verde
                  ),
                  SizedBox(height: 16),

                  // Cuadro sobre cómo cuidar los dientes del perro
                  _infoCard(
                    'assets/cuidado_dientes.jpg',
                    '¿Cómo cuidar los dientes de tu perro?',
                    'Para cuidar los dientes de tu perro, es importante cepillarlos regularmente con un cepillo y pasta dental especial para perros. Además, los juguetes masticables y las golosinas dentales pueden ayudar a mantener sus dientes limpios.',
                    Colors.blue, // Borde azul
                  ),
                  SizedBox(height: 16),

                  // Cuadro sobre ejercicio y salud
                  _infoCard(
                    'assets/ejercicio_perro.jpg',
                    '¿Por qué es importante el ejercicio para tu perro?',
                    'El ejercicio regular ayuda a mantener a tu perro en forma, reduce el riesgo de obesidad y mejora su salud mental. Los paseos diarios, juegos y actividades son esenciales para su bienestar.',
                    Colors.orange, // Borde naranja
                  ),
                  SizedBox(height: 16),

                  // Cuadro sobre vacunación
                  _infoCard(
                    'assets/vacunacion_perro.jpg',
                    '¿Cuáles son las vacunas necesarias para un perro?',
                    'Las vacunas son cruciales para proteger a tu perro de enfermedades graves. Las principales incluyen las de parvovirus, moquillo y rabia. Consulta a tu veterinario para un plan de vacunación adecuado.',
                    Colors.red, // Borde rojo
                  ),
                  SizedBox(height: 16),

                  // Cuadro sobre baño y aseo
                  _infoCard(
                    'assets/bano_perro.jpg',
                    '¿Con qué frecuencia debo bañar a mi perro?',
                    'La frecuencia con la que debes bañar a tu perro depende de su raza, actividad y tipo de piel. Generalmente, un baño cada 4-6 semanas es suficiente, pero algunos perros necesitan baños más frecuentes.',
                    Colors.purple, // Borde morado
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método para crear tarjetas de información con imagen de fondo y borde
  Widget _infoCard(String imagePath, String title, String description, Color borderColor) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Imagen sobre el tema de la tarjeta, encima del texto
          Image.asset(imagePath, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              title: Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(description, style: TextStyle(fontSize: 16, color: Colors.black)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
