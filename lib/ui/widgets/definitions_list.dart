import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/definitions_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';
import 'package:urban_dict_slang/ui/widgets/definition_tile.dart';

class DefinitionsList extends StatelessWidget {
  const DefinitionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefinitionsBloc, DefinitionsState>(
      builder: (context, state) {
        if (state is InitialDefinitionsState) {
          return Center(
            child: Text(
              'Search for a slang or name to find its definitions',
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        } else if (state is DefinitionsLoading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.background == Colors.white
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.white.withOpacity(0.8),
              ),
            ),
          );
        } else if (state is DefinitionsLoaded) {
          return Scrollbar(
            child: ListView.separated(
              itemCount: state.definitions.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Theme.of(context).colorScheme.background == Colors.white
                    ? Colors.grey[500]
                    : Theme.of(context).cardColor,
              ),
              itemBuilder: (BuildContext context, int index) {
                return DefinitionTile(
                  definition: state.definitions[index],
                  goToDefinition: (String value) {
                    BlocProvider.of<TermBloc>(context).add(
                      ChangeTerm(newTerm: value),
                    );
                    BlocProvider.of<DefinitionsBloc>(context)
                        .add(FetchDefinitions(value));
                  },
                );
              },
            ),
          );
        } else if (state is DefinitionsError) {
          return Center(
            child: Text(
              state.message,
              textAlign: TextAlign.center,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
