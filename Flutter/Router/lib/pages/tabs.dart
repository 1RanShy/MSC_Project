import 'package:flutter/material.dart';
import './tabs/home.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter App")),
      body: _pages[_currentIndex],
    );
  }
}
