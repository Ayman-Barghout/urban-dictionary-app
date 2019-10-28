// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Term extends DataClass implements Insertable<Term> {
  final String term;
  final DateTime lastViewed;
  final bool isFavorite;
  Term(
      {@required this.term,
      @required this.lastViewed,
      @required this.isFavorite});
  factory Term.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Term(
      term: stringType.mapFromDatabaseResponse(data['${effectivePrefix}term']),
      lastViewed: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}last_viewed']),
      isFavorite: boolType
          .mapFromDatabaseResponse(data['${effectivePrefix}is_favorite']),
    );
  }
  factory Term.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Term(
      term: serializer.fromJson<String>(json['term']),
      lastViewed: serializer.fromJson<DateTime>(json['lastViewed']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'term': serializer.toJson<String>(term),
      'lastViewed': serializer.toJson<DateTime>(lastViewed),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  @override
  TermsCompanion createCompanion(bool nullToAbsent) {
    return TermsCompanion(
      term: term == null && nullToAbsent ? const Value.absent() : Value(term),
      lastViewed: lastViewed == null && nullToAbsent
          ? const Value.absent()
          : Value(lastViewed),
      isFavorite: isFavorite == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavorite),
    );
  }

  Term copyWith({String term, DateTime lastViewed, bool isFavorite}) => Term(
        term: term ?? this.term,
        lastViewed: lastViewed ?? this.lastViewed,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('Term(')
          ..write('term: $term, ')
          ..write('lastViewed: $lastViewed, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf(
      $mrjc(term.hashCode, $mrjc(lastViewed.hashCode, isFavorite.hashCode)));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Term &&
          other.term == this.term &&
          other.lastViewed == this.lastViewed &&
          other.isFavorite == this.isFavorite);
}

class TermsCompanion extends UpdateCompanion<Term> {
  final Value<String> term;
  final Value<DateTime> lastViewed;
  final Value<bool> isFavorite;
  const TermsCompanion({
    this.term = const Value.absent(),
    this.lastViewed = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  TermsCompanion.insert({
    @required String term,
    @required DateTime lastViewed,
    this.isFavorite = const Value.absent(),
  })  : term = Value(term),
        lastViewed = Value(lastViewed);
  TermsCompanion copyWith(
      {Value<String> term,
      Value<DateTime> lastViewed,
      Value<bool> isFavorite}) {
    return TermsCompanion(
      term: term ?? this.term,
      lastViewed: lastViewed ?? this.lastViewed,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class $TermsTable extends Terms with TableInfo<$TermsTable, Term> {
  final GeneratedDatabase _db;
  final String _alias;
  $TermsTable(this._db, [this._alias]);
  final VerificationMeta _termMeta = const VerificationMeta('term');
  GeneratedTextColumn _term;
  @override
  GeneratedTextColumn get term => _term ??= _constructTerm();
  GeneratedTextColumn _constructTerm() {
    return GeneratedTextColumn(
      'term',
      $tableName,
      false,
    );
  }

  final VerificationMeta _lastViewedMeta = const VerificationMeta('lastViewed');
  GeneratedDateTimeColumn _lastViewed;
  @override
  GeneratedDateTimeColumn get lastViewed =>
      _lastViewed ??= _constructLastViewed();
  GeneratedDateTimeColumn _constructLastViewed() {
    return GeneratedDateTimeColumn(
      'last_viewed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  GeneratedBoolColumn _isFavorite;
  @override
  GeneratedBoolColumn get isFavorite => _isFavorite ??= _constructIsFavorite();
  GeneratedBoolColumn _constructIsFavorite() {
    return GeneratedBoolColumn('is_favorite', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [term, lastViewed, isFavorite];
  @override
  $TermsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'terms';
  @override
  final String actualTableName = 'terms';
  @override
  VerificationContext validateIntegrity(TermsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.term.present) {
      context.handle(
          _termMeta, term.isAcceptableValue(d.term.value, _termMeta));
    } else if (term.isRequired && isInserting) {
      context.missing(_termMeta);
    }
    if (d.lastViewed.present) {
      context.handle(_lastViewedMeta,
          lastViewed.isAcceptableValue(d.lastViewed.value, _lastViewedMeta));
    } else if (lastViewed.isRequired && isInserting) {
      context.missing(_lastViewedMeta);
    }
    if (d.isFavorite.present) {
      context.handle(_isFavoriteMeta,
          isFavorite.isAcceptableValue(d.isFavorite.value, _isFavoriteMeta));
    } else if (isFavorite.isRequired && isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {term};
  @override
  Term map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Term.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TermsCompanion d) {
    final map = <String, Variable>{};
    if (d.term.present) {
      map['term'] = Variable<String, StringType>(d.term.value);
    }
    if (d.lastViewed.present) {
      map['last_viewed'] = Variable<DateTime, DateTimeType>(d.lastViewed.value);
    }
    if (d.isFavorite.present) {
      map['is_favorite'] = Variable<bool, BoolType>(d.isFavorite.value);
    }
    return map;
  }

  @override
  $TermsTable createAlias(String alias) {
    return $TermsTable(_db, alias);
  }
}

class Definition extends DataClass implements Insertable<Definition> {
  final int id;
  final String term;
  final String definition;
  final String example;
  final String author;
  final int thumbsUp;
  final int thumbsDown;
  Definition(
      {@required this.id,
      @required this.term,
      @required this.definition,
      @required this.example,
      @required this.author,
      @required this.thumbsUp,
      @required this.thumbsDown});
  factory Definition.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Definition(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      term: stringType.mapFromDatabaseResponse(data['${effectivePrefix}term']),
      definition: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}definition']),
      example:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}example']),
      author:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}author']),
      thumbsUp:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}thumbs_up']),
      thumbsDown: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}thumbs_down']),
    );
  }
  factory Definition.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Definition(
      id: serializer.fromJson<int>(json['id']),
      term: serializer.fromJson<String>(json['term']),
      definition: serializer.fromJson<String>(json['definition']),
      example: serializer.fromJson<String>(json['example']),
      author: serializer.fromJson<String>(json['author']),
      thumbsUp: serializer.fromJson<int>(json['thumbsUp']),
      thumbsDown: serializer.fromJson<int>(json['thumbsDown']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'term': serializer.toJson<String>(term),
      'definition': serializer.toJson<String>(definition),
      'example': serializer.toJson<String>(example),
      'author': serializer.toJson<String>(author),
      'thumbsUp': serializer.toJson<int>(thumbsUp),
      'thumbsDown': serializer.toJson<int>(thumbsDown),
    };
  }

  @override
  DefinitionsCompanion createCompanion(bool nullToAbsent) {
    return DefinitionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      term: term == null && nullToAbsent ? const Value.absent() : Value(term),
      definition: definition == null && nullToAbsent
          ? const Value.absent()
          : Value(definition),
      example: example == null && nullToAbsent
          ? const Value.absent()
          : Value(example),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      thumbsUp: thumbsUp == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbsUp),
      thumbsDown: thumbsDown == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbsDown),
    );
  }

