import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:isolate';

import 'package:my_flutter_app/generated/l10n.dart';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';


/// If the request data is a `List` type, the [BackgroundTransformer] will send data
/// by calling its `toString()` method. However, normally the List object is
/// not expected for request data( mostly need Map ). So we provide a custom
/// [Transformer] that will throw error when request data is a `List` type.

class MyTransformer extends BackgroundTransformer {
  @override
  Future<String> transformRequest(RequestOptions options) async {
    if (options.data is List<String>) {
      throw DioError(
        error: "Can't send List to sever directly",
        requestOptions: options,
      );
    } else {
      return super.transformRequest(options);
    }
  }

  /// The [Options] doesn't contain the cookie info. we add the cookie
  /// info to [Options.extra], and you can retrieve it in [ResponseInterceptor]
  /// and [Response] with `response.request.extra["cookies"]`.
  @override
  Future transformResponse(
    RequestOptions options,
    ResponseBody response,
  ) async {
    options.extra['self'] = 'XX';
    return super.transformResponse(options, response);
  }
}

void main() async {
  final dio = Dio();
  // Use custom Transformer
  dio.transformer = MyTransformer();

  final response = await dio.get('https://www.baidu.com');
  print(response.requestOptions.extra['self']);

  try {
    await dio.post('https://www.baidu.com', data: ['1', '2']);
  } catch (e) {
    print(e);
  }
}


// void main() async {
//   final dio = Dio();
//   //  dio instance to request token
//   final tokenDio = Dio();
//   String? csrfToken;
//   dio.options.baseUrl = 'https://seunghwanlytest.mocklab.io/';
//   tokenDio.options = dio.options;
//   dio.interceptors.add(
//     QueuedInterceptorsWrapper(
//       onRequest: (options, handler) async {
//         print('send request：path:${options.path}，baseURL:${options.baseUrl}');

//         if (csrfToken == null) {
//           print('no token，request token firstly...');

//           final result = await tokenDio.get('/token');

//           if (result.statusCode != null && result.statusCode! ~/ 100 == 2) {
//             /// assume `token` is in response body
//             final body = jsonDecode(result.data) as Map<String, dynamic>?;

//             if (body != null && body.containsKey('data')) {
//               options.headers['csrfToken'] = csrfToken = body['data']['token'];
//               print('request token succeed, value: $csrfToken');
//               print(
//                 'continue to perform request：path:${options.path}，baseURL:${options.path}',
//               );
//               return handler.next(options);
//             }
//           }

//           return handler.reject(
//             DioError(requestOptions: result.requestOptions),
//             true,
//           );
//         }

//         options.headers['csrfToken'] = csrfToken;
//         return handler.next(options);
//       },
//       onError: (error, handler) async {
//         /// Assume 401 stands for token expired
//         if (error.response?.statusCode == 401) {
//           print('the token has expired, need to receive new token');
//           final options = error.response!.requestOptions;

//           /// assume receiving the token has no errors
//           /// to check `null-safety` and error handling
//           /// please check inside the [onRequest] closure
//           final tokenResult = await tokenDio.get('/token');

//           /// update [csrfToken]
//           /// assume `token` is in response body
//           final body = jsonDecode(tokenResult.data) as Map<String, dynamic>?;
//           options.headers['csrfToken'] = csrfToken = body!['data']['token'];

//           if (options.headers['csrfToken'] != null) {
//             print('the token has been updated');

//             /// since the api has no state, force to pass the 401 error
//             /// by adding query parameter
//             final originResult = await dio.fetch(options..path += '&pass=true');
//             if (originResult.statusCode != null &&
//                 originResult.statusCode! ~/ 100 == 2) {
//               return handler.resolve(originResult);
//             }
//           }
//           print('the token has not been updated');
//           return handler.reject(
//             DioError(requestOptions: options),
//           );
//         }
//         return handler.next(error);
//       },
//     ),
//   );

//   FutureOr<void> onResult(d) {
//     print('request ok!');
//   }

//   /// assume `/test?tag=2` path occurs the authorization error (401)
//   /// and token to be updated
//   await dio.get('/test?tag=1').then(onResult);
//   await dio.get('/test?tag=2').then(onResult);
//   await dio.get('/test?tag=3').then(onResult);
// }


// void main() {
//   runApp(const SampleApp());
// }

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

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
      // 强行指定默认的语言环境 Intl.defaultLocale = 'en'; 可能不稳定
      localeResolutionCallback: (locale, supportedLocales) {
        var result = supportedLocales.where((element) => element.languageCode == locale?.languageCode);
        if (result.isNotEmpty) {
          return Locale('en');
        }
        return Locale('en');
      },
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({Key? key}) : super(key: key);

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  showLoadingDialog() {
    if (widgets.isEmpty) {
      return true;
    }

    return false;
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return getListView();
      // return const Image(image: AssetImage("images/1.png"),width: 100);
    }
  }

  getProgressDialog() {
    return const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sample App"),
        ),
        body: 
          // Align(
          //   alignment: Alignment.topLeft,
          //   child:Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       Text(S.current.about),
          //       Text(S.current.greet("西西子")),
          //       Text(S.current.askChoice("去看王姐演唱会", "去听JJ的演唱会")),
          //       Text(S.current.customDateFormat(DateTime.now())),
          //     ],
          //   ),
            
          // ));
          getBody());
        
  }

  ListView getListView() => ListView.builder(
      itemCount: widgets.length,
      itemBuilder: (BuildContext context, int position) {
        return getRow(position);
      });

  Widget getRow(int i) {
    // return Padding(padding: const EdgeInsets.all(10.0), child: Text("Num ${widgets[i]['id']} Row ${widgets[i]['title']}"));
    
    // 包装成一个触摸事件 可以在这里处理事件
    return GestureDetector(
      child: Padding(padding: const EdgeInsets.all(10.0), child: Text("Num ${widgets[i]['id']} Row ${widgets[i]['title']}")),
      onTap: () {
        print("${widgets[i]['id']} tapped");
      },
    );
    
  }

  // 使用包装之后的http的API 相当于下面的loadData() + dataLoader() + sendReceive()
  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(Uri.parse(dataURL));
    setState(() {
      widgets = json.decode(response.body);
    });
  }

//   loadData() async {
//     ReceivePort receivePort = new ReceivePort();
//     await Isolate.spawn(dataLoader, receivePort.sendPort);

//     // The 'echo' isolate sends it's SendPort as the first message
//     SendPort sendPort = await receivePort.first;

//     List msg = await sendReceive(sendPort, "https://jsonplaceholder.typicode.com/posts");

//     setState(() {
//       widgets = msg;
//     });
//   }

// // the entry point for the isolate
//   static dataLoader(SendPort sendPort) async {
//     // Open the ReceivePort for incoming messages.
//     ReceivePort port = new ReceivePort();

//     // Notify any other isolates what port this isolate listens to.
//     sendPort.send(port.sendPort);

//     await for (var msg in port) {
//       String data = msg[0];
//       SendPort replyTo = msg[1];

//       String dataURL = data;
//       http.Response response = await http.get(Uri.parse(dataURL) );
//       // Lots of JSON to parse
//       replyTo.send(json.decode(response.body));
//     }
//   }

//   Future sendReceive(SendPort port, msg) {
//     ReceivePort response = new ReceivePort();
//     port.send([msg, response.sendPort]);
//     return response.first;
//   }

}