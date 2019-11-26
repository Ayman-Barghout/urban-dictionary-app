import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/viewmodels/views/search_view_model.dart';

import 'package:urban_dict_slang/ui/shared/app_colors.dart' as customColors;
import 'package:urban_dict_slang/ui/views/base_widget.dart';
import 'package:urban_dict_slang/ui/widgets/definitions_list.dart';
import 'package:urban_dict_slang/ui/widgets/header_appbar.dart';
import 'package:urban_dict_slang/ui/widgets/rounded_search_field.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key key}) : super(key: key);

  void showAbout(BuildContext context) => showAboutDialog(
          context: context,
          applicationIcon: Image.asset('assets/icons/icon_sm.png'),
          applicationVersion: '1.0.5 (6)',
          applicationLegalese: 'Pocean Ltd.',
          children: <Widget>[
            SizedBox(
              height: 5.0,
            ),
            Text('Programmer: Ayman Barghout'),
            SizedBox(
              height: 5.0,
            ),
            Text('Art designer: Hagar Blue Sea'),
            SizedBox(
              height: 5.0,
            ),
            Text('Reviewers: KhatibFX, Enie Yujo'),
          ]);

  @override
  Widget build(BuildContext context) {
    Term term = Provider.of<Term>(context);
    return BaseWidget<SearchViewModel>(
      model: SearchViewModel(termDefinitionsRepository: Provider.of(context)),
      onModelReady: (model) {
        if (term == null) {
          model.fetchDefinitions('');
        } else {
          model.fetchDefinitions(term.term);
        }
      },
      builder: (context, model, child) => Container(
        color: customColors.primaryColorLight,
        padding: EdgeInsets.only(top: 25.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: HeaderAppBar(
                term: term == null ? 'Urban Dictionary' : term.term,
                child: RoundedSearchField(
                  onSearch: model.updateTermAndDefinitions,
                ),
                onInfoButtonPress: () => showAbout(context),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                color: customColors.primaryColor,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: DefinitionsList(
                    definitions: model.definitions,
                    isBusy: model.busy,
                    message: model.message,
                    onTextTap: model.updateTermAndDefinitions,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
