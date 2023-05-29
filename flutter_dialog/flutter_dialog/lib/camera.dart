import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp(this.camera);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Homepage(camera),
    );
  }
}

class Homepage extends StatefulWidget {
  final CameraDescription camera;

  const Homepage(this.camera);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showBottomSheet(BuildContext context) async {
    await _initializeControllerFuture; // 等待相机初始化完成

    showModalBottomSheet(
      isDismissible: false, // 禁止点击屏幕其他区域关闭弹窗
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // 圆角
      ),
      backgroundColor: Colors.transparent, // 背景透明
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 800.00,
          margin: const EdgeInsets.only(
            bottom: 16.0, // 底部边界留有 16.0 的间隔
            left: 16.0, // 左侧边界留有 16.0 的间隔
            right: 16.0, // 右侧边界留有 16.0 的间隔
          ),
          padding: const EdgeInsets.all(16.0), // 内容部分留有 16.0 的间距
          decoration: BoxDecoration(
            color: Color.fromARGB(129, 255, 255, 255),
            borderRadius: BorderRadius.circular(20.0), // 圆角
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'This is a bottom sheet',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 16.0, // 每个元素上下留有 16.0 的间隔
              ),
              ElevatedButton(
                onPressed: () {
                  _takePicture();
                  Navigator.pop(context);
                },
                child: Text('Take Picture'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _takePicture() async {
    try {
      final XFile image = await _controller.takePicture();

      final directory = await getApplicationDocumentsDirectory();
      final imagePath = path.join(directory.path, '${DateTime.now()}.png');

      if (await File(imagePath).exists()) {
        await File(imagePath).delete();
      }

      await File(image.path).copy(imagePath);

      // 显示预览图片
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: Image.file(File(imagePath)),
          ),
        ),
      );

    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.black,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller); // 显示相机预览
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          ElevatedButton(
            child: Text('Show BottomSheet'),
            onPressed: () {
              _showBottomSheet(context);
            },
          ),
        ],
      ),
    );
  }
}