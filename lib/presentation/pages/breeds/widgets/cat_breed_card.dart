import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';
import 'package:my_super_cat_app/presentation/pages/breeds/cat_breed_detail_view.dart';

class CatBreedCard extends StatelessWidget {
  final CatBreed breed;

  const CatBreedCard({required this.breed, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          CatBreedDetailView.routeName,
          arguments: breed,
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: breed.referenceImageId != null
                    ? Image.network(
                        'https://cdn2.thecatapi.com/images/${breed.referenceImageId}.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.image_not_supported, size: 50),
                title: Text(
                  breed.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(breed.origin),
              ),
              const SizedBox(height: 10),
              Text(
                breed.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Temperament: ${breed.temperament}'),
                        Text('Life Span: ${breed.lifeSpan} years'),
                        Text('Indoor: ${breed.indoor == 1 ? "Yes" : "No"}'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Energy Level: ${breed.energyLevel}'),
                        Text('Intelligence: ${breed.intelligence}'),
                        Text('Grooming: ${breed.grooming}'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: List.generate(
                  breed.energyLevel,
                  (index) => const Icon(Icons.star, size: 16, color: Colors.amber),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}