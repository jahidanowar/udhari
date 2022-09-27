import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhari/controllers/link_controller.dart';

class LinkCreate extends StatefulWidget {
  const LinkCreate({super.key});
  static const String routeName = '/link/create';

  @override
  State<LinkCreate> createState() => _LinkCreateState();
}

class _LinkCreateState extends State<LinkCreate> {
  final LinkController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('create link'),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    controller: controller.linkFormController,
                    decoration: const InputDecoration(
                      labelText: 'eneter or paste a valid url',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      // Check if the link is valid
                      if (!Uri.parse(value).isAbsolute) {
                        return 'Please enter a valid link';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => MaterialButton(
                      minWidth: double.infinity,
                      color: Theme.of(context).primaryColor,
                      elevation: 0,
                      onPressed: controller.createLink,
                      child: controller.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            )
                          : const Text('create'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
