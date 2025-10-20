import 'package:stormberry/stormberry.dart';
import 'package:stormberry_err_repro/model.dart';

void main(List<String> arguments) async {
  final db = Database(
    host: '127.0.0.1',
    port: 5432,
    database: 'stormberry_demo',
    useSSL: false,
    username: 'postgres',
    password: 'password',
  );

  await migrate(db);
  await db.users.deleteOne('1');
  await db.posts.deleteMany(['1', '2', '3']);
  final creationDate = DateTime.now();

  await db.users.insertOne(UserInsertRequest(id: '1', createdAt: creationDate));
  await db.posts.insertOne(
    PostInsertRequest(
      id: '1',
      content: 'Hello, world!',
      createdAt: creationDate,
      userId: '1',
    ),
  );
  await db.posts.insertOne(
    PostInsertRequest(
      id: '2',
      content: 'Hello, world!',
      createdAt: creationDate,
      userId: '1',
    ),
  );
  await db.posts.insertOne(
    PostInsertRequest(
      id: '3',
      content: 'Hello, world!',
      createdAt: creationDate,
      userId: '1',
    ),
  );

  final user = await db.users.queryUser('1');
  print(
    'user!.posts.first.createdAt: ${user!.posts.first.createdAt} isUTC? ${user.posts.first.createdAt.isUtc}',
  );

  final firstUserPost = user.posts.where((post) => post.id == '1').first;
  final firstPost = await db.posts.queryPost('1');
  print(
    'post!.createdAt: ${firstPost!.createdAt} isUTC? ${firstPost.createdAt.isUtc}',
  );
  print('dates are equal? ${firstUserPost.createdAt == firstPost.createdAt}');

  await db.close();
}
