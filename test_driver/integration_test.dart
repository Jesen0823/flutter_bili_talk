import 'package:integration_test/integration_test_driver.dart';

/// 集成测试步骤：
/// 1.添加测试驱动
///    添加测试驱动的目的是为了方便通过flutter drive命令运行集成测试：在项目根目录创建test_driver目录并添加文件 integration_test.dart:
///    import 'package:integration_test/integration_test_driver.dart';
///    Future<void> main() => integrationDriver();
///
/// 2.编写测试用例
///    在项目根目录创建integration_test目录并添加文件 app_test.dart
///
/// 3.运行测试用例
///    运行集成测试的测试用例可以通过以下命令来完成：
///    flutter drive  --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
///    --driver：用于指定测试驱动的路径；
///    --target：用于指定测试用例的路径；
/// 4.查看结果
///
Future<void> main() => integrationDriver();
