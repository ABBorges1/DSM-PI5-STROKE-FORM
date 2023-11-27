import 'dart:convert' as convert;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Patient {
  final String name;
  final double age;
  final String gender;
  final String phone;
  final String stroke;
  final double avg_glucose_level;
  final double bmi;
  final String ever_married;
  final int heart_disease;
  final int hypertension;
  final String residence_type;
  final String smoking_status;
  final String work_type;

  Patient(
      {required this.name,
      required this.age,
      required this.gender,
      required this.phone,
      required this.stroke,
      required this.avg_glucose_level,
      required this.bmi,
      required this.ever_married,
      required this.heart_disease,
      required this.hypertension,
      required this.residence_type,
      required this.smoking_status,
      required this.work_type});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      phone: json['phone'],
      stroke: json['stroke'],
      avg_glucose_level: json['avg_glucose_level'],
      bmi: json['bmi'],
      ever_married: json['ever_married'],
      heart_disease: json['heart_disease'],
      hypertension: json['hypertension'],
      residence_type: json['residence_type'],
      smoking_status: json['smoking_status'],
      work_type: json['work_type'],
    );
  }
}

class PatientList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Pacientes',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(63, 72, 248, 0.6),
      ),
      home: PatientListScreen(),
    );
  }
}

class PatientListScreen extends StatefulWidget {
  @override
  _PatientListScreenState createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  late List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    fetchPatients();
  }

  Future<void> fetchPatients() async {
    final response = await http
        .get(Uri.parse('https://strokeform.azurewebsites.net/prediction'));

    if (response.statusCode == 200) {
      final List<dynamic> data = convert.jsonDecode(response.body);
      patients = data.map((json) => Patient.fromJson(json)).toList();
      if (kDebugMode) {
        print(patients);
      }
      setState(() {});
    } else {
      throw Exception('Erro ao carregar a lista de pacientes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pacientes'),
      ),
      body: patients.length > 0
          ? ListView.builder(
              itemCount: patients.length,
              itemBuilder: (context, index) {
                return buildPatientCard(
                  profileIcon: patients[index].gender == 'Masculino'
                      ? Icons.person
                      : Icons.person_2,
                  name: patients[index].name,
                  age: patients[index].age,
                  gender: patients[index].gender,
                  stroke: patients[index].stroke,
                  phoneNumber: patients[index].phone,
                );
                // Card(
                //   color: Colors.blue[900], // Azul escuro
                //   child: ListTile(
                //     title: Text(
                //       patients[index].name,
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

Widget buildPatientCard({
  required IconData profileIcon,
  required String name,
  required double age,
  required String gender,
  required String stroke,
  required String phoneNumber,
}) {
  return Card(
      margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      elevation: 8.0,
      borderOnForeground: true,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(97, 105, 245, 1),
              Color.fromRGBO(63, 72, 248, 0.6),
            ], // Defina as cores do seu gradiente
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Profile Icon
              Icon(
                profileIcon,
                size: 60.0,
                color: Colors.white,
              ),
              const SizedBox(width: 16.0),
              // Patient Information
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Idade: $age, Gênero: $gender',
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  Text(
                    'Telefone: $phoneNumber',
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  Text(
                    stroke == 'Stroke'
                        ? 'Tem pré disposição'
                        : 'Não tem pré disposição',
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
}



// import 'dart:convert';
// import 'dart:ffi';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert' as convert;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: PatientHistoryScreen(),
//     );
//   }
// }

// class PatientHistoryScreen extends StatelessWidget {
//   const PatientHistoryScreen({super.key});

//   @override
//   Future<Widget> build(BuildContext context) async {
//     Array patient = await getPatients();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Histórico de pacientes'),
//         backgroundColor: const Color.fromRGBO(97, 105, 245, 1),
//       ),
//       body: ListView(
//         children: [
//           buildPatientCard(
//             profileIcon: Icons.person,
//             name: 'Guilherme de A. M. Ferreira',
//             age: 23,
//             gender: 'Masculino',
//             lastVisit: '22/11/2023',
//             phoneNumber: '(16) 99234-9923',
//           ),
//           buildPatientCard(
//             profileIcon: Icons.person_2,
//             name: 'Camila Vitória',
//             age: 19,
//             gender: 'Feminíno',
//             lastVisit: '20/11/2023',
//             phoneNumber: '(16) 992312-8998',
//           ),
//           buildPatientCard(
//             profileIcon: Icons.person,
//             name: 'Adriel B. Borges',
//             age: 25,
//             gender: 'Masculino',
//             lastVisit: '21/11/2023',
//             phoneNumber: '(16) 987341-1931',
//           ),
//           buildPatientCard(
//             profileIcon: Icons.person_2,
//             name: 'Rafaela Silva',
//             age: 56,
//             gender: 'Feminíno',
//             lastVisit: '20/11/2023',
//             phoneNumber: '(16) 3723-3212',
//           ),
//           // Add more patient cards as needed
//         ],
//       ),
//     );
//   }

//   Widget buildPatientCard({
//     required IconData profileIcon,
//     required String name,
//     required int age,
//     required String gender,
//     required String lastVisit,
//     required String phoneNumber,
//   }) {
//     return Card(
//         margin: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
//         elevation: 8.0,
//         borderOnForeground: true,
//         child: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromRGBO(97, 105, 245, 1),
//                 Color.fromRGBO(63, 72, 248, 0.6),
//               ], // Defina as cores do seu gradiente
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 // Profile Icon
//                 Icon(
//                   profileIcon,
//                   size: 60.0,
//                   color: Colors.white,
//                 ),
//                 const SizedBox(width: 16.0),
//                 // Patient Information
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: const TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white),
//                     ),
//                     Text(
//                       'Idade: $age, Gênero: $gender',
//                       style:
//                           const TextStyle(fontSize: 16.0, color: Colors.white),
//                     ),
//                     Text(
//                       'Ultima Visita: $lastVisit',
//                       style:
//                           const TextStyle(fontSize: 16.0, color: Colors.white),
//                     ),
//                     Text(
//                       'Telefone: $phoneNumber',
//                       style:
//                           const TextStyle(fontSize: 16.0, color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }

// Future getPatients() async {
//   Uri url = Uri.parse('https://strokeform.azurewebsites.net/prediction');

//   final response = await http.get(
//     url,
//     headers: {
//       'Content-Type': 'application/json',
//     },
//   );

//   if (kDebugMode) {
//     print('Response status: ${response.statusCode}');
//   }

//   if (response.statusCode == 200) {
//     Object data = convert.jsonDecode(response.body);
//     return data;
//   } else {
//     throw Exception('Failed to load patients');
//   }
// }
