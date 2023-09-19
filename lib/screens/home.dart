import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/models/favorites.dart';
import 'package:flutter_study/screens/favorites.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing Sample"),
        actions: [
          TextButton.icon(
              onPressed: () => context.go(FavoritesPage.fullPath),
              icon: const Icon(Icons.favorite_border),
              label: const Text("收藏"))
        ],
      ),
      // body: ListView.builder(
      //   itemCount: 100,
      //   cacheExtent: 20.0,
      //   itemExtent: 100,
      //   controller: ScrollController(),
      //   shrinkWrap: true,
      //   padding: const EdgeInsets.symmetric(vertical: 16),
      //   itemBuilder: (context, index) => ItemTile(index),
      // ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return ItemTile(index);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.red,
            indent: 20,
            endIndent: 20,
          );
        },
        cacheExtent: 20.0,
        itemCount: 100,
        controller: ScrollController(),
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final int position;

  const ItemTile(this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesList = context.watch<Favorites>();
    return SizedBox(
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.primaries[position % Colors.primaries.length],
              child: Text(
                '$position',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              'Item $position',
              key: Key("text_$position"),
            ),
            trailing: IconButton(
              key: Key('icon_$position'),
              icon: favoritesList.items.contains(position)
                  ? const Icon(Icons.favorite_rounded)
                  : const Icon(Icons.favorite_border),
              onPressed: () {
                !favoritesList.items.contains(position)
                    ? favoritesList.add(position)
                    : favoritesList.remove(position);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        favoritesList.items.contains(position) ? '添加收藏' : '取消收藏'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
    ));
  }
}
