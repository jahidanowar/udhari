import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhari/models/Link.dart';

class LinkController extends GetxController {
  final RxList<Link> links = <Link>[].obs;
  // Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Form Controller
  TextEditingController linkFormController = TextEditingController();
  RxBool isFormLoading = false.obs;

  // Getters
  bool get isLoading => isFormLoading.value;
  List<Link> get allLinks => links;
  int get totalLinks => links.length;
  int get totalClicks => links.fold<int>(
        0,
        (int previousValue, Link element) =>
            previousValue + int.parse(element.clicks),
      );

  // Mutators
  void addLink(Link link) {
    links.add(link);
  }

  void removeLink(Link link) {
    links.remove(link);
  }

  // Actions

  void createLink() {
    if (formKey.currentState!.validate()) {
      isFormLoading.value = true;

      Future.delayed(const Duration(seconds: 2), () {
        isFormLoading.value = false;
        addLink(Link(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          source: linkFormController.text,
          destination: 'Flutter',
          clicks: '1',
        ));

        Get.back();

        Get.snackbar(
          "link created successfully",
          linkFormController.text,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );

        linkFormController.clear();
      });
    }
  }
}
