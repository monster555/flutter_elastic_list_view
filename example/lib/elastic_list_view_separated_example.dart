import 'package:flutter/material.dart';
import 'package:flutter_elastic_list_view/flutter_elastic_list_view.dart';

class ElasticListViewSeparatedExample extends StatelessWidget {
  const ElasticListViewSeparatedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ElasticListView.separated'),
      ),
      body: ElasticListView.separated(
        itemCount: 50,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[(index % 9 + 1) * 100],
              borderRadius: BorderRadius.circular(16),
            ),
          );
        },
      ),
    );
  }
}
