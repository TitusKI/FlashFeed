
import 'package:flutter/material.dart';

class DetailNews extends StatelessWidget {
  final int itemId;

  const DetailNews({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
        ),
        body: Text('$itemId'),
    );
  }
}