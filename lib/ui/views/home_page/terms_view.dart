import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/core/viewmodels/views/terms_view_model.dart';

import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;
import 'package:urban_dict_slang/ui/shared/app_colors.dart' as customColors;
import 'package:urban_dict_slang/ui/views/base_widget.dart';
import 'package:urban_dict_slang/ui/widgets/terms_list.dart';

class TermsView extends StatelessWidget {
  const TermsView({Key key, this.changeIndex}) : super(key: key);

  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: customColors.primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  'History',
                  style: textStyles.termHeaderStyle,
                ),
              ),
            ),
          ),
          BaseWidget<TermsViewModel>(
            model: TermsViewModel(termsRepository: Provider.of(context)),
            onModelReady: (model) => model.fetchTerms(),
            builder: (context, model, child) => Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                margin: EdgeInsets.only(top: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: model.busy
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : model.message == null
                        ? TermsListWithHeaders(changeIndex: changeIndex)
                        : Center(child: Text(model.message)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
