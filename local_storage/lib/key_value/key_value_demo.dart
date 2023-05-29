import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueDemo extends StatefulWidget {
  const KeyValueDemo({Key? key}) : super(key: key);

  @override
  _KeyValueDemoState createState() => _KeyValueDemoState();
}

class _KeyValueDemoState extends State<KeyValueDemo> {
  // 初始化需要存储的值
  int _counter = 0;
  String _username = '';
  bool _isDarkModeEnabled = false;
  final _textController = TextEditingController(text: '');

  // SharedPreferences 实例
  late SharedPreferences _prefs;

  // 加载 SharedPreferences 中存储的值
  Future<void> _loadData() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = _prefs.getInt('counter') ?? 0;
      _username = _prefs.getString('username') ?? '';
      _textController.text = _username;
      _isDarkModeEnabled = _prefs.getBool('isDarkModeEnabled') ?? false;
    });
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await _prefs.setInt('counter', _counter);
  }

  // 保存用户名
  void _saveUsername(String username) async {
    setState(() {
      _username = username;
    });
    await _prefs.setString('username', _username);
  }

  // 切换暗黑模式
  void _toggleDarkMode(bool isDarkModeEnabled) async {
    setState(() {
      _isDarkModeEnabled = isDarkModeEnabled;
    });
    await _prefs.setBool('isDarkModeEnabled', _isDarkModeEnabled);
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter SharedPreferences 示例',
      theme: _isDarkModeEnabled ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter SharedPreferences 示例'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '计数器的值：$_counter',
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: '请输入您的名字',
                ),
                controller: _textController,
                onChanged: (value) {
                  _saveUsername(value);
                },
              ),
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text('启用暗黑模式'),
                value: _isDarkModeEnabled,
                onChanged: (value) {
                  _toggleDarkMode(value);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: '递增计数器的值',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
