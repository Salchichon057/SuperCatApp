import 'package:flutter/material.dart';

class FavoritesView extends StatelessWidget {
  static const routeName = '/favorites_view';
  
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const Center(
        child: Text('Favorites'),
        ),
      );
  }
}