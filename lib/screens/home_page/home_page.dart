import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/favorites_provider.dart';
import 'package:urban_dict_slang/providers/terms_provider.dart';
import 'package:urban_dict_slang/screens/home_page/search_view.dart';
import 'package:urban_dict_slang/screens/home_page/terms_view.dart';

import 'package:urban_dict_slang/utils/styles.dart' as customStyles;
import 'favorites_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    TermsView(),
    SearchView(),
    FavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    TermsProvider termsProvider = Provider.of<TermsProvider>(context);
    FavoritesProvider favoritesProvider =
        Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text('History'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Bookmarks'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: customStyles.primaryColor,
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
          if (i == 0) {
            termsProvider.getTerms();
          } else if (i == 2) {
            favoritesProvider.getFavorites();
          }
        },
      ),
    );
  }
}
