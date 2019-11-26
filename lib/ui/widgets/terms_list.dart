import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/viewmodels/widgets/terms_list_model.dart';
import 'package:urban_dict_slang/core/viewmodels/widgets/terms_tile_model.dart';

import 'package:urban_dict_slang/ui/shared/app_colors.dart' as customColors;
import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;
import 'package:urban_dict_slang/ui/views/base_widget.dart';

class TermsListWithHeaders extends StatelessWidget {
  final Function changeIndex;

  const TermsListWithHeaders({Key key, this.changeIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TermsListModel>(
        model: TermsListModel(termsRepository: Provider.of(context)),
        onModelReady: (model) => model.getTermsWithDays(),
        builder: (context, model, child) {
          if (model.busy) {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (model.message != null)
            return Center(
              child: Text(model.message),
            );

          List<int> days = model.definitionsWithDates.keys.toList();
          List<List<Term>> termsList =
              model.definitionsWithDates.values.toList();
          return ListView.builder(
            itemCount: days.length,
            itemBuilder: (context, index) {
              List<Widget> termsWidgets = termsList[index]
                  .map((term) => TermListTile(
                        changeIndex: changeIndex,
                        instanceTerm: term,
                        updateList: () => model.getTermsWithDays(),
                      ))
                  .toList();
              return StickyHeader(
                header: Container(
                  width: double.infinity,
                  child: Text(
                    days[index] > 1
                        ? '${days[index]} days ago'
                        : days[index] == 0 ? 'Today' : 'Yesterday',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: customColors.primaryColorLight,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  ),
                ),
                content: Column(
                  children: termsWidgets,
                ),
              );
            },
          );
        });
  }
}

class TermListTile extends StatelessWidget {
  const TermListTile({
    Key key,
    @required this.instanceTerm,
    this.changeIndex,
    this.updateList,
  }) : super(key: key);

  final Term instanceTerm;
  final Function changeIndex;
  final Function updateList;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TermsTileModel>(
      model: TermsTileModel(termRepository: Provider.of(context)),
      builder: (context, model, child) => ListTile(
        onTap: () {
          model.updateTerm(instanceTerm.term);
          changeIndex(1);
        },
        title: Text(
          instanceTerm.term[0].toUpperCase() + instanceTerm.term.substring(1),
          style: textStyles.definitionStyle,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            Term currentTerm = Provider.of<Term>(context);
            model.deleteTerm(
                instanceTerm.term, currentTerm == null ? '' : currentTerm.term);
            updateList();
          },
        ),
      ),
    );
  }
}
