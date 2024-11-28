import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/List_provider.dart';

class CardScreen extends ConsumerWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(listProvider);
    final pressed = ref.watch(pressedProvider);

    return Scaffold(
    appBar: AppBar(
  title: listAsync.when(
    data: (list) => Text(
      list[pressed].title,
      style: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    loading: () => const Text(
      'Cargando...',
      style: TextStyle(
        fontFamily: 'Raleway',
        fontSize: 25,
        color: Colors.white,
      ),
    ),
    error: (error, stackTrace) => Text(
      'Error: $error',
      style: const TextStyle(
        fontFamily: 'Raleway',
        fontSize: 25,
        color: Colors.white,
      ),
    ),
  ),
  backgroundColor: Colors.purple.shade300,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    color: Colors.white,
    onPressed: () {
      Navigator.pop(context);
    },
  ),
),
body: Stack(
  children: [
    Center(
      child: listAsync.when(
        data: (list) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                list[pressed].imagesrc,
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 20),
              Text(
                list[pressed].title,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  color: Colors.purple,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    list[pressed].text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'Raleway',
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text(
          'Error: $error',
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontSize: 20,
            color: Colors.red,
          ),
        ),
      ),
    ),
    Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        backgroundColor: Colors.pink.shade300,
        onPressed: () {
          context.push('/edit');
        },
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    ),
    Positioned(
      bottom: 90,
      right: 16,
      child: FloatingActionButton(
        backgroundColor: Colors.pink.shade300,
        onPressed: () {
          listAsync.when(
            data: (list) {
              list.removeAt(pressed);
              ref.read(listaddProvider).addMovie(list);
              context.go('/home');
            },
            loading: () => const CircularProgressIndicator(),
            error: (error, stackTrace) => Text('Error: $error'),
          );
        },
        child: const Icon(Icons.delete, color: Colors.white),
      ),
    ),
  ],
),);
  }
}
