import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:udhari/controllers/link_controller.dart';
import 'package:udhari/models/Link.dart';
import 'package:udhari/screens/link_create.dart';
import 'package:udhari/widgets/stas_container_widget.dart';

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
    _fetchLinks();

    super.initState();
  }

  _fetchLinks() async {
    final List<String> links = [
      'https://flutter.dev',
      'https://flutter.dev',
      'https://flutter.dev',
      'https://flutter.dev',
      'https://flutter.dev',
      'https://flutter.dev',
      'https://flutter.dev',
      'https://flutter.dev',
      'https://flutter.dev',
      'https://flutter.dev',
    ];

    for (final String link in links) {
      controller.addLink(Link(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        source: link,
        destination: 'Flutter',
        clicks: '0',
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
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
                totalClicks: controller.allLinks.length,
                totalLinks: controller.allLinks.length,
              ),
            ),
            Expanded(
                child: Obx(
              () => ListView.builder(
                itemCount: controller.allLinks.length,
                itemBuilder: (BuildContext context, int index) {
                  final Link link = controller.allLinks[index];
                  return ListTile(
                    title: Text(link.source),
                    subtitle: Text(link.destination),
                    trailing: Text(link.clicks),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
