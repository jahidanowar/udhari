import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhari/controllers/link_controller.dart';
import 'package:udhari/models/Link.dart';

class LinkCreate extends StatefulWidget {
  const LinkCreate({super.key});
  static const String routeName = '/link/create';

  @override
  State<LinkCreate> createState() => _LinkCreateState();
}

class _LinkCreateState extends State<LinkCreate> {
  final LinkController controller = Get.find();

  bool _isLoading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Link'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    controller: _linkController,
                    decoration: const InputDecoration(
                      labelText: 'Link',
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
                  MaterialButton(
                    minWidth: double.infinity,
                    color: Theme.of(context).primaryColor,
                    elevation: 0,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _createLink(context);
                      }
                    },
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2.0,
                          )
                        : const Text('Create'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createLink(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      controller.addLink(Link(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        source: _linkController.text,
        destination: 'Flutter',
        clicks: '0',
      ));

      setState(() {
        _isLoading = false;
      });

      Get.back();

      Get.snackbar(
        "Link created",
        'Link ${_linkController.text} created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }
}
