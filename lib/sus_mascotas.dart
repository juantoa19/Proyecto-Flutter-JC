import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SusMascotas extends StatefulWidget {
  @override
  _SusMascotasState createState() => _SusMascotasState();
}

class _SusMascotasState extends State<SusMascotas> {
  String _nombre = '';
  int _edad = 0;
  DateTime _fechaNacimiento = DateTime.now();
  String _raza = '';
  double _peso = 0.0;
  String _comidaFavorita = '';
  String _color = '';
  String _sexo = '';
  String _microchip = '';
  File? _imagen;

  final ImagePicker _picker = ImagePicker();

  // Selección de imagen desde la galería
  Future<void> _tomarImagen() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagen = File(image.path);
      });
    }
  }

  // Subir imagen a Firebase Storage y obtener URL
  Future<String> _subirImagenFirebase() async {
    if (_imagen == null) return '';
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('mascotas/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_imagen!);
      return await storageRef.getDownloadURL();
    } catch (e) {
      print('Error al subir imagen: $e');
      return '';
    }
  }

  // Agregar nueva mascota
  void _agregarMascota() async {
    if (_nombre.isNotEmpty && _edad > 0 && _raza.isNotEmpty) {
      String imagenUrl = await _subirImagenFirebase(); // Subir la imagen a Firebase Storage

      // Crear un mapa con los datos de la mascota
      Map<String, dynamic> mascotaData = {
        'nombre': _nombre,
        'edad': _edad,
        'fechaNacimiento': _fechaNacimiento.toIso8601String(),
        'raza': _raza,
        'peso': _peso,
        'comidaFavorita': _comidaFavorita,
        'color': _color,
        'sexo': _sexo,
        'microchip': _microchip,
        'imagen': imagenUrl.isNotEmpty ? imagenUrl : 'assets/salchicha.jpg', // URL de imagen
      };

      try {
        // Guardar los datos en Firestore
        await FirebaseFirestore.instance.collection('mascotas').add(mascotaData);

        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mascota agregada exitosamente')),
        );

        // Cerrar el formulario
        Navigator.of(context).pop();
      } catch (e) {
        print('Error al agregar la mascota: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al agregar la mascota')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor completa todos los campos obligatorios')),
      );
    }
  }

  // Mostrar formulario para agregar mascota
  Future<void> _mostrarFormulario() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Agregar Nueva Mascota'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Nombre'),
                  onChanged: (value) => _nombre = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Edad'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _edad = int.tryParse(value) ?? 0,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Raza'),
                  onChanged: (value) => _raza = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Peso (kg)'),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _peso = double.tryParse(value) ?? 0.0,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Comida Favorita'),
                  onChanged: (value) => _comidaFavorita = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Color'),
                  onChanged: (value) => _color = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Sexo'),
                  onChanged: (value) => _sexo = value,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Número de Microchip'),
                  onChanged: (value) => _microchip = value,
                ),
                SizedBox(height: 16),
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
    int columnas = MediaQuery.of(context).size.width > 600 ? 3 : 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Mascotas'),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo_huellitas.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Lista de Mascotas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('mascotas').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final mascotas = snapshot.data?.docs ?? [];

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnas,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: mascotas.length,
                    itemBuilder: (context, index) {
                      final mascota = mascotas[index].data() as Map<String, dynamic>;

                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.purple, width: 3),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(mascota['imagen']),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.5), BlendMode.darken),
                                    ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          mascota['imagen'],
                                          height: 120,
                                          width: 120,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Icon(
                                        Icons.pets,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        '${mascota['nombre'] ?? 'Sin nombre'}',
                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Edad: ${mascota['edad'] ?? 'Sin edad'} años',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Raza: ${mascota['raza'] ?? 'Sin raza'}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Peso: ${mascota['peso'] ?? 'Sin peso'} kg',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Comida Favorita: ${mascota['comidaFavorita'] ?? 'Sin comida favorita'}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Color: ${mascota['color'] ?? 'Sin color'}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Sexo: ${mascota['sexo'] ?? 'Sin sexo'}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Microchip: ${mascota['microchip'] ?? 'Sin microchip'}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarFormulario,
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
