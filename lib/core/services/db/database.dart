import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Definitions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get term => text()();
  TextColumn get definition => text()();
  TextColumn get example => text()();
  TextColumn get author => text()();
  IntColumn get thumbs_up => integer()();
  IntColumn get thumbs_down => integer()();
}

class Terms extends Table {
  TextColumn get term => text()();
  DateTimeColumn get lastViewed => dateTime()();
  BoolColumn get isFavorite => boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {term};
}

@UseMoor(tables: [Terms, Definitions], daos: [TermDao, DefinitionsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'urban_dict_db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAllTables();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {}
      });
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

  Future<int> toggleFavorite(Term passedTerm) =>
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

  Future<Term> insertNewTerm(String newTerm) async {
    final term =
        Term(term: newTerm, isFavorite: false, lastViewed: DateTime.now());
    await into(terms).insert(term);
    return term;
  }

  Future<Term> getTerm(String term) =>
      (select(terms)..where((t) => t.term.equals(term))).getSingle();

  Future deleteTerm(String term) =>
      (delete(terms)..where((t) => t.term.equals(term))).go();
}

@UseDao(tables: [Definitions])
class DefinitionsDao extends DatabaseAccessor<AppDatabase>
    with _$DefinitionsDaoMixin {
  final AppDatabase db;

  DefinitionsDao(this.db) : super(db);

  Future<List<Definition>> getDefinitions(String passedTerm) =>
      (select(definitions)
            ..where((d) => d.term.equals(passedTerm.toLowerCase().trim())))
          .get();

  Future deleteDefinitions(String term) async {
    await (delete(definitions)..where((d) => d.term.equals(term))).go();
  }

  Future insertDefinitions(String term, List<Definition> newDefinitions) =>
      into(definitions).insertAll(newDefinitions
          .map((d) => Definition(
                id: d.id,
                term: term,
                example: d.example,
                thumbs_down: d.thumbs_down,
                thumbs_up: d.thumbs_up,
                definition: d.definition,
                author: d.author,
              ))
          .toList());
}
