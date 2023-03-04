import 'package:flutter/material.dart';

class PokeDetail extends StatelessWidget {
  static String nameRoute = '/detail';
  const PokeDetail({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Details'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'detail pokemon ${id}',
                style: const TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
