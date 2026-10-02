import 'package:flutter/material.dart';
import '../widgets/home_menu_bar.dart';
import '../widgets/home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeMenuBar(),
            Expanded(
              child: HomeContent(), // основная область после, заглушка
            ),
          ],
        ),
      ),
    );
  }
}
