import 'package:flutter/material.dart';

void showSuccessBottomSheet(BuildContext context) {

  // 延迟函数 延迟5秒后关闭该界面
  Future.delayed(const Duration(seconds: 5), (){
    // 关闭弹窗
    Navigator.pop(context);
  });

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
        height: 600.00,
        width: 800.00,
        margin: const EdgeInsets.only(
          bottom: 300.0, // 底部边界留有 16.0 的间隔
          left: 128.0, // 左侧边界留有 16.0 的间隔
          right: 128.0, // 右侧边界留有 16.0 的间隔
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0), // 圆角
        ),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              top: 32.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 200.0,
                padding: const EdgeInsets.all(10.0),
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
                child: const Center(
                  child: Text(
                    'This is a bottom sheet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 27, 119, 30),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              iconSize: 64.0,
              alignment: Alignment.topCenter,
              // 点击事件监听
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check_circle, color: Color.fromARGB(255, 27, 119, 30),size: 64.0,)
            ),
          ],
        ),
      );
    },
  );
}