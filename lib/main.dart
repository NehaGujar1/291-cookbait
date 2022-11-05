import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'frontEndHomeScreen.dart';
import 'frontEndDisplayRecipes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final List<String> fuck = ['tomato',
    'salt',
    'cumin powder jeera',
    'pepper pepper',
    'cloves garlic',
    'virgin olive oil',
    'onion',
    'dry beans such cannellini soya beans',
    'red chilli powder cayenne pepper',
    'dried oregano'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: ChoicesScreen(selectedIngredients: fuck),
      home: const MyHomePage(),
    );
  }
}



