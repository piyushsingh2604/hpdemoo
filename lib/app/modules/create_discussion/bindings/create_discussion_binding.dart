import 'package:get/get.dart';

import '../controllers/create_discussion_controller.dart';

class CreateDiscussionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateDiscussionController>(
      () => CreateDiscussionController(),
    );
  }
}
