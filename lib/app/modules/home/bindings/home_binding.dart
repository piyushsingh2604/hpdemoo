import 'package:get/get.dart';
import 'package:hpdemo/app/modules/pdf_search/controllers/pdf_search_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
        Get.lazyPut<PdfSearchController>(
      () => PdfSearchController(),
    );
  }
}
