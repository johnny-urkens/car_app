import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  String name;

  ListPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testtekst"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Text(name),
      ),
    );
  }
}
