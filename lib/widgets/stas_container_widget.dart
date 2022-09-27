import 'package:flutter/material.dart';

class StatsContainerWidget extends StatelessWidget {
  const StatsContainerWidget({
    required this.totalLinks,
    required this.totalClicks,
    Key? key,
  }) : super(key: key);

  final int totalLinks;
  final int totalClicks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      totalLinks.toString(),
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Text('links'),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      '13',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    const Text('clicks'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
