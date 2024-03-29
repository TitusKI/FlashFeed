import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_provider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  const Refresh({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await bloc?.clear();
        await bloc?.fetchTopIds();
      },
    );
  }
}
