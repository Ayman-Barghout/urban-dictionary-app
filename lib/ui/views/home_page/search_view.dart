import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

import 'package:urban_dict_slang/ui/widgets/definitions_list.dart';
import 'package:urban_dict_slang/ui/widgets/header_appbar.dart';
import 'package:urban_dict_slang/ui/widgets/rounded_search_field.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key key}) : super(key: key);

  Future<void> showAbout(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String versionNumber = packageInfo.version;
    showAboutDialog(
        context: context,
        applicationIcon: Image.asset('assets/icons/icon_sm.png'),
        applicationVersion: '$versionNumber',
        applicationLegalese: 'Pocean Ltd.',
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          Text('Developer: Ayman Barghout'),
          SizedBox(
            height: 5.0,
          ),
          Text('Art designer: Hagar Blue Sea'),
          SizedBox(
            height: 5.0,
          ),
          Text('Reviewers: KhatibFX, Enie Yujo'),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).accentColor,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            expandedHeight: 210,
            bottom: HeaderAppBar(
              child: RoundedSearchField(),
              onInfoButtonPress: () => showAbout(context),
            ),
          ),
        ],
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: DefinitionsList(),
          ),
        ),
      ),
    );
  }
}
