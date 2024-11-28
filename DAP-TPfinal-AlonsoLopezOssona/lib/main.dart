import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/core/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void testFirestoreConnection() async {
  try {
    // Escribe un documento de prueba
    await FirebaseFirestore.instance
        .collection('test')
        .doc('connectionTest')
        .set({'connected': true});

    // Lee el documento de prueba
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('test')
        .doc('connectionTest')
        .get();

    print('Firebase Firestore connection successful: ${snapshot.data()}');
  } catch (e) {
    print('Error connecting to Firebase Firestore: $e');
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que los widgets estén listos antes de inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  testFirestoreConnection();  
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }
}
