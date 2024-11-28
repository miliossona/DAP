import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/List_provider.dart';
import 'package:myapp/providers/User_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var postsAsync = ref.watch(listProvider);
    String usuario = ref.watch(loggedProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bienvenido $usuario",
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple.shade300,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.pink.shade300, // Texto blanco
                textStyle: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                ),
              ),
              child: const Text("Salir de la sesion"),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: postsAsync.when(
                data: (posts) {
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        color: Colors.purple.shade50, // Fondo violeta muy claro
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Colors.purple.shade300, // Borde violeta
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            post.title,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          subtitle: Text(
                            post.description,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            ref.read(pressedProvider.notifier).state = index;
                            context.push('/card');
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                error: (error, stack) {
                  return Center(
                    child: Text(
                      "Error durante la carga: $error",
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink.shade300,
        onPressed: () {
          ref.read(pressedProvider.notifier).state = -1;
          context.push('/edit');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
