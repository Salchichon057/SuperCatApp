import 'package:flutter/material.dart';
import 'package:my_super_cat_app/infraestructure/services/cat_image_service.dart';
import 'package:my_super_cat_app/presentation/providers/app_notifier.dart';
import 'package:my_super_cat_app/presentation/providers/theme_notifier.dart';
import 'package:my_super_cat_app/presentation/shared/custom_navbar.dart';
import 'package:my_super_cat_app/utils/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppNotifier()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const _BannerView(),
      theme: themeNotifier.appTheme.getTheme(),
      routes: routes,
    );
  }
}

class _BannerView extends StatefulWidget {
  const _BannerView();

  @override
  State<_BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<_BannerView> {
  String imageUrl = '';
  final CatImageService _catImageService = CatImageService();

  @override
  void initState() {
    super.initState();
    _fetchCatImage();
  }

  Future<void> _fetchCatImage() async {
    try {
      final url = await _catImageService.fetchCatImage();
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      // Handle the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Super Cat App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            imageUrl.isNotEmpty
                ? Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
            const SizedBox(height: 20),
            // Botón de acción
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(CustomNavbar.routeName);
                },
                child: const Text('Go to the app'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
