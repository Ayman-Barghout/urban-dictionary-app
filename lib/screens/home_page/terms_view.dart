import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_dict_slang/providers/terms_provider.dart';
import 'package:urban_dict_slang/screens/home_page/widgets/terms_list.dart';
import 'package:urban_dict_slang/utils/styles.dart' as customStyles;

class TermsView extends StatelessWidget {
  const TermsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TermsProvider termsProvider = Provider.of<TermsProvider>(context);
    return Container(
      color: customStyles.primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                'History',
                style: customStyles.termHeaderTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10.0),
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
                      ? TermsListWithHeaders()
                      : Center(child: Text(termsProvider.terms.message)),
            ),
          )
        ],
      ),
    );
  }
}
