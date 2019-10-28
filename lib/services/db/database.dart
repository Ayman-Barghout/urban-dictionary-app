import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Definitions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get term => text()();
  TextColumn get definition => text()();
  TextColumn get example => text()();
  TextColumn get author => text()();
  IntColumn get thumbsUp => integer()();
  IntColumn get thumbsDown => integer()();
}

class Terms extends Table {
  TextColumn get term => text()();
  DateTimeColumn get lastViewed => dateTime()();
  BoolColumn get isFavorite => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {term};
}

class TermWithDefinitions {
  final Term term;
  final List<Definition> definitions;

  TermWithDefinitions(this.term, this.definitions);
}

@UseMoor(tables: [Terms, Definitions])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'termDB.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Terms])
class TermDao extends DatabaseAccessor<AppDatabase> with _$TermDaoMixin {
  final AppDatabase db;

  TermDao(this.db) : super(db);

  Future<List<Term>> getAllTerms() => (select(terms)
        ..orderBy([
          (t) => OrderingTerm(expression: t.lastViewed, mode: OrderingMode.desc)
        ]))
      .get();

  Future toggleFavorite(Term passedTerm) =>
      (update(terms)..where((t) => t.term.equals(passedTerm.term)))
          .write(TermsCompanion(isFavorite: Value(!passedTerm.isFavorite)));

  Future updateLastViewed(Term passedTerm) =>
      (update(terms)..where((t) => t.term.equals(passedTerm.term)))
          .write(TermsCompanion(lastViewed: Value(DateTime.now())));
  Future<List<Term>> getAllFavorites() => (select(terms)
        ..where((t) => t.isFavorite)
        ..orderBy(
            [(t) => OrderingTerm(expression: t.term, mode: OrderingMode.asc)]))
      .get();

  Future<TermWithDefinitions> createNewTerm(String newTerm) async {
    final term =
        Term(term: newTerm, isFavorite: false, lastViewed: DateTime.now());
    await into(terms).insert(term);
    return TermWithDefinitions(term, []);
  }

  Future<Term> getTerm(String term) =>
      (select(terms)..where((t) => t.term.equals(term))).getSingle();
}

@UseDao(tables: [Definitions])
class DefinitionsDao extends DatabaseAccessor<AppDatabase>
    with _$DefinitionsDaoMixin {
  final AppDatabase db;

  DefinitionsDao(this.db) : super(db);

  Future updateDefinitions(String term, List<Definition> newDefinitions) async {
    await (delete(definitions)..where((d) => d.term.equals(term))).go();
    return into(definitions).insertAll(newDefinitions);
  }

  Future insertDefinitions(List<Definition> newDefinitions) =>
      into(definitions).insertAll(newDefinitions);
}
