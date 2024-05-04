import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  static const String name = 'home';
  const RegisterView({super.key, required String userName});
  static String id = 'register_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Bienvenido LMK!', 
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.purple
              )),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.person ),
                Text('User: LMK',
              style: TextStyle(fontSize: 24),),],
               ),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.key ),
                Text('Password: LaraMiliKya',
              style: TextStyle(fontSize: 24),),],
                
               )] 

            ),
          )
          
        ),
      );
  }
}
  
