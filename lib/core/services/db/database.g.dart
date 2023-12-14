// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TermsTable extends Terms with TableInfo<$TermsTable, Term> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TermsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
      'term', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastViewedMeta =
      const VerificationMeta('lastViewed');
  @override
  late final GeneratedColumn<DateTime> lastViewed = GeneratedColumn<DateTime>(
      'last_viewed', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [term, lastViewed, isFavorite];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'terms';
  @override
  VerificationContext validateIntegrity(Insertable<Term> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('term')) {
      context.handle(
          _termMeta, term.isAcceptableOrUnknown(data['term']!, _termMeta));
    } else if (isInserting) {
      context.missing(_termMeta);
    }
    if (data.containsKey('last_viewed')) {
      context.handle(
          _lastViewedMeta,
          lastViewed.isAcceptableOrUnknown(
              data['last_viewed']!, _lastViewedMeta));
    } else if (isInserting) {
      context.missing(_lastViewedMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {term};
  @override
  Term map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Term(
      term: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}term'])!,
      lastViewed: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_viewed'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $TermsTable createAlias(String alias) {
    return $TermsTable(attachedDatabase, alias);
  }
}

class Term extends DataClass implements Insertable<Term> {
  final String term;
  final DateTime lastViewed;
  final bool isFavorite;
  const Term(
      {required this.term, required this.lastViewed, required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['term'] = Variable<String>(term);
    map['last_viewed'] = Variable<DateTime>(lastViewed);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  TermsCompanion toCompanion(bool nullToAbsent) {
    return TermsCompanion(
      term: Value(term),
      lastViewed: Value(lastViewed),
      isFavorite: Value(isFavorite),
    );
  }

  factory Term.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Term(
      term: serializer.fromJson<String>(json['term']),
      lastViewed: serializer.fromJson<DateTime>(json['lastViewed']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'term': serializer.toJson<String>(term),
      'lastViewed': serializer.toJson<DateTime>(lastViewed),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Term copyWith({String? term, DateTime? lastViewed, bool? isFavorite}) => Term(
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
  int get hashCode => Object.hash(term, lastViewed, isFavorite);
  @override
  bool operator ==(Object other) =>
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
  final Value<int> rowid;
  const TermsCompanion({
    this.term = const Value.absent(),
    this.lastViewed = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TermsCompanion.insert({
    required String term,
    required DateTime lastViewed,
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : term = Value(term),
        lastViewed = Value(lastViewed);
  static Insertable<Term> custom({
    Expression<String>? term,
    Expression<DateTime>? lastViewed,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (term != null) 'term': term,
      if (lastViewed != null) 'last_viewed': lastViewed,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TermsCompanion copyWith(
      {Value<String>? term,
      Value<DateTime>? lastViewed,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return TermsCompanion(
      term: term ?? this.term,
      lastViewed: lastViewed ?? this.lastViewed,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (lastViewed.present) {
      map['last_viewed'] = Variable<DateTime>(lastViewed.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TermsCompanion(')
          ..write('term: $term, ')
          ..write('lastViewed: $lastViewed, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DefinitionsTable extends Definitions
    with TableInfo<$DefinitionsTable, Definition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _termMeta = const VerificationMeta('term');
  @override
  late final GeneratedColumn<String> term = GeneratedColumn<String>(
      'term', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _definitionMeta =
      const VerificationMeta('definition');
  @override
  late final GeneratedColumn<String> definition = GeneratedColumn<String>(
      'definition', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exampleMeta =
      const VerificationMeta('example');
  @override
  late final GeneratedColumn<String> example = GeneratedColumn<String>(
      'example', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _thumbsUpMeta =
      const VerificationMeta('thumbsUp');
  @override
  late final GeneratedColumn<int> thumbsUp = GeneratedColumn<int>(
      'thumbs_up', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _thumbsDownMeta =
      const VerificationMeta('thumbsDown');
  @override
  late final GeneratedColumn<int> thumbsDown = GeneratedColumn<int>(
      'thumbs_down', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, term, definition, example, author, thumbsUp, thumbsDown];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'definitions';
  @override
  VerificationContext validateIntegrity(Insertable<Definition> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('term')) {
      context.handle(
          _termMeta, term.isAcceptableOrUnknown(data['term']!, _termMeta));
    }
    if (data.containsKey('definition')) {
      context.handle(
          _definitionMeta,
          definition.isAcceptableOrUnknown(
              data['definition']!, _definitionMeta));
    } else if (isInserting) {
      context.missing(_definitionMeta);
    }
    if (data.containsKey('example')) {
      context.handle(_exampleMeta,
          example.isAcceptableOrUnknown(data['example']!, _exampleMeta));
    } else if (isInserting) {
      context.missing(_exampleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('thumbs_up')) {
      context.handle(_thumbsUpMeta,
          thumbsUp.isAcceptableOrUnknown(data['thumbs_up']!, _thumbsUpMeta));
    } else if (isInserting) {
      context.missing(_thumbsUpMeta);
    }
    if (data.containsKey('thumbs_down')) {
      context.handle(
          _thumbsDownMeta,
          thumbsDown.isAcceptableOrUnknown(
              data['thumbs_down']!, _thumbsDownMeta));
    } else if (isInserting) {
      context.missing(_thumbsDownMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Definition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Definition(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      term: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}term']),
      definition: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}definition'])!,
      example: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}example'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      thumbsUp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}thumbs_up'])!,
      thumbsDown: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}thumbs_down'])!,
    );
  }

  @override
  $DefinitionsTable createAlias(String alias) {
    return $DefinitionsTable(attachedDatabase, alias);
  }
}

class Definition extends DataClass implements Insertable<Definition> {
  final int? id;
  final String? term;
  final String definition;
  final String example;
  final String author;
  final int thumbsUp;
  final int thumbsDown;
  const Definition(
      {this.id,
      this.term,
      required this.definition,
      required this.example,
      required this.author,
      required this.thumbsUp,
      required this.thumbsDown});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || term != null) {
      map['term'] = Variable<String>(term);
    }
    map['definition'] = Variable<String>(definition);
    map['example'] = Variable<String>(example);
    map['author'] = Variable<String>(author);
    map['thumbs_up'] = Variable<int>(thumbsUp);
    map['thumbs_down'] = Variable<int>(thumbsDown);
    return map;
  }

  DefinitionsCompanion toCompanion(bool nullToAbsent) {
    return DefinitionsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      term: term == null && nullToAbsent ? const Value.absent() : Value(term),
      definition: Value(definition),
      example: Value(example),
      author: Value(author),
      thumbsUp: Value(thumbsUp),
      thumbsDown: Value(thumbsDown),
    );
  }

  factory Definition.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Definition(
      id: serializer.fromJson<int?>(json['id']),
      term: serializer.fromJson<String?>(json['term']),
      definition: serializer.fromJson<String>(json['definition']),
      example: serializer.fromJson<String>(json['example']),
      author: serializer.fromJson<String>(json['author']),
      thumbsUp: serializer.fromJson<int>(json['thumbs_up']),
      thumbsDown: serializer.fromJson<int>(json['thumbs_down']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'term': serializer.toJson<String?>(term),
      'definition': serializer.toJson<String>(definition),
      'example': serializer.toJson<String>(example),
      'author': serializer.toJson<String>(author),
      'thumbs_up': serializer.toJson<int>(thumbsUp),
      'thumbs_down': serializer.toJson<int>(thumbsDown),
    };
  }

  Definition copyWith(
          {Value<int?> id = const Value.absent(),
          Value<String?> term = const Value.absent(),
          String? definition,
          String? example,
          String? author,
          int? thumbsUp,
          int? thumbsDown}) =>
      Definition(
        id: id.present ? id.value : this.id,
        term: term.present ? term.value : this.term,
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
  int get hashCode =>
      Object.hash(id, term, definition, example, author, thumbsUp, thumbsDown);
  @override
  bool operator ==(Object other) =>
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
  final Value<int?> id;
  final Value<String?> term;
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
    this.term = const Value.absent(),
    required String definition,
    required String example,
    required String author,
    required int thumbsUp,
    required int thumbsDown,
  })  : definition = Value(definition),
        example = Value(example),
        author = Value(author),
        thumbsUp = Value(thumbsUp),
        thumbsDown = Value(thumbsDown);
  static Insertable<Definition> custom({
    Expression<int>? id,
    Expression<String>? term,
    Expression<String>? definition,
    Expression<String>? example,
    Expression<String>? author,
    Expression<int>? thumbsUp,
    Expression<int>? thumbsDown,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (term != null) 'term': term,
      if (definition != null) 'definition': definition,
      if (example != null) 'example': example,
      if (author != null) 'author': author,
      if (thumbsUp != null) 'thumbs_up': thumbsUp,
      if (thumbsDown != null) 'thumbs_down': thumbsDown,
    });
  }

  DefinitionsCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? term,
      Value<String>? definition,
      Value<String>? example,
      Value<String>? author,
      Value<int>? thumbsUp,
      Value<int>? thumbsDown}) {
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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (term.present) {
      map['term'] = Variable<String>(term.value);
    }
    if (definition.present) {
      map['definition'] = Variable<String>(definition.value);
    }
    if (example.present) {
      map['example'] = Variable<String>(example.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (thumbsUp.present) {
      map['thumbs_up'] = Variable<int>(thumbsUp.value);
    }
    if (thumbsDown.present) {
      map['thumbs_down'] = Variable<int>(thumbsDown.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DefinitionsCompanion(')
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
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $TermsTable terms = $TermsTable(this);
  late final $DefinitionsTable definitions = $DefinitionsTable(this);
  late final TermDao termDao = TermDao(this as AppDatabase);
  late final DefinitionsDao definitionsDao =
      DefinitionsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [terms, definitions];
}

mixin _$TermDaoMixin on DatabaseAccessor<AppDatabase> {
  $TermsTable get terms => attachedDatabase.terms;
}
mixin _$DefinitionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DefinitionsTable get definitions => attachedDatabase.definitions;
}
