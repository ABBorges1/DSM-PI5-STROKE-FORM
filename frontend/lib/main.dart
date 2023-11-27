import 'package:avc_form/pages/form_patient.dart';
import 'package:avc_form/pages/history_patient.dart';
import 'package:avc_form/pages/login.dart';
import 'package:avc_form/pages/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const InitialApp());

// class HomePage extends StatelessWidget {w
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//       	child: Container(
// 	        child: Column(
// 	          children: <Widget>[
// 	            Container(
// 	              height: 400,
// 	              decoration: BoxDecoration(
// 	                image: DecorationImage(
// 	                  image: AssetImage('assets/images/background.png'),
// 	                  fit: BoxFit.fill
// 	                )
// 	              ),
// 	              child: Stack(
// 	                children: <Widget>[
// 	                  Positioned(
// 	                    child: Container(
// 	                      // margin: EdgeInsets.only(top: 50),
// 	                      child: Center(
// 	                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
// 	                      ),
// 	                    )),
// 	                ],
// 	              ),
// 	            ),
// 	            Padding(
// 	              padding: EdgeInsets.all(30.0),
// 	              child: Column(
// 	                children: <Widget>[
// 	                  Container(
// 	                    padding: EdgeInsets.all(5),
// 	                    decoration: BoxDecoration(
// 	                      color: Colors.white,
// 	                      borderRadius: BorderRadius.circular(10),
//                         border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
// 	                      boxShadow: [
// 	                        BoxShadow(
// 	                          color: Color.fromRGBO(143, 148, 251, .2),
// 	                          blurRadius: 20.0,
// 	                          offset: Offset(0, 10)
// 	                        )
// 	                      ]
// 	                    ),
// 	                    child: Column(
// 	                      children: <Widget>[
// 	                        Container(
// 	                          padding: EdgeInsets.all(8.0),
// 	                          decoration: BoxDecoration(
// 	                            border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
// 	                          ),
// 	                          child: TextField(
// 	                            decoration: InputDecoration(
// 	                              border: InputBorder.none,
// 	                              hintText: "Nome de usuário",
// 	                              hintStyle: TextStyle(color: Colors.grey[700])
// 	                            ),
// 	                          ),
// 	                        ),
// 	                        Container(
// 	                          padding: EdgeInsets.all(8.0),
// 	                          child: TextField(
//                               obscureText: true,
// 	                            decoration: InputDecoration(
// 	                              border: InputBorder.none,
// 	                              hintText: "Senha",
// 	                              hintStyle: TextStyle(color: Colors.grey[700])
// 	                            ),
// 	                          ),
// 	                        )
// 	                      ],
// 	                    ),
//                     ),
// 	                  SizedBox(height: 30,),
// 	                  Container(
// 	                    height: 50,
// 	                    decoration: BoxDecoration(
// 	                      borderRadius: BorderRadius.circular(10),
// 	                      gradient: LinearGradient(
// 	                        colors: [
// 	                          Color.fromRGBO(97, 105, 245, 1),
// 	                          Color.fromRGBO(63, 72, 248, 0.6),
// 	                        ]
// 	                      )
// 	                    ),
//                       child: GestureDetector(
//                       onTap: () {
//                         salvarLoginSenhaLocalmente();
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => OtherPage()),
//                         );
//                       },
// 	                    child: Center(
// 	                      child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
// 	                    ),
// 	                  ),
// 	                  SizedBox(height: 70,),
// 	                  // FadeInUp(duration: Duration(milliseconds: 2000), child: Text("Forgot Password?", style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),)),
// 	                ],
// 	              ),
// 	            )
// 	          ],
// 	        ),
// 	      ),
//       )
//     );
//   }
// }
class InitialApp extends StatelessWidget {
  const InitialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         routes: {
      '/': (context) => LoginPage(),
      '/home': (context) => const HomePage(),
      '/form-patient': (context) => const FormPage(),
      '/historico': (context) => PatientList(),
      },
    );
  }
}
