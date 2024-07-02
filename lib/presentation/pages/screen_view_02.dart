import 'package:flutter/material.dart';

class ScreenView02 extends StatelessWidget {
  static const routeName = '/screen_view_02';
  
  const ScreenView02({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen View 02'),
      ),
      body: const Center(
        child: Text('Screen View 02'),
        ),
      );
  }
}