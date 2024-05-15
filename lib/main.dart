import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_md_labs/controller/todo_controller.dart';
import 'package:todo_md_labs/ui/todo_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MdLabTodo());
}

class MdLabTodo extends StatelessWidget {
  const MdLabTodo({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        navigatorKey: Get.key,
        debugShowCheckedModeBanner: false,
        title: 'MD Labs ToDo',
        initialRoute: '/',
        getPages: [GetPage(name: '/', page: () => TodosScreen())],
        // home:  TodosScreen(),
      ),
    );
  }
}

