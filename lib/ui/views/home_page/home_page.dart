import 'package:flutter/material.dart';

import 'package:urban_dict_slang/ui/shared/app_colors.dart' as customColors;
import 'package:urban_dict_slang/ui/views/home_page/search_view.dart';
import 'package:urban_dict_slang/ui/views/home_page/terms_view.dart';
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
        selectedItemColor: customColors.primaryColor,
        onTap: (i) {
          updateIndex(i);
        },
      ),
    );
  }
}
