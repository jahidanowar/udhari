import 'package:get/get.dart';
import 'package:udhari/models/Link.dart';

class LinkController extends GetxController {
  final RxList<Link> links = <Link>[].obs;

  // Getters
  List<Link> get allLinks => links;

  // Methods
  void addLink(Link link) {
    links.add(link);
  }

  void removeLink(Link link) {
    links.remove(link);
  }
}
