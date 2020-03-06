import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/definitions_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';
import 'package:urban_dict_slang/ui/shared/text_styles.dart' as textStyles;
import 'package:urban_dict_slang/ui/widgets/definition_tile.dart';

class DefinitionsList extends StatelessWidget {
  const DefinitionsList({
    Key key,
  }) : super(key: key);

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
              style: textStyles.definitionStyle,
            ),
          );
        } else if (state is DefinitionsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DefinitionsLoaded) {
          return Scrollbar(
            child: ListView.builder(
              itemCount: state.definitions.length,
              itemBuilder: (BuildContext context, int index) {
                return DefinitionTile(
                  definition: state.definitions[index],
                  goToDefinition: (value) {
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
              style: textStyles.definitionStyle,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
