import 'package:flutter/material.dart';
import '../common/button_color.dart';
import 'memo_provider.dart';

class MemoAddScreen extends StatefulWidget {
  const MemoAddScreen({Key? key}) : super(key: key);

  @override
  MemoAddScreenState createState() => MemoAddScreenState();
}

class MemoAddScreenState extends State<MemoAddScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _title, _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('添加备忘录'),
      ),
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: '标题'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入标题';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: '内容',
                      alignLabelWithHint: true,
                    ),
                    minLines: 10,
                    maxLines: null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '请输入内容';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _content = value!;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: PrimaryButtonColor(
                        context: context,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        var id = await saveMemo(context);
                        if (id > 0) {
                          _showSnackBar(context, '备忘录已保存');
                          Navigator.of(context).pop(id);
                        } else {
                          _showSnackBar(context, '备忘录保存失败');
                        }
                      }
                    },
                    child: const Text(
                      '保 存',
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<int> saveMemo(BuildContext context) async {
    var createdTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var modifiedTimestamp = createdTimestamp;
    var memoMap = {
      'title': _title,
      'content': _content,
      'created_time': createdTimestamp,
      'modified_time': modifiedTimestamp,
    };
    // 保存备忘录
    var id = await insertMemo(memoMap);
    return id;
  }

  void _showSnackBar(BuildContext context, String message) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
