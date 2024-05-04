import 'package:flutter/material.dart';
import 'package:flutter_application_12/screens/home.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  static var name;

   LoginView({super.key});

  TextEditingController passController = TextEditingController() ;
  TextEditingController userController = TextEditingController() ;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body: Column (mainAxisAlignment: MainAxisAlignment.center,

          children: [
            const Text("Introduzca su usuario y contraseña",style: TextStyle(color:Color.fromARGB(244, 60, 10, 107), fontWeight: FontWeight.bold)),
             TextField(
              controller: userController,
              decoration: const InputDecoration(
                hintText: 'Usuario', hintStyle: TextStyle(color:Color.fromARGB(244, 60, 10, 107), fontWeight: FontWeight.bold),
                icon: Icon(Icons.person_2_sharp),
             ),
            ),

             TextField(
              controller: passController,
              decoration: const InputDecoration(
                hintText: 'Contraseña',hintStyle: TextStyle(color:Color.fromARGB(244, 60, 10, 107), fontWeight: FontWeight.bold),
                icon: Icon(Icons.lock_clock_sharp),
              ),
              obscureText: true,
            ),

             const SizedBox(height: 50),

             ElevatedButton(
              onPressed: (){
                String inputUser = userController.text;
                String inputPass = passController.text;

                if(inputPass.isEmpty || inputUser.isEmpty){
                  print("Contraseña o User vacíos");
                }

                if ((inputUser == "LMK") && (inputPass == "LaraMiliKya") ){
                  print("Inicio de sesión exitoso");

                  context.pushNamed(RegisterView.name , extra: inputUser);
                }
                else{
                  print("Inicio de sesión fallido");
                }
                }, 

              child: const Text('Iniciar sesión'), 

            ),




        ],),
      );


  }
}
