import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhari/controllers/link_controller.dart';

class LinkView extends StatelessWidget {
  LinkView({super.key});

  static const String routeName = '/link/view';

  final LinkController controller = Get.find<LinkController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('link details'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Link View'),
        ),
      ),
    );
  }
}
