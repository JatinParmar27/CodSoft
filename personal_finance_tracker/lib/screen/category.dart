import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  const Category(String s, {super.key});

  Object? get name => null;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
    );
  }
}
