import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:udhari/models/Auth.dart';
import 'package:udhari/screens/link_create.dart';
import 'package:udhari/widgets/stas_container_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final AuthUser user =
        ModalRoute.of(context)!.settings.arguments as AuthUser;
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
            const StatsContainerWidget(),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(14.0),
                  itemCount: links.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(links[index]),
                        subtitle: const Text('clicks: 0'),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
