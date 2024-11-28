import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/User_provider.dart';

TextEditingController userController = TextEditingController();
TextEditingController passController = TextEditingController();

var logged = false;

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  var usuariosAsync = ref.watch(userProvider);

  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Inicio de sesion",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: userController,
              decoration: InputDecoration(
                hintText: 'Usuario',
                hintStyle: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(Icons.person, color: Colors.purple),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Contraseña',
                hintStyle: const TextStyle(
                  fontFamily: 'Raleway',
                  color: Colors.grey,
                ),
                prefixIcon: const Icon(Icons.key, color: Colors.purple),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              usuariosAsync.when(
                data: (usuarios) {
                  for (var usuario in usuarios) {
                    if (usuario.email == userController.text &&
                        usuario.password == passController.text) {
                      context.go('/home');
                      logged = true;
                      ref.read(loggedProvider.notifier).state =
                          userController.text;
                      break;
                    } else if (userController.text == '' &&
                        passController.text == '' &&
                        usuarios.last == usuario) {
                      SnackBar snackBar = const SnackBar(
                        content: Text("Campos vacios"),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (userController.text == '' &&
                        usuarios.last == usuario) {
                      SnackBar snackBar = const SnackBar(
                        content: Text("Usuario vacío"),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (passController.text == '' &&
                        usuarios.last == usuario) {
                      SnackBar snackBar = const SnackBar(
                        content: Text("Contraseña vacía"),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (logged == false && usuarios.last == usuario) {
                      SnackBar snackBar = const SnackBar(
                        content: Text("usuario y/o contraseña incorrectos"),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                loading: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Cargando"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                error: (error, stack) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Error al cargar usuarios: $error"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  print(error);
                },
              );
              logged = false;
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.pink.shade300,
              textStyle: const TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text("Iniciar sesion"),
          ),
        ],
      ),
    ),
  );
}

  }

