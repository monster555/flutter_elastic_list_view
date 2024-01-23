import 'package:example/elastic_list_view_builder_example.dart';
import 'package:example/elastic_list_view_example.dart';
import 'package:example/elastic_list_view_separated_example.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter ElasticListView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ElasticListView Demo'),
        ),
        body: Builder(
          builder: (context) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: const [
                  _CustomButton(
                    text: 'ElasticListView',
                    page: ElasticListViewExample(),
                  ),
                  _CustomButton(
                    text: 'ElasticListView.separated',
                    page: ElasticListViewSeparatedExample(),
                  ),
                  _CustomButton(
                    text: 'ElasticListView.builder',
                    page: ElasticListViewBuilderExample(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    required this.text,
    required this.page,
  });

  final String text;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },
        child: Text(text),
      ),
    );
  }
}
