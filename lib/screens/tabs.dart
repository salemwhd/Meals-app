import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _selectedPageIndex = 0;
  var _pageTitle = 'Categories';
  final List<Meal> _favouritMeals = [];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
      _pageTitle = 'Your Favourits';
    });
  }

  void _selectFavourit(Meal meal) {
    final isExistes = _favouritMeals.contains(meal);
    setState(() {
      if (isExistes) {
        _favouritMeals.remove(meal);
      } else {
        _favouritMeals.add(meal);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onTogggleFavourit: _selectFavourit,
    );

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouritMeals,
        onTogggleFavourit: _selectFavourit,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourits',
          ),
        ],
      ),
    );
  }
}
