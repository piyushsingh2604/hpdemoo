import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hpdemo/app/data/api_model.dart';
import 'package:hpdemo/app/data/pdf_model.dart';
import 'package:hpdemo/app/modules/create_discussion/services/create_discussion_services.dart';
import 'package:hpdemo/app/modules/pdf_search/services/pdf_services.dart';
import 'package:hpdemo/app/routes/app_pages.dart';
import 'package:image_picker/image_picker.dart';

class CreateDiscussionController extends GetxController {
  RxList<File> images = <File>[].obs;

  // add pdf screen
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  TextEditingController source = TextEditingController();

  RxBool onTap = false.obs;
  RxBool isVisible = false.obs;
    
   DiscussionLists? selectedDiscussion;
  late String pdfId;

  



  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic> arg = Get.arguments;
    if(arg['isUpdate'] == true ){
      // When we are updating a discussion
      selectedDiscussion =  arg['data'];
      pdfId = selectedDiscussion!.pdfId!;
      title.text = selectedDiscussion!.title!;
            body.text = selectedDiscussion!.body!;

    }
    else{
      // When we are creating new discussion
      pdfId = arg['pdfId'];
    }

  }



  // add pdf screen
  void onTapButton() {
    onTap.value = !onTap.value;
  }

  void isVisibleButton() {
    isVisible.value = !isVisible.value;
  }

  Future addImageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    File imageTemp = File(image.path);
    print("Image from gallery picked: ${imageTemp.path}");
    images.add(imageTemp);
  }

  Future addImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    File imageTemp = File(image.path);
    print("Image from camera picked: ${imageTemp.path}");
    images.add(imageTemp);
  }

  void deleteImage(int i) {
    images.removeAt(i);
  }

  void createNewDiscussion() async{
  CreateDiscussionServices services = CreateDiscussionServices();

    bool result = await  services.createUpdateDiscussion(title.text, body.text, pdfId,
        images.map((e) => e.path).toList() as List<String>?, source.text);
        if(result){
          Get.toNamed(Routes.HOME);
        }
  }
}
