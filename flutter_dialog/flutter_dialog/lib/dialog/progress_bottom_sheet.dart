import 'package:flutter/material.dart';

void showProgressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false, // 禁止点击屏幕其他区域关闭弹窗
      enableDrag: false, // 禁止拖动弹窗使之关闭
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), // 圆角
      ),
      backgroundColor: Colors.transparent, // 背景透明
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400.00,
          margin: const EdgeInsets.only(
            bottom: 16.0, // 底部边界留有 16.0 的间隔
            left: 16.0, // 左侧边界留有 16.0 的间隔
            right: 16.0, // 右侧边界留有 16.0 的间隔
          ),
          padding: const EdgeInsets.all(16.0), // 内容部分留有 16.0 的间距
          decoration: BoxDecoration(
            color: const Color.fromARGB(176, 255, 255, 255),
            borderRadius: BorderRadius.circular(20.0), // 圆角
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        alignment: Alignment.centerLeft,
                        // 点击事件监听
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 27, 119, 30),)
                      ),
                  ),
                  const Expanded(
                    flex: 8,
                    // TODO 国际化弹窗标题
                    child: Text('返回',overflow: TextOverflow.ellipsis,style: TextStyle(color: Color.fromARGB(255, 27, 119, 30),fontSize: 20),)
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        // 国际化语言 点击事件监听
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text('退出',style: TextStyle(color: Colors.black,fontSize: 20),),
                      ),
                    )
                  ),
                ],
              ),
              // 出发模式
              Container(
                height: 50.00,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  left: 36.0,
                  right: 36.0
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.00),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 184, 192, 184),
                      blurRadius: 10.00,
                      spreadRadius: 5.00
                    ),
                  ]
                ),
                child: ElevatedButton(
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromARGB(255, 27, 119, 30); // 按下时背景颜色为绿色
                        }
                        return Colors.white; // 按钮默认背景色为白色
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // 按下时文本颜色为白色
                        }
                        return Colors.black; // 按钮默认文本颜色为黑色
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(150.0, 50.0),
                    ),
                    shadowColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 184, 192, 184),
                    ),
                  ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('出发'),
                  ),
                ),
              Container(
                height: 50.00,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  left: 36.0,
                  right: 36.0
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.00),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 184, 192, 184),
                      blurRadius: 10.00,
                      spreadRadius: 5.00
                    ),
                  ]
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromARGB(255, 27, 119, 30); // 按下时背景颜色为绿色
                        }
                        return Colors.white; // 按钮默认背景色为白色
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // 按下时文本颜色为白色
                        }
                        return Colors.black; // 按钮默认文本颜色为黑色
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(150.0, 50.0),
                    ),
                    shadowColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 184, 192, 184),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('中间'),
                ),
              ),
              Container(
                height: 50.00,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  left: 36.0,
                  right: 36.0
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.00),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 184, 192, 184),
                      blurRadius: 10.00,
                      spreadRadius: 5.00
                    ),
                  ]
                ),
                child: ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(10.0)
                  //   ),
                  //   shadowColor: const Color.fromARGB(255, 184, 192, 184),
                  //   backgroundColor: Colors.white,
                  //   foregroundColor: Colors.black,
                  //   minimumSize: const Size(150.0, 50.0)
                  // ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return const Color.fromARGB(255, 27, 119, 30); // 按下时背景颜色为绿色
                        }
                        return Colors.white; // 按钮默认背景色为白色
                      },
                    ),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          return Colors.white; // 按下时文本颜色为白色
                        }
                        return Colors.black; // 按钮默认文本颜色为黑色
                      },
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(150.0, 50.0),
                    ),
                    shadowColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 184, 192, 184),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('结束'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }