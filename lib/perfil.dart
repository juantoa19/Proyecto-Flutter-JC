import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700], // Color del AppBar (morado)
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), // Ícono de regreso
          onPressed: () {
            Navigator.pop(context);  // Acción de regreso a la pantalla anterior
          },
        ),
        title: Text(
          'Mi Perfil',  // Título del header
          style: TextStyle(
            color: Colors.white,  // Color blanco para el texto
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,  // Fondo blanco
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Contenedor principal con bordes redondeados y sombra
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,  // Fondo blanco
                  borderRadius: BorderRadius.circular(20),  // Bordes redondeados
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Foto de perfil
                    CircleAvatar(
                      radius: 80,  // Foto de perfil más grande
                      backgroundImage: AssetImage('assets/perrito.jpg'),  // Asegúrate de tener esta imagen en tu carpeta assets
                    ),
                    SizedBox(height: 20),
                    // Nombre y título
                    Text(
                      'Juan Pérez',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,  // Texto negro
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Diseñador Digital y Amante de los Perros',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,  // Texto negro
                      ),
                    ),
                    SizedBox(height: 20),
                    // Descripción breve
                    Text(
                      'Soy un diseñador con pasión por la creatividad. Me encanta experimentar con nuevas ideas y proyectos, y siempre busco mejorar. También soy amante de los animales y disfruto pasar tiempo con mis perros.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,  // Texto negro
                      ),
                    ),
                    SizedBox(height: 30),

                    // Información de contacto
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.purple[50],  // Fondo morado claro
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildInfoRow(Icons.location_on, "121 Rock Street, NY"),
                          _buildInfoRow(Icons.phone, "337-419-3958"),
                          _buildInfoRow(Icons.email, "contacto@miemail.com"),
                          _buildInfoRow(Icons.web, "www.juanperezdesign.com"),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),

                    // Botón de editar perfil
                    ElevatedButton(
                      onPressed: () {
                        // Acción de editar perfil
                        print("Editar perfil");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[700],  // Color morado para el botón
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Editar Perfil',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,  // Texto blanco en el botón
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget personalizado para mostrar las filas de información (como ubicación, teléfono, etc.)
  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple[700], size: 25),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,  // Texto negro para la información
              ),
            ),
          ),
        ],
      ),
    );
  }
}
