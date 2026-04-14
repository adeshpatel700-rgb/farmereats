import 'package:farmer_eats/app.dart';
import 'package:farmer_eats/injection.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(FarmerEatsApp());
}
