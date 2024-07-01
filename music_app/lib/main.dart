import 'package:flutter/material.dart';
import 'package:flutter_by_letsupgrade2/musiclist.dart';
import 'package:flutter_by_letsupgrade2/player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const Musiclist(),
        "/player": (context) => const Player()
      },
    );
  }
}