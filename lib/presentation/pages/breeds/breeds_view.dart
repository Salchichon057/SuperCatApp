import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';
import 'package:my_super_cat_app/infraestructure/services/cat_breed_service.dart';
import 'package:my_super_cat_app/presentation/shared/settings_view.dart';
import 'package:my_super_cat_app/presentation/shared/widgets/cat_breed_card.dart';
import 'package:my_super_cat_app/utils/database/database_helper.dart';

class BreedsView extends StatefulWidget {
  static const routeName = '/breeds_view';

  const BreedsView({super.key});

  @override
  createState() => _BreedsViewState();
}

class _BreedsViewState extends State<BreedsView> {
  final CatBreedService catBreedService = CatBreedService();
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<List<String>> _getFavoriteIds() async {
    final favorites = await dbHelper.getCats();
    return favorites.map((cat) => cat.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breeds'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsView.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<CatBreed>>(
        future: catBreedService.fetchCatBreeds(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading breeds'));
          } else {
            final catBreeds = snapshot.data!;
            return FutureBuilder<List<String>>(
              future: _getFavoriteIds(),
              builder: (context, favSnapshot) {
                if (favSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (favSnapshot.hasError) {
                  return const Center(child: Text('Error loading favorites'));
                } else {
                  final favoriteIds = favSnapshot.data!;
                  return ListView.builder(
                    itemCount: catBreeds.length,
                    itemBuilder: (context, index) {
                      final breed = catBreeds[index];
                      final isFavorite = favoriteIds.contains(breed.id);
                      return CatBreedCard(breed: breed, isFavorite: isFavorite);
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
