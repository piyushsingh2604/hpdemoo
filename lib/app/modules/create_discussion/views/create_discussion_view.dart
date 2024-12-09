import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:get/get.dart';

import '../controllers/create_discussion_controller.dart';

class CreateDiscussionView extends GetView<CreateDiscussionController> {
  const CreateDiscussionView({super.key});
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Create Discussion"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                controller.createNewDiscussion();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff003440),
                    borderRadius: BorderRadius.circular(15)),
                width: 70,
                height: 40,
                child: const Center(
                  child: Text(
                    "Post",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  child: TextField(
                    controller: controller.title,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Title',
                      hintStyle: TextStyle(
                          color: Color(0xffAEAEAE),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextField(
                  controller: controller.body,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Write something...',
                    hintStyle: TextStyle(
                        color: Color(0xffAEAEAE),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 90,
                ),
                const Divider(
                  color: Color(0xffE2E2E2),
                  endIndent: 9,
                  indent: 9,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Mention source",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    FlutterSwitch(
                      activeColor: const Color(0xff003440),
                      height: 20.0,
                      width: 40.0,
                      padding: 4.0,
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      value: controller.onTap.value,
                      onToggle: (value) {
                        controller.onTapButton();
                        controller.isVisibleButton();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Visibility(
                  visible: controller.isVisible.value,
                  child: const TextField(
                    decoration: InputDecoration(
                        hintText: 'Mention source',
                        border: OutlineInputBorder()),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 100,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          controller.addImage();
                                          Get.back();
                                        },
                                        child: const Text("Camera")),
                                    ElevatedButton(
                                        onPressed: () {
                                          controller.addImageFromGallery();
                                          Get.back();
                                        },
                                        child: const Text("Gallery"))
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Color(0xff003440),
                      )),
                ),
                SizedBox(
                    height: 150,
                    child: PageView.builder(
                      itemCount: controller.images.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(controller.images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 5,
                                right: 10,
                                child: IconButton(
                                    onPressed: () {
                                      controller.deleteImage(index);
                                    },
                                    icon: const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    )))
                          ],
                        );
                      },
                    )),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
