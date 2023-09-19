// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_study/models/favorites.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = 'favorites_page';
  static const fullPath = '/$routeName';

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的收藏"),
      ),
      body: Consumer<Favorites>(
        builder: (BuildContext context, Favorites value, Widget? child) {
          print('===============');
          print(value.items.length);
          return value.items.isNotEmpty
              ? ListView.builder(
              itemCount: value.items.length,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) {
                return FavoriteItemTile(value.items[index]);
              })
              : const Center(
              child: Text("暂无收藏"),
          );
        },),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final int position;

  const FavoriteItemTile(this.position, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[position % Colors.primaries.length],
        ),
        title: Text(
          'Item $position',
          key: Key('favorites_text_$position'),
        ),
        trailing: IconButton(
          key: Key('remove_icon_$position'),
          icon: const Icon(Icons.close),
          onPressed: () {
            context.read<Favorites>().remove(position);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from favorites.'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
