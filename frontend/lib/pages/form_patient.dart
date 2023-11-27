import 'dart:ffi';

import 'package:avc_form/pages/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FormPatientPage(),
    );
  }
}

class FormPatientPage extends StatefulWidget {
  const FormPatientPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormPatientPageState createState() => _FormPatientPageState();
}

class _FormPatientPageState extends State<FormPatientPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _avgGlucoseLevelController =
      TextEditingController();

  final TextEditingController _genderController = TextEditingController();
  List<SelectOption> getGender = <SelectOption>[
    const SelectOption('Male', 'Masculino'),
    const SelectOption('Female', 'Feminino'),
  ];

  final TextEditingController _hypertensionController = TextEditingController();
  List<SelectOption> getHipertension = <SelectOption>[
    const SelectOption('1', 'SIM'),
    const SelectOption('0', 'NÃO'),
  ];

  final TextEditingController _heartDiseaseController = TextEditingController();
  List<SelectOption> getHearthDisease = <SelectOption>[
    const SelectOption('1', 'SIM'),
    const SelectOption('0', 'NÃO'),
  ];

  final TextEditingController _everMarriedController = TextEditingController();
  List<SelectOption> getEverMarried = <SelectOption>[
    const SelectOption('Yes', 'SIM'),
    const SelectOption('No', 'NÃO'),
  ];

  final TextEditingController _workTypeController = TextEditingController();
  List<SelectOption> getWorkType = <SelectOption>[
    const SelectOption('Private', 'Privado'),
    const SelectOption('Self-employed', 'Autônomo'),
    const SelectOption('Govt_job ', 'Emprego público'),
    const SelectOption('Never_worked', 'Nunca trabalhou'),
  ];

  final TextEditingController _residenceTypeController =
      TextEditingController();
  List<SelectOption> getResidenceType = <SelectOption>[
    const SelectOption('Rural', 'Rural'),
    const SelectOption('Urban', 'Urbano'),
  ];

  final TextEditingController _smokeStatusController = TextEditingController();
  List<SelectOption> getSmokesStatus = <SelectOption>[
    const SelectOption('formerly smoked', 'Ex-fumante'),
    const SelectOption('smokes', 'Fumante'),
    const SelectOption('never smoked', 'Nunca fumou'),
  ];

  String _mesagem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario paciente'),
        backgroundColor: const Color.fromRGBO(97, 105, 245, 1),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: InputDecoration(
                    labelText: 'Nome completo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nome é obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Telefone é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _ageController,
                  decoration: InputDecoration(
                    labelText: 'Idade',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Idade é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _bmiController,
                  decoration: InputDecoration(
                    labelText: 'Indice de Massa Corporal (IMC)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'IMC é obrigatório.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _avgGlucoseLevelController,
                  decoration: InputDecoration(
                    labelText: 'Nivel Médio de Glucose no Sangue.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Nivel médio de glucose é obrigatório.';
                    }
                    return null;
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 10),
                    hint: const Text(
                      'Selecione o gênero',
                    ),
                    value: _genderController.text.isEmpty
                        ? null
                        : _genderController.text,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: getGender.map((SelectOption option) {
                      return DropdownMenuItem<String>(
                        value: option.value,
                        child: Text(option.label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _genderController.text = val.toString();
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 10),
                    hint: const Text(
                      'Hipertensão',
                    ),
                    value: _hypertensionController.text.isEmpty
                        ? null
                        : _hypertensionController.text,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: getHipertension.map((SelectOption option) {
                      return DropdownMenuItem<String>(
                        value: option.value,
                        child: Text(option.label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _hypertensionController.text = val.toString();
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 10),
                    hint: const Text(
                      'Doença Cardíaca',
                    ),
                    value: _heartDiseaseController.text.isEmpty
                        ? null
                        : _heartDiseaseController.text,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: getHipertension.map((SelectOption option) {
                      return DropdownMenuItem<String>(
                        value: option.value,
                        child: Text(option.label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _heartDiseaseController.text = val.toString();
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 10),
                    hint: const Text(
                      'Casado(a)',
                    ),
                    value: _everMarriedController.text.isEmpty
                        ? null
                        : _everMarriedController.text,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: getEverMarried.map((SelectOption option) {
                      return DropdownMenuItem<String>(
                        value: option.value,
                        child: Text(option.label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _everMarriedController.text = val.toString();
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 10),
                    hint: const Text(
                      'Tipo de trabalho',
                    ),
                    value: _workTypeController.text.isEmpty
                        ? null
                        : _workTypeController.text,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: getWorkType.map((SelectOption option) {
                      return DropdownMenuItem<String>(
                        value: option.value,
                        child: Text(option.label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _workTypeController.text = val.toString();
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 10),
                    hint: const Text(
                      'Tipo de residência',
                    ),
                    value: _residenceTypeController.text.isEmpty
                        ? null
                        : _residenceTypeController.text,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: getResidenceType.map((SelectOption option) {
                      return DropdownMenuItem<String>(
                        value: option.value,
                        child: Text(option.label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _residenceTypeController.text = val.toString();
                      });
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 50,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButton(
                    isExpanded: true,
                    padding: const EdgeInsets.only(left: 10),
                    hint: const Text(
                      'Status de fumante',
                    ),
                    value: _smokeStatusController.text.isEmpty
                        ? null
                        : _smokeStatusController.text,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    items: getSmokesStatus.map((SelectOption option) {
                      return DropdownMenuItem<String>(
                        value: option.value,
                        child: Text(option.label),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _smokeStatusController.text = val.toString();
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navegar para a tela "Histórico de pacientes"
                    if (_formKey.currentState!.validate()) {
                      // sendDataToApi();
                      postData();
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width - 30,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color.fromRGBO(97, 105, 245, 1),
                        Color.fromRGBO(63, 72, 248, 0.6),
                      ]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "EVIAR FORMULARIO",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future postData() async {
    Uri url = Uri.parse('https://strokeform.azurewebsites.net/predict');

    final Map<String, dynamic> data = {
      'gender': _genderController.text,
      'ever_married': _everMarriedController.text,
      'work_type': _workTypeController.text,
      'residence_type': _residenceTypeController.text,
      'smoking_status': _smokeStatusController.text,
      'age': _ageController.text,
      'hypertension': _hypertensionController.text,
      'heart_disease': _heartDiseaseController.text,
      'avg_glucose_level': _avgGlucoseLevelController.text,
      'bmi': _bmiController.text,
      'name': _fullNameController.text,
      'phone': _phoneController.text,
    };

    String requestBody = convert.jsonEncode(data);

    if (kDebugMode) {
      print(requestBody);
    }

    try {
      final response = await http.post(
        url,
        body: requestBody,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final teste = convert.jsonDecode(response.body);

        if (teste == 1) {
          _mesagem =
              'O Paciente ${_fullNameController.text} apresenta predisposição a AVC.';
          _exibirAlerta(context);
        } else {
          _mesagem =
              'O Paciente ${_fullNameController.text} não apresenta predisposição a AVC.';

          _exibirAlerta(context);
        }
        // ignore: use_build_context_synchronously
      }
    } catch (e) {
      print('Erro na requisição POST: $e');
    }
  }

  void _exibirAlerta(BuildContext context) {
    const msg = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Paciente cadastrado com sucesso!'),
          content: Text(_mesagem),
          actions: [
            FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/home");
              },
              child: Text('OK'),
              backgroundColor: Color.fromRGBO(97, 105, 245, 1),
            ),
          ],
        );
      },
    );
  }
}

class SelectOption {
  final String value;
  final String label;

  const SelectOption(this.value, this.label);
}
