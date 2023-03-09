import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './pages/collection.dart';
import './pages/home_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initHiveForFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Not Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MyHomePage.nameRoute,
      routes: {
        MyHomePage.nameRoute: (context) => const MyHomePage(
              title: 'Poke Not GO',
            ),
        PokeCollection.nameRoute: (context) => const PokeCollection(),
      }, // home: const MyHomePage(title: 'Poke Not GO'),
    );
  }
}
