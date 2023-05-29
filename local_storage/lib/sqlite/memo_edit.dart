import 'package:flutter/material.dart';
import '../common/button_color.dart';
import 'memo_provider.dart';

import 'memo.dart';

class MemoEditScreen extends StatefulWidget {
  final Memo memo;
  const MemoEditScreen({Key? key, required this.memo}) : super(key: key);

  @override
  MemoEditScreenState createState() => MemoEditScreenState();
}

class MemoEditScreenState extends State<MemoEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late String _title, _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑备忘录'),
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
                    initialValue: widget.memo.title,
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
                    decoration: const InputDecoration(labelText: '内容'),
                    initialValue: widget.memo.content,
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
    widget.memo.title = _title;
    widget.memo.content = _content;
    widget.memo.modifiedTime = DateTime.now();
    // 保存备忘录
    var count = await updateMemo(widget.memo);
    return count;
  }

  void _showSnackBar(BuildContext context, String message) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
