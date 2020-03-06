import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_dict_slang/core/blocs/definitions_bloc/definitions_bloc.dart';
import 'package:urban_dict_slang/core/blocs/favorited_terms_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/term_bloc/bloc.dart';
import 'package:urban_dict_slang/core/blocs/terms_history_bloc/bloc.dart';
import 'package:urban_dict_slang/core/services/api/http_api.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';
import 'package:urban_dict_slang/core/services/repository/terms_repository.dart';

List<RepositoryProvider> repositoryProviders = [
  RepositoryProvider<HttpApi>(
    create: (context) => HttpApi(),
  ),
  RepositoryProvider<AppDatabase>(
    create: (context) => AppDatabase(),
  ),
  RepositoryProvider<TermDefinitionsRepository>(
    create: (context) => TermDefinitionsRepository(
      RepositoryProvider.of<AppDatabase>(context),
      RepositoryProvider.of<HttpApi>(context),
    ),
  ),
  RepositoryProvider<TermsRepository>(
    create: (context) => TermsRepository(
      RepositoryProvider.of<AppDatabase>(context),
    ),
  )
];

List<BlocProvider> blocProviders = [
  BlocProvider<TermBloc>(
    create: (context) => TermBloc(
      RepositoryProvider.of<TermDefinitionsRepository>(context),
    ),
  ),
  BlocProvider<DefinitionsBloc>(
    create: (context) => DefinitionsBloc(
      RepositoryProvider.of<TermDefinitionsRepository>(context),
    ),
  ),
  BlocProvider<TermsHistoryBloc>(
    create: (context) => TermsHistoryBloc(
      RepositoryProvider.of<TermsRepository>(context),
    ),
  ),
  BlocProvider<FavoritedTermsBloc>(
    create: (context) => FavoritedTermsBloc(
      RepositoryProvider.of<TermsRepository>(context),
    ),
  ),
];
