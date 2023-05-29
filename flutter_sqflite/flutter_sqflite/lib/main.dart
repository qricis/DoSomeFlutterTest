import 'package:flutter/material.dart';
import 'utils/memo.dart';
import 'utils/database_dao.dart';
import 'memo_add_screen.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MemoListScreen(),
    );
  }
}

class MemoListScreen extends StatefulWidget {
  const MemoListScreen({Key? key}) : super(key: key);

  @override
  MemoListScreenState createState() => MemoListScreenState();
}

class MemoListScreenState extends State<MemoListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Memo> _memoList = [];

  @override
  void initState() {
    super.initState();
    _refreshMemoList();
  }

  void _refreshMemoList({String? searchKey}) async {
    List<Memo> memoList = await getMemos(searchKey: searchKey);
    setState(() {
      _memoList = memoList;
    });
  }

  void _deleteMemo(Memo memo) async {
    final confirmed = await _showDeleteConfirmationDialog(memo);
    if (confirmed != null && confirmed) {
      await deleteMemo(memo.id);
      _refreshMemoList();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('已删除 "${memo.title}"'),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  Future<bool?> _showDeleteConfirmationDialog(Memo memo) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('删除备忘录'),
          content: Text('确定要删除 "${memo.title}"这条备忘录吗？'),
          actions: [
            TextButton(
              child: const Text(
                '取消',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.pop(context, false),
            ),
            TextButton(
              child: Text('删除',
                  style: TextStyle(
                    color: Colors.red[300],
                  )),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('备忘录'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜索备忘录',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              onChanged: (value) {
                _refreshMemoList(searchKey: value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _memoList.length,
              itemBuilder: (context, index) {
                Memo memo = _memoList[index];
                return ListTile(
                  title: Text(memo.title),
                  subtitle:
                      Text('${DateFormat.yMMMd().format(memo.modifiedTime)}更新'),
                  onTap: () {
                    _navigateToEditScreen(memo);
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever_outlined),
                    onPressed: () {
                      _deleteMemo(memo);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          _navigateToAddScreen();
        },
      ),
    );
  }

  _navigateToAddScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemoAddScreen()),
    );
    if (result != null) {
      _refreshMemoList();
    }
  }

  _navigateToEditScreen(Memo memo) async {
    final count = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MemoEditScreen(memo: memo)),
    );
    if (count != null && count > 0) {
      _refreshMemoList();
    }
  }
}