import 'package:flutter/material.dart';
import 'package:flutter_dialog/dialog/progress_bottom_sheet.dart';
import 'package:flutter_dialog/dialog/user_bottom_sheet.dart';
import 'package:flutter_dialog/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'dialog/check_info_bottom_sheet.dart';
import 'dialog/failure_bottom_sheet.dart';
import 'dialog/success_dialog.dart';
import 'dialog/tips_bottom_sheet.dart';

void main() {
  // runApp(const MyApp());
  Application.init().then((value) => runApp(MyApp()));
}

class Application {
  // 该方法不怎么稳定 推荐用下面的方法
  static Future init() async {
    Intl.defaultLocale = 'ja';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 多语言的代理 处理字段映射的委托
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // 区域 支持的区域代表列表
      supportedLocales: S.delegate.supportedLocales,
      // 强行指定默认的语言环境 Intl.defaultLocale = 'ja'; 可能不稳定
      localeResolutionCallback: (locale, supportedLocales) {
        var result = supportedLocales.where((element) => element.languageCode == locale?.languageCode);
        if (result.isNotEmpty) {
          return const Locale('ja');
        }
        return const Locale('ja');
      },
      locale: const Locale('ja'),
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<HomePage> {

  bool isSecond = false;

  void setSecond(bool b) {
    setState(() {
      isSecond: b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Sheet Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Show User Bottom Sheet'),
              onPressed: () {
                showUserBottomSheet(context);
              }
            ),
            ElevatedButton(
              child: Text('Show Progress Bottom Sheet'),
              onPressed: () {
                showProgressBottomSheet(context);
              }
            ),
            ElevatedButton(
              child: Text('Show Tips Bottom Sheet'),
              onPressed: () {
                showTipsBottomSheet(context);
              }
            ),
            ElevatedButton(
              child: Text('Show Success Bottom Sheet'),
              onPressed: () {
                showSuccessBottomSheet(context);
              }
            ),
            ElevatedButton(
              child: Text('Show Failure Bottom Sheet'),
              onPressed: () {
                showFailureBottomSheet(context);
              }
            ),
            ElevatedButton(
              onPressed: () {
                SelectionBottomSheet.showSelectionBottomSheet(context, this);
              },
              child:Text("Show Selection Bottom Sheet") 
            ),
          ]
        ),
      ),
    );
  }
}
