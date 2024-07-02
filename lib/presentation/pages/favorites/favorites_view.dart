import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';
import 'package:my_super_cat_app/presentation/shared/settings_view.dart';
import 'package:my_super_cat_app/presentation/shared/widgets/cat_breed_card.dart';
import 'package:my_super_cat_app/utils/database/database_helper.dart';

class FavoritesView extends StatefulWidget {
  static const routeName = '/favorites_view';

  const FavoritesView({super.key});

  @override
   createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late Future<List<CatBreed>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _favoritesFuture = dbHelper.getCats();
  }

  void _removeFavorite(String id) async {
    await dbHelper.deleteCat(id);
    setState(() {
      _favoritesFuture = dbHelper.getCats();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Removed from favorites')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          // el botón de cambiar tema
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsView.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<CatBreed>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading favorites'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          } else {
            final cats = snapshot.data!;
            return ListView.builder(
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final cat = cats[index];
                return Dismissible(
                  key: Key(cat.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _removeFavorite(cat.id);
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Stack(
                    children: [
                      CatBreedCard(
                        breed: cat,
                        isFavorite: true,
                        showFavoriteIcon: false,
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          color: Colors.black54,
                          child: const Text(
                            'Swipe to remove',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
