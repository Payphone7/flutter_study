import 'package:flutter/material.dart';
import 'package:flutter_study/models/favorites.dart';
import 'package:flutter_study/screens/favorites.dart';
import 'package:flutter_study/screens/home.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

GoRouter router() {
  return GoRouter(routes: [
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) => const HomePage(),
      // 会有返回键，放到同级没有返回键
      routes: [
        GoRoute(
            path: FavoritesPage.routeName,
            builder: (context, state) => const FavoritesPage()),
      ],
    ),
    //同级别，没有返回键
    // GoRoute(
    //     path: FavoritesPage.fullPath,
    //     builder: (context, state) => const FavoritesPage()),
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Favorites(),
      child: MaterialApp.router(
        title: "Testing Sample",
        theme: ThemeData(
            colorSchemeSeed: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true
        ),
        routerConfig: router(),
      ),
    );
  }
}
