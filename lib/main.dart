import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_shop_app/pages/home_binding.dart';
import 'package:online_shop_app/pages/signup.dart';
import 'package:online_shop_app/pages/login.dart';
import 'package:online_shop_app/services/repository.dart';
import 'package:online_shop_app/services/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyApp',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: Login(),
      initialBinding: HomeBinding(),
      builder: EasyLoading.init(),
    );
  }
}

