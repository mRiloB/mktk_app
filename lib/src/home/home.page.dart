import 'package:flutter/material.dart';
import 'package:mktk_app/src/configuration/configuration.page.dart';
import 'package:mktk_app/src/vouchers/vouchers.page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class PageAux {
  Widget screen;
  String title;
  PageAux(this.screen, this.title);
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static final List<PageAux> _pagesOptions = [
    PageAux(const VouchersPage(), "Moby Vouchers v0.0.4"),
    PageAux(const ConfigurationPage(), "Configurações")
  ];

  BottomNavigationBarItem _createBNBtn(Icon icon, String label) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }

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
          _pagesOptions[_selectedIndex].title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          _createBNBtn(
            const Icon(Icons.home),
            'Home',
          ),
          _createBNBtn(
            const Icon(Icons.settings),
            'Configurações',
          ),
        ],
      ),
      body: _pagesOptions[_selectedIndex].screen,
    );
  }
}
