import 'package:flutter/material.dart';
import '../core/state/app_controller.dart';
import '../features/home/home_page.dart';
import 'theme/app_theme.dart';

class OwOCloakApp extends StatefulWidget {
  const OwOCloakApp({super.key});

  @override
  State<OwOCloakApp> createState() => _OwOCloakAppState();
}

class _OwOCloakAppState extends State<OwOCloakApp> {
  late final AppController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AppController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppControllerScope(
      controller: _controller,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OwOCloak',
        theme: AppTheme.dark(),
        home: const HomePage(),
      ),
    );
  }
}

class AppControllerScope extends InheritedNotifier<AppController> {
  const AppControllerScope({
    required AppController controller,
    required super.child,
    super.key,
  }) : super(notifier: controller);

  static AppController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<AppControllerScope>();
    assert(scope != null, 'AppControllerScope is missing above this widget.');
    return scope!.notifier!;
  }
}
