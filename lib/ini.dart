import 'package:flutter/material.dart';

class Tulisan extends StatelessWidget {
  // final String title;

  const Tulisan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: const Text(
        // title,
        'uweeee',
        style: TextStyle(
            fontSize: 40,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
