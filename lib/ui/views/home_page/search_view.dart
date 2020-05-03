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
          const SizedBox(
            height: 5.0,
          ),
          const Text('Developer: Ayman Barghout'),
          const SizedBox(
            height: 5.0,
          ),
          const Text('Art designer: Hagar Blue Sea'),
          const SizedBox(
            height: 5.0,
          ),
          const Text('Reviewers: KhatibFX, Enie Yujo'),
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
              onInfoButtonPress: () => showAbout(context),
              child: const RoundedSearchField(),
            ),
          ),
        ],
        body: Container(
          color: Theme.of(context).primaryColor,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: const DefinitionsList(),
          ),
        ),
      ),
    );
  }
}
