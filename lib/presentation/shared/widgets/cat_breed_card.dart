import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';
import 'package:my_super_cat_app/presentation/pages/breeds/cat_breed_detail_view.dart';
import 'package:my_super_cat_app/utils/database/database_helper.dart';

class CatBreedCard extends StatefulWidget {
  final CatBreed breed;
  final bool isFavorite;
  final bool showFavoriteIcon;

  const CatBreedCard({
    required this.breed,
    this.isFavorite = false,
    this.showFavoriteIcon = true,
    super.key,
  });

  @override
   createState() => _CatBreedCardState();
}

class _CatBreedCardState extends State<CatBreedCard> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() async {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    if (_isFavorite) {
      await dbHelper.insertCat(widget.breed);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Added to favorites')),
      );
    } else {
      await dbHelper.deleteCat(widget.breed.id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Removed from favorites')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          CatBreedDetailView.routeName,
          arguments: widget.breed,
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
              Row(
                children: [
                  widget.breed.referenceImageId != null
                      ? Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://cdn2.thecatapi.com/images/${widget.breed.referenceImageId}.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 50);
                              },
                            ),
                          ),
                        )
                      : const Icon(Icons.image_not_supported, size: 50),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.breed.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(widget.breed.origin),
                      ],
                    ),
                  ),
                  if (widget.showFavoriteIcon)
                    IconButton(
                      icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                      onPressed: _toggleFavorite,
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.breed.description,
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
                        Text('Temperament: ${widget.breed.temperament}'),
                        Text('Life Span: ${widget.breed.lifeSpan} years'),
                        Text('Indoor: ${widget.breed.indoor == 1 ? "Yes" : "No"}'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Energy Level: ${widget.breed.energyLevel}'),
                        Text('Intelligence: ${widget.breed.intelligence}'),
                        Text('Grooming: ${widget.breed.grooming}'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: List.generate(
                  widget.breed.energyLevel,
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
