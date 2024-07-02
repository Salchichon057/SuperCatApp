import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/models/cat_breed.dart';
import 'package:my_super_cat_app/presentation/pages/breeds/cat_breed_detail_view.dart';
import 'package:my_super_cat_app/presentation/pages/favorites/favorites_view.dart';
import 'package:my_super_cat_app/presentation/pages/breeds/breeds_view.dart';
import 'package:my_super_cat_app/presentation/shared/custom_navbar.dart';
import 'package:my_super_cat_app/presentation/shared/settings_view.dart';

final routes = {
  CustomNavbar.routeName: (context) => const CustomNavbar(),
  SettingsView.routeName: (context) => const SettingsView(),
  BreedsView.routeName: (context) => const BreedsView(),
  FavoritesView.routeName: (context) => const FavoritesView(),
  CatBreedDetailView.routeName: (context) => CatBreedDetailView(
        breed: ModalRoute.of(context)!.settings.arguments as CatBreed,
      ),
};