import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nanoid/nanoid.dart';
import 'package:udhari/models/Link.dart';
import 'package:udhari/screens/login_screen.dart';

class LinkController extends GetxController {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final RxList<Link> links = <Link>[].obs;
  RxBool isFormLoading = false.obs;
  // Form Key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Form Controller
  TextEditingController linkFormController = TextEditingController();
  TextEditingController keyFormController = TextEditingController();

  @override
  void onInit() async {
    keyFormController.text = nanoid(10);
    super.onInit();
  }

  // Getters
  bool get isLoading => isFormLoading.value;
  List<Link> get allLinks => links;
  int get totalLinks => links.length;
  int get totalClicks => links.fold<int>(
        0,
        (int previousValue, Link element) => previousValue + element.clicks,
      );

  // Mutators
  void addLink(Link link) {
    links.insert(0, link);
  }

  void removeLink(Link link) {
    links.remove(link);
  }

  // Actions
  void fetchLinks() async {
    final linkRecords = await FirebaseFirestore.instance
        .collection('/users')
        .doc(currentUser!.uid)
        .collection('/links')
        .get();
    for (var element in linkRecords.docs) {
      addLink(Link.fromJson(element.data()));
    }
  }

  void createLink() async {
    if (currentUser == null) {
      Get.snackbar('Error', 'Please login to create a link');
      Get.offAllNamed(LoginScreen.routeName);
      return;
    }

    if (formKey.currentState!.validate()) {
      isFormLoading.value = true;
      try {
        Link link = Link(
          source: keyFormController.text,
          destination: linkFormController.text,
          clicks: 0,
        );

        await FirebaseFirestore.instance
            .collection('/users')
            .doc(currentUser!.uid)
            .collection('/links')
            .add(link.toJson());

        addLink(link);

        isFormLoading.value = false;

        Get.back();

        Get.snackbar(
          "link created successfully",
          linkFormController.text,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        linkFormController.clear();
        keyFormController.text = nanoid(10);
      } catch (e) {
        print(e);
      } finally {
        isFormLoading.value = false;
      }
    }
  }

  void deleteLink(Link link) async {
    try {
      await FirebaseFirestore.instance
          .collection('/users')
          .doc(currentUser!.uid)
          .collection('/links')
          .where('source', isEqualTo: link.source)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });

      removeLink(link);

      Get.snackbar(
        "link deleted successfully",
        link.source,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    } catch (e) {
      print(e);
    }
  }
}
