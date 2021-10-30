# flutter_bili_talk

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

1. 接口文档

 * https://api.devio.org/uapi/swagger-ui.html#/ *

2. 错误码

3. flutter性能优化

 * 内存优化 Flutter  Performance
   Flutter性能检测工具Flutter Performance
   在IDE的Flutter plugin中提供了 Flutter Performance 工具，它是一个可用来检测Flutter滑动帧率和内存
   的工具。
   我们可以从IDE的侧边栏中打开这个工具，也可以借助Dart DevTools来查看内存的使用情况：
   此时可以打开一个页面或进行一些操作来观察内存的变化，如果内存突然增大很多就要特别关注是否是
   合理的增加，必要时要排查导致内存增加的原因和考虑对于的优化方案。
   关于如何判断优化后内存有没有变化，可以通过Dart DevTools的Memory选项卡来完成，当你销毁一个
   FlutterEngine后可以通过 GC 按钮来触发一次 sc来查看内存的变化。

 * build()方法优化   执行了耗时的操作,堆砌了庞大的Widget
    * 在build()方法中执行了耗时的操作
      应该尽量避免在build0中执行耗时的操作，这是因为build0方法会频繁的调用，尤其是当父Widget重建的时候；所以，耗时的操作建议挪到initstate()这种不会被频繁调用的方法中；
      另外，我们尽量不要在代码中进行阻塞式操作，可以将文件读取，数据库操作，网络请求这些操作通过Future来转成异步完成；另外对于CPU计算频繁的操作比如：图片压缩等可以使用Isolate来充分利用多核CPU;

    * build()方法中堆砌了庞大的Widget
    如果build中返回的Widget过于庞大会导致三个问题：
        ·代码可读性差：因为Flutter的布局方式的特殊性，画界面我们离不了的需要一个Wdiget嵌套一个Wdiget，但如果Wdiget嵌套太深则会导致代码的可读性变差，也不利于后期的维护和扩展；
        ·复用难：由于所有的代码都在一个build0方法中，会到导致无法将公共的UI代码服用到其它的页面或模块；
        ·影响性能：我们在State上调用setState0时，所有build0中的Widget都将被重建；因此buildO中返回的Widget树越大那么需要重新建的Widget越多，对性能越不利；见下图：

 * 列表方法优化
 * 帧率优化
    一般是列表滑动的流畅度优化，可能是生成列表的方式，比如直接使用了ListView构造方法，这种情况应该使用ListView.build()方法生成列表。

4. 签名打包

 * 构建release包
    * 构建全部架构的安装包
      cd<flutter应用的android目录>
      mac:`./gradlew assembleRelease`
      window: `gradlew assembleRelease`
      构建出来的Release包是包含所有ABI架构的。
    * 构建单一架构的安装包
      cd<flutter应用的android目录>
      `flutter build apk --split-per-abi`
      flutter build：命令默认会构建出release包
      --split-per-abi：表示构建单一架构

