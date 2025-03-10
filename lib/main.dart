import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/characters_screen.dart';
import 'screens/favorite_screen.dart';
import 'screens/profile_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(WesterosApp());
}

class WesterosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CharactersScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 0),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Color(0xFF1B1B1B),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.movie, "Episodes", 0),
            _buildNavItem(Icons.people, "Characters", 1),
            _buildNavItem(Icons.bookmark, "Favorite", 2),
            _buildNavItem(Icons.person, "Profile", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String text, int index) {
    bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding:
            EdgeInsets.symmetric(horizontal: isSelected ? 16 : 0, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color.fromARGB(255, 193, 131, 37) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            if (isSelected) ...[
              SizedBox(width: 8), // Jarak antara ikon dan teks
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
