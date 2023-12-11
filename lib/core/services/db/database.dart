import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';

part 'database.g.dart';

class Definitions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get term => text()();
  TextColumn get definition => text()();
  TextColumn get example => text()();
  TextColumn get author => text()();
  @JsonKey('thumbs_up')
  IntColumn get thumbsUp => integer().named('thumbs_up')();
  @JsonKey('thumbs_down')
  IntColumn get thumbsDown => integer().named('thumbs_down')();
}

class Terms extends Table {
  TextColumn get term => text()();
  DateTimeColumn get lastViewed => dateTime()();
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {term};
}

@DriftDatabase(tables: [Terms, Definitions], daos: [TermDao, DefinitionsDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(SqfliteQueryExecutor.inDatabaseFolder(
          path: 'urban_dict_db.sqlite',
          logStatements: true,
        ));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {}
      });
}

@DriftAccessor(tables: [Terms])
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
        ..orderBy([(t) => OrderingTerm(expression: t.term)]))
      .get();

  Future<Term> insertNewTerm(String newTerm) async {
    final term =
        Term(term: newTerm, isFavorite: false, lastViewed: DateTime.now());
    await into(terms).insert(term);
    return term;
  }

  Future<Term?> getTerm(String term) async {
    final query = select(terms)..where((t) => t.term.equals(term));
    try {
      final term = await query.getSingle();
      return term;
    } catch (e) {
      log('Error getting term, $e');
      return null;
    }
  }

  Future deleteTerm(String term) =>
      (delete(terms)..where((t) => t.term.equals(term))).go();
}

@DriftAccessor(tables: [Definitions])
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

  Future insertDefinitions(String term, List<Definition> newDefinitions) async {
    final definitionsToInsert = newDefinitions
        .map(
          (d) => Definition(
            id: d.id,
            term: term,
            example: d.example,
            thumbsDown: d.thumbsDown,
            thumbsUp: d.thumbsUp,
            definition: d.definition,
            author: d.author,
          ),
        )
        .toList();
    await batch((batch) {
      try {
        batch.insertAll(
          definitions,
          definitionsToInsert,
          mode: InsertMode.insertOrReplace,
        );
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
