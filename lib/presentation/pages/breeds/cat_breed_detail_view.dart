import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';

class CatBreedDetailView extends StatelessWidget {
  static const routeName = '/cat_breed_detail';

  final CatBreed breed;

  const CatBreedDetailView({required this.breed, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              breed.referenceImageId != null
                  ? Image.network(
                      'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image_not_supported, size: 200),
              const SizedBox(height: 16),
              Text(
                breed.name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Origin: ${breed.origin}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                breed.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              Text(
                'Temperament: ${breed.temperament}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Life Span: ${breed.lifeSpan} years',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Energy Level: ${breed.energyLevel}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Intelligence: ${breed.intelligence}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Grooming: ${breed.grooming}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Hypoallergenic: ${breed.hypoallergenic == 1 ? "Yes" : "No"}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 8),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}
