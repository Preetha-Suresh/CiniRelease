import 'package:flutter/material.dart';
import 'services/movie_service.dart';
import 'screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
  await Hive.openBox('watchlist');
  runApp(const CiniReleaseApp());
}

class CiniReleaseApp extends StatelessWidget {
  const CiniReleaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CiniRelease',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}