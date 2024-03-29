import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/favorited_terms_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/terms_history_bloc/bloc.dart';

import 'package:urban_dict_slang/ui/views/home_page/favorites_view.dart';
import 'package:urban_dict_slang/ui/views/home_page/search_view.dart';
import 'package:urban_dict_slang/ui/views/home_page/terms_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController(initialPage: 1);
  late int _selectedIndex;

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
    await controller.animateToPage(
      i,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    setState(() {
      _selectedIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ColoredBox(
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
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Bookmarks',
          ),
        ],
        currentIndex: _selectedIndex,
        backgroundColor: Theme.of(context).cardColor,
        unselectedItemColor:
            Theme.of(context).colorScheme.background == Colors.white
                ? Colors.grey.shade600
                : Colors.white.withOpacity(0.5),
        selectedItemColor:
            Theme.of(context).colorScheme.background == Colors.white
                ? Theme.of(context).primaryColor
                : Colors.white,
        onTap: (i) {
          updateIndex(i);
        },
      ),
    );
  }
}
