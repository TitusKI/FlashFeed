import 'package:flutter/material.dart';
import 'package:news/src/bloc/stories_provider.dart';
import 'Screens/news_list.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StoriesProvider( 
        key: null,
        child: const MaterialApp(
          title: "News",
          home: NewsList(),
        ) ,
    );

  }
}
