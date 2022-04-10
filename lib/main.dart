import 'package:flutter/material.dart';
import 'package:movie_world/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const Color primary = Colors.purple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie World',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'detail': (_) => DetailsScreen(),
      },
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        color: primary,
      )),
    );
  }
}
