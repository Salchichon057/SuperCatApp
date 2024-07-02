class CatBreed {
  final String name;
  final String origin;
  final int energyLevel;
  final String description;
  final String referenceImageId;
  final String temperament;
  final int intelligence;

  CatBreed({
    required this.name,
    required this.origin,
    required this.energyLevel,
    required this.description,
    required this.referenceImageId,
    required this.temperament,
    required this.intelligence,
  });

  factory CatBreed.fromJson(Map<String, dynamic> json) {
    return CatBreed(
      name: json['name'],
      origin: json['origin'],
      energyLevel: json['energy_level'],
      description: json['description'],
      referenceImageId: json['reference_image_id'],
      temperament: json['temperament'] ?? '',
      intelligence: json['intelligence'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'origin': origin,
      'energy_level': energyLevel,
      'description': description,
      'reference_image_id': referenceImageId,
      'temperament': temperament,
      'intelligence': intelligence,
    };
  }
}
