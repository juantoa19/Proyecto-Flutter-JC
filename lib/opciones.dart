import 'package:flutter/material.dart';

class Opciones extends StatefulWidget {
  @override
  _OpcionesState createState() => _OpcionesState();
}

class _OpcionesState extends State<Opciones> {
  bool isNotificationEnabled = true;
  bool isDarkMode = false;
  String selectedDogDiet = 'Normal';
  int exerciseTime = 30; // en minutos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Opciones'),
        backgroundColor: Colors.purple,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Configuración de notificaciones
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Activar Notificaciones', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                leading: Icon(Icons.notifications, color: Colors.purple),
                trailing: Switch(
                  value: isNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isNotificationEnabled = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(isNotificationEnabled
                          ? 'Notificaciones activadas'
                          : 'Notificaciones desactivadas'),
                    ));
                  },
                  activeColor: Colors.purple,
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 12),

            // Configuración de tema claro/oscuro
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Modo Oscuro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                leading: Icon(Icons.brightness_6, color: Colors.purple),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (bool value) {
                    setState(() {
                      isDarkMode = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(isDarkMode
                          ? 'Modo oscuro activado'
                          : 'Modo oscuro desactivado'),
                    ));
                  },
                  activeColor: Colors.purple,
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 12),

            // Selección de dieta para el perro
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Tipo de Dieta de tu Perro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                leading: Icon(Icons.fastfood, color: Colors.purple),
                trailing: Container(
                  width: 150,
                  child: DropdownButton<String>(
                    value: selectedDogDiet,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDogDiet = newValue!;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Dieta seleccionada: $selectedDogDiet'),
                      ));
                    },
                    items: <String>['Normal', 'Vegetariana', 'Sin Gluten', 'Baja en Grasa']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 16)),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12),

            // Temporizador de ejercicio
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Tiempo de Ejercicio (en minutos)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                subtitle: Text('$exerciseTime min', style: TextStyle(fontSize: 16)),
                leading: Icon(Icons.access_time, color: Colors.purple),
                trailing: Container(
                  width: 150,
                  child: Slider(
                    value: exerciseTime.toDouble(),
                    min: 10,
                    max: 120,
                    divisions: 22,
                    label: exerciseTime.toString(),
                    onChanged: (double value) {
                      setState(() {
                        exerciseTime = value.toInt();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Tiempo de ejercicio ajustado a $exerciseTime minutos'),
                      ));
                    },
                  ),
                ),
              ),
            ),

            Divider(),

            // Enlace a preguntas frecuentes
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Ayuda y Soporte', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                leading: Icon(Icons.help_outline, color: Colors.purple),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Redirigiendo a preguntas frecuentes...')));
                },
              ),
            ),

            SizedBox(height: 12),

            // Botón para eliminar cuenta
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text('Eliminar Cuenta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.red)),
                leading: Icon(Icons.delete, color: Colors.red),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('¿Estás seguro?'),
                        content: Text('¿Quieres eliminar tu cuenta de manera permanente?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Lógica para eliminar la cuenta
                              Navigator.of(context).pop();
                            },
                            child: Text('Eliminar'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
