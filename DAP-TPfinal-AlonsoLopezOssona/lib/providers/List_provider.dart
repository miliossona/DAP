import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/entities/Post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

List<Post> posts = [];

class MoviesNotifier extends StateNotifier {
  MoviesNotifier() : super([]);

  Future<void> addMovie(List<Post> equipos) async {
    final doc = db.collection('maquillaje').doc('Maquillaje');
    try {
      var upload = <String, dynamic>{};
      for (var equipo in equipos) {
        upload[equipo.title] = [
          equipo.description,
          equipo.text,
          equipo.imagesrc
        ];
      }
      await doc.set(upload);
    } catch (e) {
      print(e);
    }
  }

  Stream<List<Post>> getMovies() {
    return db.collection('maquillaje').doc('Maquillaje').snapshots().map((snapshot) {
      posts = [];
      var data = snapshot.data();
      for (var element in data!.entries) {
        posts.add(Post(
            title: element.key,
            description: element.value[0],
            text: element.value[1],
            imagesrc: element.value[2]));
      }
      posts = posts.reversed.toList();
      
      return posts;
    });
  }
}


int pressed = -1;

final listProvider = StreamProvider((ref) => MoviesNotifier().getMovies());
final listaddProvider = Provider((ref) => MoviesNotifier());

final pressedProvider = StateProvider((ref) {
  return pressed;
});
