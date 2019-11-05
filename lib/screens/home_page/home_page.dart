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
  List<Widget> _buildChildren() => <Widget>[
        TermsView(
          changeIndex: updateIndex,
        ),
        SearchView(),
        FavoritesView(
          changeIndex: updateIndex,
        ),
      ];

  void updateIndex(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = _buildChildren();
    TermsProvider termsProvider = Provider.of<TermsProvider>(context);
    FavoritesProvider favoritesProvider =
        Provider.of<FavoritesProvider>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.white,
        child: Center(
          child: children.elementAt(_selectedIndex),
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
          updateIndex(i);
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
