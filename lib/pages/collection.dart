import 'package:flutter/material.dart';

class PokeCollection extends StatelessWidget {
  static String nameRoute = '/collections';
  const PokeCollection({super.key});

  static var sumPoke = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Koleksi Pokemon'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (sumPoke == 0)
                const Text(
                  'Belum ada koleksi pokemon',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w800,
                      fontSize: 30),
                  textAlign: TextAlign.center,
                )
              else
                const Text(
                  'Pokemon ada',
                  style: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w800,
                      fontSize: 30),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ));
  }
}
