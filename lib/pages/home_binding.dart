import 'package:get/get.dart';
import 'package:online_shop_app/pages/home_controller.dart';
import 'package:online_shop_app/providers/taskProvider.dart';

import '../services/repository.dart';

class HomeBinding extends Bindings {
  void dependencies (){
    Get.lazyPut(() => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
    ),
    ));
  }
}