import 'package:provider/provider.dart';
import 'package:urban_dict_slang/core/services/api/http_api.dart';
import 'package:urban_dict_slang/core/services/db/database.dart';
import 'package:urban_dict_slang/core/services/repository/term_definitions_repository.dart';
import 'package:urban_dict_slang/core/services/repository/terms_repository.dart';

List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(
    value: AppDatabase(),
  ),
  Provider.value(
    value: HttpApi(),
  ),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider2<AppDatabase, HttpApi, TermDefinitionsRepository>(
    builder: (_, db, api, repository) => TermDefinitionsRepository(db, api),
  ),
  ProxyProvider<AppDatabase, TermsRepository>(
    builder: (_, db, repository) => TermsRepository(db),
  ),
];

List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<Term>(
    builder: (context) =>
        Provider.of<TermDefinitionsRepository>(context, listen: false).term,
  ),
];
