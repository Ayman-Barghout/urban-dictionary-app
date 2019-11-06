import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/terms_provider.dart';
import 'package:urban_dict_slang/screens/home_page/widgets/terms_list.dart';
import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class TermsView extends StatelessWidget {
  const TermsView({Key key, this.changeIndex}) : super(key: key);

  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    TermsProvider termsProvider = Provider.of<TermsProvider>(context);
    return Container(
      color: customStyles.primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  'History',
                  style: customStyles.termHeaderTextStyle,
                ),
              ),
            ),
          ),
          Expanded(
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
              child: termsProvider.terms == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : termsProvider.terms.message == null
                      ? TermsListWithHeaders(changeIndex: changeIndex)
                      : Center(child: Text(termsProvider.terms.message)),
            ),
          )
        ],
      ),
    );
  }
}
