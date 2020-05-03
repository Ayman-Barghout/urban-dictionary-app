import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:urban_dict_slang/core/blocs/definitions_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/terms_history_bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';

class TermsListWithHeaders extends StatelessWidget {
  final Function changeIndex;
  final Map<int, List<Term>> termsHistory;

  const TermsListWithHeaders(
      {Key key, @required this.changeIndex, @required this.termsHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<int> days = termsHistory.keys.toList();
    final List<List<Term>> termsList = termsHistory.values.toList();
    return ListView.builder(
      itemCount: days.length,
      itemBuilder: (context, index) {
        final List<Widget> termsWidgets = termsList[index]
            .map((term) => TermListTile(
                  changeIndex: changeIndex,
                  instanceTerm: term,
                ))
            .toList();
        return StickyHeader(
          header: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              ),
            ),
            child: Text(
              days[index] > 1
                  ? '${days[index]} days ago'
                  : days[index] == 0 ? 'Today' : 'Yesterday',
              style: const TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
          content: Column(
            children: termsWidgets,
          ),
        );
      },
    );
  }
}

class TermListTile extends StatelessWidget {
  const TermListTile({
    Key key,
    @required this.instanceTerm,
    this.changeIndex,
  }) : super(key: key);

  final Term instanceTerm;
  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        BlocProvider.of<TermBloc>(context)
            .add(ChangeTerm(newTerm: instanceTerm.term));
        BlocProvider.of<DefinitionsBloc>(context)
            .add(FetchDefinitions(instanceTerm.term));
        changeIndex(1);
      },
      title: Text(
        instanceTerm.term[0].toUpperCase() + instanceTerm.term.substring(1),
        style: Theme.of(context).textTheme.body1,
      ),
      trailing: BlocBuilder<TermBloc, TermState>(builder: (context, state) {
        Future _deleteWithoutChanging() async {
          RepositoryProvider.of<TermDefinitionsRepository>(context)
              .deleteTerm(instanceTerm.term);
          BlocProvider.of<TermsHistoryBloc>(context).add(LoadTermsHistory());
        }

        Function _onPressed = () {};
        if (state is TermChanged) {
          if (instanceTerm.term == state.term.term) {
            _onPressed = () async {
              BlocProvider.of<TermBloc>(context).add(DeleteTerm(instanceTerm));
              BlocProvider.of<DefinitionsBloc>(context).add(ResetDefinitions());
              BlocProvider.of<TermsHistoryBloc>(context)
                  .add(LoadTermsHistory());
            };
          } else {
            _onPressed = _deleteWithoutChanging;
          }
        } else {
          _onPressed = _deleteWithoutChanging;
        }
        return IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            _onPressed();
          },
        );
      }),
    );
  }
}
