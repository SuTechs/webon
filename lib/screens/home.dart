import 'package:flutter/material.dart';
import 'package:webon/widgets/web_view_screen.dart';

class TechntoysHomeScreen extends StatefulWidget {
  const TechntoysHomeScreen({super.key});

  @override
  State<TechntoysHomeScreen> createState() => _TechntoysHomeScreenState();
}

class _TechntoysHomeScreenState extends State<TechntoysHomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          // home
          WebViewScreen(url: "https://techntoys.com/"),

          // categories
          WebViewScreen(
              url: "https://techntoys.com/en/techn-toys-category-listing.html"),

          // cart
          WebViewScreen(url: "https://techntoys.com/en/checkout/cart/"),

          // profile
          WebViewScreen(
              url: "https://techntoys.com/en/customer/account/create/"),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_filled),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.category_outlined),
            selectedIcon: Icon(Icons.category),
            label: "Categories",
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
