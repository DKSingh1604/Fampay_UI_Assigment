import 'package:fampay_assignment/core/storage_service.dart';
import 'package:fampay_assignment/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await StorageService.init();

    await StorageService.clearHiddenCards();
  } catch (e) {
    print('Error initializing storage: $e');
    throw Exception('Failed to initialize storage: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
