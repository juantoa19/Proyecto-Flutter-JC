import 'package:flutter/material.dart';

class Descripcion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Descripción del Proyecto'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        // Fondo de huellitas
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo_huellitas.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Imagen de encabezado
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/illustration_dogs.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              
              SizedBox(height: 20),

              // Título de bienvenida
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Bienvenidos a nuestra aplicación dedicada al cuidado de los perros.',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              
              SizedBox(height: 10),
              
              // Descripción introductoria
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'En esta aplicación aprenderás cómo cuidar a tu perro de manera integral. Desde la salud y nutrición hasta consejos de entrenamiento y bienestar emocional, nuestro objetivo es asegurarnos de que tu perro viva una vida larga y feliz.',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                  textAlign: TextAlign.justify,
                ),
              ),
              
              Divider(color: Colors.purple, thickness: 1.5, indent: 16, endIndent: 16), // Separador

              // Características principales en tarjetas
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Características principales:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              _buildExpandableFeatureCard('💪 Ejercicios y actividades para mantener a tu perro saludable.', 'Realiza actividades físicas que fortalezcan el corazón y los músculos de tu perro, como caminatas, correr, y jugar con pelotas. El ejercicio regular mejora la salud y la longevidad de tu mascota.'),
              _buildExpandableFeatureCard('🍖 Guías de alimentación basadas en la raza, tamaño y edad del perro.', 'Cada perro tiene necesidades alimenticias únicas. Ofrecemos guías sobre cómo elegir el alimento adecuado para tu perro según su raza, tamaño y edad, asegurando su bienestar general.'),
              _buildExpandableFeatureCard('🩺 Información sobre salud y cuidados veterinarios recomendados.', 'Las visitas regulares al veterinario son esenciales para mantener la salud de tu perro. Ofrecemos recomendaciones sobre vacunas, desparacitación y exámenes de salud preventivos.'),
              _buildExpandableFeatureCard('🏞️ Recomendación de lugares pet-friendly cerca de ti.', 'Te ayudamos a encontrar parques, restaurantes y otros lugares donde puedas llevar a tu perro sin problemas, promoviendo la interacción social y el disfrute mutuo.'),
              _buildExpandableFeatureCard('👩‍⚕️ Consejos sobre entrenamiento y comportamiento canino.', 'El entrenamiento adecuado es esencial para el comportamiento de tu perro. Aquí te ofrecemos consejos prácticos para enseñar a tu perro comandos básicos, evitar conductas indeseadas y fomentar su bienestar emocional.'),

              Divider(color: Colors.purple, thickness: 1.5, indent: 16, endIndent: 16), // Separador

              // Botón interactivo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Aquí puedes agregar la acción que se realice al presionar el botón
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('¡Gracias por unirte al cuidado de los perros!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,  // Reemplazado 'primary' por 'backgroundColor'
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    '¡Comienza a cuidar de tu perro ahora!',
                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold), // Cambiar texto a negro y negrita
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Sección con enlace a más información
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GestureDetector(
                  onTap: () {
                    // Acción al hacer click (puedes redirigir a otra pantalla si lo deseas)
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Redirigiendo a más información...')),
                    );
                  },
                  child: Text(
                    'Aprende más sobre el cuidado de los perros',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Método para crear las tarjetas desplegables con características
  Widget _buildExpandableFeatureCard(String title, String content) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Row(
          children: <Widget>[
            Icon(Icons.check_circle, color: Colors.purple),
            SizedBox(width: 8),
            Expanded(child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black))), // Texto en negrita y negro
          ],
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(content, style: TextStyle(fontSize: 14, color: Colors.black)), // Texto en negro
          ),
        ],
      ),
    );
  }
}
