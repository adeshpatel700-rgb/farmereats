import 'package:farmer_eats/core/storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FarmerEats'),
        actions: [
          TextButton(
            onPressed: () async {
              await SecureStorage.clearToken();
              if (!context.mounted) {
                return;
              }
              context.go('/login');
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: const Center(child: Text('Home — coming soon')),
    );
  }
}
