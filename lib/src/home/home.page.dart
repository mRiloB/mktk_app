import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/configuration.page.dart';
import 'package:mktk_app/src/vouchers/history.page.dart';
import 'package:mktk_app/src/vouchers/vouchers.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List _pagesOptions = [
    {"screen": VouchersPage(), "title": "Moby Vouchers v0.0.2"},
    {"screen": VouchersHistoryPage(), "title": "Histórico"},
    {"screen": ConfigurationPage(), "title": "Configurações"},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          _pagesOptions[_selectedIndex]["title"],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.insert_chart_outlined_sharp),
          //   label: 'Relatórios',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
      body: _pagesOptions[_selectedIndex]["screen"],
    );
  }
}
