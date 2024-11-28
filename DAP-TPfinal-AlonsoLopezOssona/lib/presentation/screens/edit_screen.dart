import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myapp/providers/List_provider.dart';
import 'package:myapp/entities/Post.dart';

class EditScreen extends ConsumerWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(listProvider);
    final pressed = ref.watch(pressedProvider);
    String title;
    String imagesrc;
    late TextEditingController title_controller;
    late TextEditingController description_controller;
    late TextEditingController text_controller;
    late TextEditingController imgsrc_controller;

    title = '';
    imagesrc = '';

    if (pressed == -1) {
      title = 'Nuevo Post';
      title_controller = TextEditingController();
      description_controller = TextEditingController();
      text_controller = TextEditingController();
      imgsrc_controller = TextEditingController();
      imagesrc =
          'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/e40834b0-4b40-4416-9085-9147feccf94d/d4mj7zi-8c3a08a4-d69a-4ae3-a25a-87d8d250b690.png/v1/fill/w_500,h_500/estrella_png_negra_by_rubyok_d4mj7zi-fullview.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NTAwIiwicGF0aCI6IlwvZlwvZTQwODM0YjAtNGI0MC00NDE2LTkwODUtOTE0N2ZlY2NmOTRkXC9kNG1qN3ppLThjM2EwOGE0LWQ2OWEtNGFlMy1hMjVhLTg3ZDhkMjUwYjY5MC5wbmciLCJ3aWR0aCI6Ijw9NTAwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.5rGBUrfH4aA5QNuzvsKJp7_LUZQOWf3wpQ5EdfG61w0';
    } else {
      listAsync.when(
        data: (list) {
          title = list[pressed].title;
          title_controller = TextEditingController(text: list[pressed].title);
          description_controller =
              TextEditingController(text: list[pressed].description);
          text_controller = TextEditingController(text: list[pressed].text);
          imgsrc_controller =
              TextEditingController(text: list[pressed].imagesrc);
          imagesrc = list[pressed].imagesrc;
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      );
    }

    return Scaffold(
       appBar: AppBar(
  title: Text(
    title,
    style: const TextStyle(
      fontFamily: 'Raleway', // Fuente personalizada
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  backgroundColor: Colors.purple.shade300, // Fondo violeta claro
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    color: Colors.white,
    onPressed: () {
      Navigator.pop(context);
    },
  ),
),
body: Center(
  child: SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          imagesrc,
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: title_controller,
          decoration: InputDecoration(
            labelText: "Titulo",
            labelStyle: TextStyle(
              color: Colors.purple.shade700,
              fontFamily: 'Raleway', // Fuente personalizada
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.purple.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pink.shade300, // Rosa claro al enfocar
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: description_controller,
          decoration: InputDecoration(
            labelText: "Nombre",
            labelStyle: TextStyle(
              color: Colors.purple.shade700,
              fontFamily: 'Raleway',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.purple.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pink.shade300,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: text_controller,
          maxLines: null,
          decoration: InputDecoration(
            labelText: "Descripción",
            labelStyle: TextStyle(
              color: Colors.purple.shade700,
              fontFamily: 'Raleway',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.purple.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pink.shade300,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: imgsrc_controller,
          decoration: InputDecoration(
            labelText: "Imagen",
            labelStyle: TextStyle(
              color: Colors.purple.shade700,
              fontFamily: 'Raleway',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.purple.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.pink.shade300,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            listAsync.when(
              data: (list) {
                if (pressed != -1) {
                  list[pressed].title = title_controller.text;
                  list[pressed].description = description_controller.text;
                  list[pressed].text = text_controller.text;
                  list[pressed].imagesrc = imgsrc_controller.text;
                  ref.read(listaddProvider).addMovie(list);
                  context.go('/home');
                } else {
                  if (title_controller.text == '' ||
                      description_controller.text == '' ||
                      text_controller.text == '' ||
                      imgsrc_controller.text == '') {
                    const SnackBar snackBar = SnackBar(
                      content: Text("Los campos deben ser completados"),
                      duration: Duration(seconds: 3),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    list.add(Post(
                      title: title_controller.text,
                      description: description_controller.text,
                      text: text_controller.text,
                      imagesrc: imgsrc_controller.text,
                    ));
                    ref.read(listaddProvider).addMovie(list);
                    context.push('/home');
                  }
                }
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stackTrace) => Text('Error: $error'),
            );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.pink.shade300, // Texto blanco
            textStyle: const TextStyle(
              fontFamily: 'Raleway', // Fuente personalizada
              fontSize: 16,
            ),
          ),
          child: const Text("Guardar"),
        ),
      ],
    ),
  ),
));
  }
}
