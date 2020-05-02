import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/terms_history_bloc/bloc.dart';

import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;
import 'package:urban_dict_slang/ui/widgets/terms_list_headers.dart';

class TermsView extends StatelessWidget {
  const TermsView({Key key, this.changeIndex}) : super(key: key);

  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
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
                child: BlocBuilder<TermsHistoryBloc, TermsHistoryState>(
                  builder: (context, state) {
                    if (state is TermsHistoryLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TermsHistoryEmpty) {
                      return Center(
                        child: Text(
                          state.message,
                          style: textStyles.definitionStyle,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      );
                    } else if (state is TermsHistoryLoaded) {
                      return TermsListWithHeaders(
                        changeIndex: changeIndex,
                        termsHistory: state.termsHistory,
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
