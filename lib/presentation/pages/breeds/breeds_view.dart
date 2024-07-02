import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';
import 'package:my_super_cat_app/infraestructure/services/cat_breed_service.dart';
import 'package:my_super_cat_app/presentation/pages/breeds/widgets/cat_breed_card.dart';
import 'package:my_super_cat_app/presentation/shared/settings_view.dart';

class BreedsView extends StatelessWidget {
  static const routeName = '/breeds_view';

  const BreedsView({super.key});

  @override
  Widget build(BuildContext context) {
    final CatBreedService catBreedService = CatBreedService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Breeds'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsView.routeName);
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
            return ListView.builder(
              itemCount: catBreeds.length,
              itemBuilder: (context, index) {
                final breed = catBreeds[index];
                return CatBreedCard(breed: breed);
              },
            );
          }
        },
      ),
    );
  }
}
