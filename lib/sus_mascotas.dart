import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // Para usar kIsWeb

void main() {
  runApp(MaterialApp(
    home: SusMascotas(),
  ));
}

class SusMascotas extends StatefulWidget {
  @override
  _SusMascotasState createState() => _SusMascotasState();
}

class _SusMascotasState extends State<SusMascotas> {
  final List<Map<String, dynamic>> _mascotas = [
    {
      'nombre': 'Firulais',
      'edad': 3,
      'fechaNacimiento': DateTime(2021, 5, 20),
      'raza': 'Labrador',
      'peso': 20.0,
      'comidaFavorita': 'Pollo',
      'imagen': File('assets/perrito.jpg'),  // Cambia esta ruta si usas una imagen local
      'borderColor': Colors.blue,  // Color de borde azul
    },
    {
      'nombre': 'Rex',
      'edad': 2,
      'fechaNacimiento': DateTime(2022, 7, 12),
      'raza': 'Pastor Alemán',
      'peso': 25.5,
      'comidaFavorita': 'Carne',
      'imagen': File('assets/perrito.jpg'),
      'borderColor': Colors.green,  // Color de borde verde
    },
    {
      'nombre': 'Chester',
      'edad': 5,
      'fechaNacimiento': DateTime(2019, 11, 15),
      'raza': 'Bulldog',
      'peso': 15.3,
      'comidaFavorita': 'Arroz con pollo',
      'imagen': File('assets/perrito.jpg'),
      'borderColor': Colors.orange,  // Color de borde naranja
    },
  ];

  String _nombre = '';
  int _edad = 0;
  DateTime _fechaNacimiento = DateTime.now();
  String _raza = '';
  double _peso = 0.0;
  String _comidaFavorita = '';
  File? _imagen;

  // Controladores de texto para los campos
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _razaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _comidaController = TextEditingController();

  // Selección de imagen desde la galería o cámara
  final ImagePicker _picker = ImagePicker();

  Future<void> _tomarImagen() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagen = File(image.path);
      });
    }
  }

  void _agregarMascota() {
    if (_nombre.isNotEmpty && _edad > 0 && _raza.isNotEmpty) {
      setState(() {
        _mascotas.add({
          'nombre': _nombre,
          'edad': _edad,
          'fechaNacimiento': _fechaNacimiento,
          'raza': _raza,
          'peso': _peso,
          'comidaFavorita': _comidaFavorita,
          'imagen': _imagen,
          'borderColor': Colors.purple,  // Bordes morados para las nuevas mascotas
        });
      });
      Navigator.of(context).pop(); // Cerrar el diálogo después de agregar la mascota
    }
  }

  // Función para seleccionar la fecha de nacimiento
  Future<void> _seleccionarFecha(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaNacimiento,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _fechaNacimiento) {
      setState(() {
        _fechaNacimiento = picked;
      });
    }
  }

  // Mostrar formulario de agregar mascota en un Dialog
  void _mostrarFormulario() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Nueva Mascota'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                // Campo de nombre
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(labelText: 'Nombres'),
                  onChanged: (value) => _nombre = value,
                ),
                // Campo de edad
                TextField(
                  controller: _edadController,
                  decoration: InputDecoration(labelText: 'Edad'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _edad = int.tryParse(value) ?? 0,
                ),
                // Selección de fecha de nacimiento
                Row(
                  children: [
                    Text("Fecha de Nacimiento: "),
                    TextButton(
                      onPressed: () => _seleccionarFecha(context),
                      child: Text('${_fechaNacimiento.toLocal()}'.split(' ')[0]),
                    ),
                  ],
                ),
                // Campo de raza
                TextField(
                  controller: _razaController,
                  decoration: InputDecoration(labelText: 'Raza'),
                  onChanged: (value) => _raza = value,
                ),
                // Campo de peso
                TextField(
                  controller: _pesoController,
                  decoration: InputDecoration(labelText: 'Peso (kg)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _peso = double.tryParse(value) ?? 0.0,
                ),
                // Campo de comida favorita
                TextField(
                  controller: _comidaController,
                  decoration: InputDecoration(labelText: 'Comida Favorita'),
                  onChanged: (value) => _comidaFavorita = value,
                ),
                SizedBox(height: 16),
                // Botón para seleccionar imagen
                GestureDetector(
                  onTap: _tomarImagen,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    color: Colors.blueAccent,
                    child: Text(
                      _imagen == null ? 'Seleccionar Imagen' : 'Imagen Seleccionada',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _agregarMascota,
                  child: Text('Agregar Mascota'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Mascotas'),
        backgroundColor: Colors.purple, // Color morado para el AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo_huellitas.jpg'), // Asegúrate de tener esta imagen en tu carpeta assets
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Lista de mascotas
            Text('Lista de Mascotas', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _mascotas.map((mascota) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: mascota['borderColor'], width: 3), // Borde con color personalizado
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Imagen de la mascota
                          mascota['imagen'] != null && !kIsWeb
                              ? ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Image.file(
                                    mascota['imagen'],
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  height: 150,
                                  width: double.infinity,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.pets, size: 50, color: Colors.white),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                // Datos de la mascota debajo de la imagen
                                Text(mascota['nombre'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                Text('Edad: ${mascota['edad']} años', style: TextStyle(fontSize: 14)),
                                Text('Raza: ${mascota['raza']}', style: TextStyle(fontSize: 14)),
                                Text('Peso: ${mascota['peso']} kg', style: TextStyle(fontSize: 14)),
                                Text('Comida Favorita: ${mascota['comidaFavorita']}', style: TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            // Botón para agregar una nueva mascota con estilo personalizado
            ElevatedButton(
              onPressed: _mostrarFormulario,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Color de fondo morado
                foregroundColor: Colors.black, // Texto negro
              ),
              child: Text('Agregar Mascota'),
            ),
          ],
        ),
      ),
    );
  }
}
