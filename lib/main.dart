import 'package:flutter/material.dart';
import 'package:movie_world/providers/movie_provider.dart';
import 'package:movie_world/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider(), lazy: false)
      ],
      child: MyApp(),
    );
  }
}

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
