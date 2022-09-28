import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhari/controllers/link_controller.dart';
import 'package:udhari/models/Link.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkView extends StatelessWidget {
  LinkView({super.key});

  Link? link = Get.arguments;

  static const String routeName = '/link/view';
  final LinkController controller = Get.find<LinkController>();

  @override
  Widget build(BuildContext context) {
    print(link);
    return Scaffold(
      appBar: AppBar(
        title: const Text('link insights'),
      ),
      body: SafeArea(
        child: link == null
            ? const CircularProgressIndicator()
            : Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'link',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          link!.source,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'clicks',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          link!.clicks.toString(),
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            elevation: 0,
                            minWidth: double.infinity,
                            color: Theme.of(context).primaryColor,
                            onPressed: () => {
                              controller.copyLink(link!.destination),
                            },
                            child: const Text(
                              'copy link',
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: MaterialButton(
                            elevation: 0,
                            minWidth: double.infinity,
                            color: Theme.of(context).primaryColor,
                            onPressed: () => {
                              launchUrl(Uri.parse(link!.destination)),
                            },
                            child: const Text(
                              'visit',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
      ),
    );
  }
}
