import 'package:flutter/material.dart';

import 'stories_bloc.dart';
export 'stories_bloc.dart';

class StoriesProvider extends InheritedWidget {
  late final StoriesBloc bloc;

  StoriesProvider({super.key, required Widget child})
      : bloc = StoriesBloc(),
        super(child: child);

  @override
  bool updateShouldNotify(_) => true;
  static StoriesBloc? of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>(
            aspect: StoriesProvider))
        ?.bloc;
  }
}
