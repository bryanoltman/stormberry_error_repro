// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint
// ignore_for_file: annotate_overrides
// dart format off

part of 'model.dart';

extension ModelRepositories on Session {
  UserRepository get users => UserRepository._(this);
  PostRepository get posts => PostRepository._(this);
}

abstract class UserRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<UserInsertRequest>,
        ModelRepositoryUpdate<UserUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory UserRepository._(Session db) = _UserRepository;

  Future<UserView?> queryUser(String id);
  Future<List<UserView>> queryUsers([QueryParams? params]);
}

class _UserRepository extends BaseRepository
    with
        RepositoryInsertMixin<UserInsertRequest>,
        RepositoryUpdateMixin<UserUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements UserRepository {
  _UserRepository(super.db) : super(tableName: 'users', keyName: 'id');

  @override
  Future<UserView?> queryUser(String id) {
    return queryOne(id, UserViewQueryable());
  }

  @override
  Future<List<UserView>> queryUsers([QueryParams? params]) {
    return queryMany(UserViewQueryable(), params);
  }

  @override
  Future<void> insert(List<UserInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.execute(
      Sql.named(
        'INSERT INTO "users" ( "id", "created_at" )\n'
        'VALUES ${requests.map((r) => '( ${values.add(r.id)}:text, ${values.add(r.createdAt)}:timestamp )').join(', ')}\n',
      ),
      parameters: values.values,
    );
  }

  @override
  Future<void> update(List<UserUpdateRequest> requests) async {
    if (requests.isEmpty) return;

    final updateRequests = [
      for (final r in requests)
        if (r.createdAt != null) r,
    ];

    if (updateRequests.isNotEmpty) {
      var values = QueryValues();
      await db.execute(
        Sql.named(
          'UPDATE "users"\n'
          'SET "created_at" = COALESCE(UPDATED."created_at", "users"."created_at")\n'
          'FROM ( VALUES ${updateRequests.map((r) => '( ${values.add(r.id)}:text::text, ${values.add(r.createdAt)}:timestamp::timestamp )').join(', ')} )\n'
          'AS UPDATED("id", "created_at")\n'
          'WHERE "users"."id" = UPDATED."id"',
        ),
        parameters: values.values,
      );
    }
  }
}

abstract class PostRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<PostInsertRequest>,
        ModelRepositoryUpdate<PostUpdateRequest>,
        ModelRepositoryDelete<String> {
  factory PostRepository._(Session db) = _PostRepository;

  Future<PostView?> queryPost(String id);
  Future<List<PostView>> queryPosts([QueryParams? params]);
}

class _PostRepository extends BaseRepository
    with
        RepositoryInsertMixin<PostInsertRequest>,
        RepositoryUpdateMixin<PostUpdateRequest>,
        RepositoryDeleteMixin<String>
    implements PostRepository {
  _PostRepository(super.db) : super(tableName: 'posts', keyName: 'id');

  @override
  Future<PostView?> queryPost(String id) {
    return queryOne(id, PostViewQueryable());
  }

  @override
  Future<List<PostView>> queryPosts([QueryParams? params]) {
    return queryMany(PostViewQueryable(), params);
  }

  @override
  Future<void> insert(List<PostInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.execute(
      Sql.named(
        'INSERT INTO "posts" ( "id", "content", "created_at", "user_id" )\n'
        'VALUES ${requests.map((r) => '( ${values.add(r.id)}:text, ${values.add(r.content)}:text, ${values.add(r.createdAt)}:timestamp, ${values.add(r.userId)}:text )').join(', ')}\n',
      ),
      parameters: values.values,
    );
  }

  @override
  Future<void> update(List<PostUpdateRequest> requests) async {
    if (requests.isEmpty) return;

    final updateRequests = [
      for (final r in requests)
        if (r.content != null || r.createdAt != null || r.userId != null) r,
    ];

    if (updateRequests.isNotEmpty) {
      var values = QueryValues();
      await db.execute(
        Sql.named(
          'UPDATE "posts"\n'
          'SET "content" = COALESCE(UPDATED."content", "posts"."content"), "created_at" = COALESCE(UPDATED."created_at", "posts"."created_at"), "user_id" = COALESCE(UPDATED."user_id", "posts"."user_id")\n'
          'FROM ( VALUES ${updateRequests.map((r) => '( ${values.add(r.id)}:text::text, ${values.add(r.content)}:text::text, ${values.add(r.createdAt)}:timestamp::timestamp, ${values.add(r.userId)}:text::text )').join(', ')} )\n'
          'AS UPDATED("id", "content", "created_at", "user_id")\n'
          'WHERE "posts"."id" = UPDATED."id"',
        ),
        parameters: values.values,
      );
    }
  }
}

class UserInsertRequest {
  UserInsertRequest({required this.id, required this.createdAt});

  final String id;
  final DateTime createdAt;
}

class PostInsertRequest {
  PostInsertRequest({
    required this.id,
    required this.content,
    required this.createdAt,
    this.userId,
  });

  final String id;
  final String content;
  final DateTime createdAt;
  final String? userId;
}

class UserUpdateRequest {
  UserUpdateRequest({required this.id, this.createdAt});

  final String id;
  final DateTime? createdAt;
}

class PostUpdateRequest {
  PostUpdateRequest({
    required this.id,
    this.content,
    this.createdAt,
    this.userId,
  });

  final String id;
  final String? content;
  final DateTime? createdAt;
  final String? userId;
}

class UserViewQueryable extends KeyedViewQueryable<UserView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query =>
      'SELECT "users".*, "posts"."data" as "posts"'
      'FROM "users"'
      'LEFT JOIN ('
      '  SELECT "posts"."user_id",'
      '    to_jsonb(array_agg("posts".*)) as data'
      '  FROM (${PostViewQueryable().query}) "posts"'
      '  GROUP BY "posts"."user_id"'
      ') "posts"'
      'ON "users"."id" = "posts"."user_id"';

  @override
  String get tableAlias => 'users';

  @override
  UserView decode(TypedMap map) => UserView(
    id: map.get('id'),
    createdAt: map.get('created_at'),
    posts: map.getListOpt('posts', PostViewQueryable().decoder) ?? const [],
  );
}

class UserView {
  UserView({required this.id, required this.createdAt, required this.posts});

  final String id;
  final DateTime createdAt;
  final List<PostView> posts;
}

class PostViewQueryable extends KeyedViewQueryable<PostView, String> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(String key) => TextEncoder.i.encode(key);

  @override
  String get query =>
      'SELECT "posts".*'
      'FROM "posts"';

  @override
  String get tableAlias => 'posts';

  @override
  PostView decode(TypedMap map) => PostView(
    id: map.get('id'),
    content: map.get('content'),
    createdAt: map.get('created_at'),
  );
}

class PostView {
  PostView({required this.id, required this.content, required this.createdAt});

  final String id;
  final String content;
  final DateTime createdAt;
}
