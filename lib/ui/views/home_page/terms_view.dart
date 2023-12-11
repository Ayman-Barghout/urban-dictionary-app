import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/terms_history_bloc/bloc.dart';

import 'package:urban_dict_slang/ui/widgets/terms_list_headers.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key, required this.changeIndex});

  final ValueChanged<int> changeIndex;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: Text(
                  'History',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              margin: const EdgeInsets.only(top: 5.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: BlocBuilder<TermsHistoryBloc, TermsHistoryState>(
                builder: (context, state) {
                  if (state is TermsHistoryLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.background ==
                                  Colors.white
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    );
                  } else if (state is TermsHistoryEmpty) {
                    return Center(
                      child: Text(
                        state.message,
                        style: Theme.of(context).textTheme.bodyMedium,
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
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.background ==
                                  Colors.white
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white.withOpacity(0.8),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
