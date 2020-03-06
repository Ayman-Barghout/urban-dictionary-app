import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/favorited_terms_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/terms_history_bloc/bloc.dart';

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
  final controller = PageController(initialPage: 1);
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void updateIndex(int i) {
    if (i == 0) {
      BlocProvider.of<TermsHistoryBloc>(context).add(LoadTermsHistory());
    } else if (i == 2) {
      BlocProvider.of<FavoritedTermsBloc>(context).add(LoadFavoritedTerms());
    }
    controller.animateToPage(i,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Colors.white,
        child: PageView(
          onPageChanged: (index) => updateIndex(index),
          controller: controller,
          children: <Widget>[
            TermsView(
              changeIndex: updateIndex,
            ),
            SearchView(),
            FavoritesView(
              changeIndex: updateIndex,
            ),
          ],
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
