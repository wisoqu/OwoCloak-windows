import 'package:flutter/material.dart';
import '../features/home/home_page.dart';
import 'theme/app_theme.dart';

class OwOCloakApp extends StatelessWidget {
  const OwOCloakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OwOCloak',
      theme: AppTheme.dark(),
      home: const HomePage(),
    );
  }
}
