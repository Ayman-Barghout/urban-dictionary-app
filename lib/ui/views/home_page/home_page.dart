import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/favorited_terms_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/terms_history_bloc/bloc.dart';

import 'package:urban_dict_slang/ui/views/home_page/search_view.dart';
import 'package:urban_dict_slang/ui/views/home_page/terms_view.dart';
import 'favorites_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController(initialPage: 1);
  int _selectedIndex;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    _selectedIndex = 1;
  }

  Future<void> updateIndex(int i) async {
    if (i == 0) {
      BlocProvider.of<TermsHistoryBloc>(context).add(LoadTermsHistory());
    } else if (i == 2) {
      BlocProvider.of<FavoritedTermsBloc>(context).add(LoadFavoritedTerms());
    }
    await controller.animateToPage(i,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
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
          onPageChanged: (index) => setState(() {
            _selectedIndex = index;
          }),
          controller: controller,
          children: <Widget>[
            TermsView(
              changeIndex: updateIndex,
            ),
            const SearchView(),
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
        backgroundColor: Theme.of(context).cardColor,
        unselectedItemColor: Theme.of(context).backgroundColor == Colors.white
            ? Colors.grey.shade600
            : Colors.white.withOpacity(0.5),
        selectedItemColor: Theme.of(context).backgroundColor == Colors.white
            ? Theme.of(context).primaryColor
            : Colors.white,
        onTap: (i) {
          updateIndex(i);
        },
      ),
    );
  }
}
