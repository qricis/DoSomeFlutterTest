import 'database_helper.dart';
import 'memo.dart';

Future<int> insertMemo(Map<String, dynamic> memoMap) async {
  final db = await DatabaseHelper.instance.database;
  return await db.insert('memo', memoMap);
}

Future<int> updateMemo(Memo memo) async {
  final db = await DatabaseHelper.instance.database;
  return await db
      .update('memo', memo.toMap(), where: 'id = ?', whereArgs: [memo.id]);
}

Future<int> deleteMemo(int id) async {
  final db = await DatabaseHelper.instance.database;
  return await db.delete('memo', where: 'id = ?', whereArgs: [id]);
}

Future<List<Memo>> getMemos({String? searchKey}) async {
  var where = searchKey != null ? 'title LIKE ? OR content LIKE ?' : null;
  var whereArgs = searchKey != null ? ['%$searchKey%', '%$searchKey%'] : null;
  final db = await DatabaseHelper.instance.database;
  final List<Map<String, dynamic>> maps = await db.query(
    'memo',
    orderBy: 'modified_time DESC',
    where: where,
    whereArgs: whereArgs,
  );
  return List.generate(maps.length, (i) {
    return Memo.fromMap(maps[i]);
  });
}
