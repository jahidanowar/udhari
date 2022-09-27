import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhari/controllers/link_controller.dart';
import 'package:udhari/models/Link.dart';
import 'package:udhari/screens/link_create.dart';
import 'package:udhari/widgets/stas_container_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LinkController controller = Get.put(LinkController());

  @override
  void initState() {
    controller.fetchLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('dashboard'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(LinkCreate.routeName),
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Stats
            Obx(
              () => StatsContainerWidget(
                totalClicks: controller.totalClicks,
                totalLinks: controller.totalLinks,
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.allLinks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Link link = controller.allLinks[index];
                    return Dismissible(
                      key: Key(index.toString()),
                      background: const Card(
                        elevation: 0,
                        color: Colors.green,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Icon(
                              Icons.open_in_new,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      secondaryBackground: const Card(
                        color: Colors.red,
                        elevation: 0,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          launchUrl(Uri.parse(link.destination));
                          return false;
                        }
                        if (direction == DismissDirection.endToStart) {
                          controller.deleteLink(link);
                          return true;
                        }
                      },
                      child: ListTile(
                        title: Text(link.source),
                        subtitle: Text(link.destination),
                        trailing: Text(link.clicks.toString()),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