  Definition copyWith(
          {int id,
          String term,
          String definition,
          String example,
          String author,
          int thumbsUp,
          int thumbsDown}) =>
      Definition(
        id: id ?? this.id,
        term: term ?? this.term,
        definition: definition ?? this.definition,
        example: example ?? this.example,
        author: author ?? this.author,
        thumbsUp: thumbsUp ?? this.thumbsUp,
        thumbsDown: thumbsDown ?? this.thumbsDown,
      );
  @override
  String toString() {
    return (StringBuffer('Definition(')
          ..write('id: $id, ')
          ..write('term: $term, ')
          ..write('definition: $definition, ')
          ..write('example: $example, ')
          ..write('author: $author, ')
          ..write('thumbsUp: $thumbsUp, ')
          ..write('thumbsDown: $thumbsDown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          term.hashCode,
          $mrjc(
              definition.hashCode,
              $mrjc(
                  example.hashCode,
                  $mrjc(author.hashCode,
                      $mrjc(thumbsUp.hashCode, thumbsDown.hashCode)))))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Definition &&
          other.id == this.id &&
          other.term == this.term &&
          other.definition == this.definition &&
          other.example == this.example &&
          other.author == this.author &&
          other.thumbsUp == this.thumbsUp &&
          other.thumbsDown == this.thumbsDown);
}

class DefinitionsCompanion extends UpdateCompanion<Definition> {
  final Value<int> id;
  final Value<String> term;
  final Value<String> definition;
  final Value<String> example;
  final Value<String> author;
  final Value<int> thumbsUp;
  final Value<int> thumbsDown;
  const DefinitionsCompanion({
    this.id = const Value.absent(),
    this.term = const Value.absent(),
    this.definition = const Value.absent(),
    this.example = const Value.absent(),
    this.author = const Value.absent(),
    this.thumbsUp = const Value.absent(),
    this.thumbsDown = const Value.absent(),
  });
  DefinitionsCompanion.insert({
    this.id = const Value.absent(),
    @required String term,
    @required String definition,
    @required String example,
    @required String author,
    @required int thumbsUp,
    @required int thumbsDown,
  })  : term = Value(term),
        definition = Value(definition),
        example = Value(example),
        author = Value(author),
        thumbsUp = Value(thumbsUp),
        thumbsDown = Value(thumbsDown);
  DefinitionsCompanion copyWith(
      {Value<int> id,
      Value<String> term,
      Value<String> definition,
      Value<String> example,
      Value<String> author,
      Value<int> thumbsUp,
      Value<int> thumbsDown}) {
    return DefinitionsCompanion(
      id: id ?? this.id,
      term: term ?? this.term,
      definition: definition ?? this.definition,
      example: example ?? this.example,
      author: author ?? this.author,
      thumbsUp: thumbsUp ?? this.thumbsUp,
      thumbsDown: thumbsDown ?? this.thumbsDown,
    );
  }
}

class $DefinitionsTable extends Definitions
    with TableInfo<$DefinitionsTable, Definition> {
  final GeneratedDatabase _db;
  final String _alias;
  $DefinitionsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _termMeta = const VerificationMeta('term');
  GeneratedTextColumn _term;
  @override
  GeneratedTextColumn get term => _term ??= _constructTerm();
  GeneratedTextColumn _constructTerm() {
    return GeneratedTextColumn(
      'term',
      $tableName,
      false,
    );
  }

  final VerificationMeta _definitionMeta = const VerificationMeta('definition');
  GeneratedTextColumn _definition;
  @override
  GeneratedTextColumn get definition => _definition ??= _constructDefinition();
  GeneratedTextColumn _constructDefinition() {
    return GeneratedTextColumn(
      'definition',
      $tableName,
      false,
    );
  }

  final VerificationMeta _exampleMeta = const VerificationMeta('example');
  GeneratedTextColumn _example;
  @override
  GeneratedTextColumn get example => _example ??= _constructExample();
  GeneratedTextColumn _constructExample() {
    return GeneratedTextColumn(
      'example',
      $tableName,
      false,
    );
  }

  final VerificationMeta _authorMeta = const VerificationMeta('author');
  GeneratedTextColumn _author;
  @override
  GeneratedTextColumn get author => _author ??= _constructAuthor();
  GeneratedTextColumn _constructAuthor() {
    return GeneratedTextColumn(
      'author',
      $tableName,
      false,
    );
  }

  final VerificationMeta _thumbsUpMeta = const VerificationMeta('thumbsUp');
  GeneratedIntColumn _thumbsUp;
  @override
  GeneratedIntColumn get thumbsUp => _thumbsUp ??= _constructThumbsUp();
  GeneratedIntColumn _constructThumbsUp() {
    return GeneratedIntColumn(
      'thumbs_up',
      $tableName,
      false,
    );
  }

  final VerificationMeta _thumbsDownMeta = const VerificationMeta('thumbsDown');
  GeneratedIntColumn _thumbsDown;
  @override
  GeneratedIntColumn get thumbsDown => _thumbsDown ??= _constructThumbsDown();
  GeneratedIntColumn _constructThumbsDown() {
    return GeneratedIntColumn(
      'thumbs_down',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, term, definition, example, author, thumbsUp, thumbsDown];
  @override
  $DefinitionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'definitions';
  @override
  final String actualTableName = 'definitions';
  @override
  VerificationContext validateIntegrity(DefinitionsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.term.present) {
      context.handle(
          _termMeta, term.isAcceptableValue(d.term.value, _termMeta));
    } else if (term.isRequired && isInserting) {
      context.missing(_termMeta);
    }
    if (d.definition.present) {
      context.handle(_definitionMeta,
          definition.isAcceptableValue(d.definition.value, _definitionMeta));
    } else if (definition.isRequired && isInserting) {
      context.missing(_definitionMeta);
    }
    if (d.example.present) {
      context.handle(_exampleMeta,
          example.isAcceptableValue(d.example.value, _exampleMeta));
    } else if (example.isRequired && isInserting) {
      context.missing(_exampleMeta);
    }
    if (d.author.present) {
      context.handle(
          _authorMeta, author.isAcceptableValue(d.author.value, _authorMeta));
    } else if (author.isRequired && isInserting) {
      context.missing(_authorMeta);
    }
    if (d.thumbsUp.present) {
      context.handle(_thumbsUpMeta,
          thumbsUp.isAcceptableValue(d.thumbsUp.value, _thumbsUpMeta));
    } else if (thumbsUp.isRequired && isInserting) {
      context.missing(_thumbsUpMeta);
    }
    if (d.thumbsDown.present) {
      context.handle(_thumbsDownMeta,
          thumbsDown.isAcceptableValue(d.thumbsDown.value, _thumbsDownMeta));
    } else if (thumbsDown.isRequired && isInserting) {
      context.missing(_thumbsDownMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Definition map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Definition.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DefinitionsCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.term.present) {
      map['term'] = Variable<String, StringType>(d.term.value);
    }
    if (d.definition.present) {
      map['definition'] = Variable<String, StringType>(d.definition.value);
    }
    if (d.example.present) {
      map['example'] = Variable<String, StringType>(d.example.value);
    }
    if (d.author.present) {
      map['author'] = Variable<String, StringType>(d.author.value);
    }
    if (d.thumbsUp.present) {
      map['thumbs_up'] = Variable<int, IntType>(d.thumbsUp.value);
    }
    if (d.thumbsDown.present) {
      map['thumbs_down'] = Variable<int, IntType>(d.thumbsDown.value);
    }
    return map;
  }

  @override
  $DefinitionsTable createAlias(String alias) {
    return $DefinitionsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TermsTable _terms;
  $TermsTable get terms => _terms ??= $TermsTable(this);
  $DefinitionsTable _definitions;
  $DefinitionsTable get definitions => _definitions ??= $DefinitionsTable(this);
  @override
  List<TableInfo> get allTables => [terms, definitions];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TermDaoMixin on DatabaseAccessor<AppDatabase> {
  $TermsTable get terms => db.terms;
}
mixin _$DefinitionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DefinitionsTable get definitions => db.definitions;
}
