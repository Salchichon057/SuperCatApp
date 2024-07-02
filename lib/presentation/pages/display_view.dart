import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';
import 'package:my_super_cat_app/infraestructure/services/cat_breed_service.dart';

class DisplayView extends StatefulWidget {
  static const routeName = '/display_view';

  const DisplayView({super.key});

  @override
  createState() => _DisplayViewState();
}

class _DisplayViewState extends State<DisplayView> {
  final CatBreedService _catBreedService = CatBreedService();
  List<CatBreed> catBreeds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCatBreeds();
  }

  Future<void> _fetchCatBreeds() async {
    try {
      final breeds = await _catBreedService.fetchCatBreeds();
      print(breeds);
      setState(() {
        catBreeds = breeds;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cat Breeds')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: catBreeds.length,
              itemBuilder: (context, index) {
                final breed = catBreeds[index];
                return ListTile(
                  title: Text(breed.name),
                  subtitle: Text(breed.origin),
                );
              },
            ),
    );
  }
}