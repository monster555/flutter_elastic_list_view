import 'package:flutter/material.dart';
import 'package:flutter_elastic_list_view/elastic_list_view.dart';

class ElasticListViewBuilderExample extends StatefulWidget {
  const ElasticListViewBuilderExample({super.key});

  @override
  State<ElasticListViewBuilderExample> createState() =>
      _ElasticListViewBuilderExampleState();
}

class _ElasticListViewBuilderExampleState
    extends State<ElasticListViewBuilderExample> {
  late final ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElasticListView.builder'),
      ),
      body: ElasticListView.builder(
        controller: controller,
        elasticityFactor: 8,
        itemCount: 50,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[(index % 9 + 1) * 100],
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}
