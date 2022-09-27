import 'package:flutter/material.dart';

class LinkCreate extends StatefulWidget {
  const LinkCreate({super.key});
  static const String routeName = '/link/create';

  @override
  State<LinkCreate> createState() => _LinkCreateState();
}

class _LinkCreateState extends State<LinkCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Link Controller
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
                        _createLink();
                      }
                    },
                    child: const Text('Create'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createLink() async {
    Future.delayed(const Duration(seconds: 5), () {
      print("Data saved");
      // Save data to firebase
    });
  }
}
