import 'package:flutter/material.dart';
import 'package:flutter_elastic_list_view/flutter_elastic_list_view.dart';

class ElasticListViewExample extends StatelessWidget {
  const ElasticListViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElasticListView'),
      ),
      body: ElasticListView(
        children: List.generate(
          50,
          (index) {
            return Container(
              height: 100,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red[(index % 9 + 1) * 100],
                borderRadius: BorderRadius.circular(16),
              ),
            );
          },
        ),
      ),
    );
  }
}
