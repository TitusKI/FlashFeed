import "package:flutter/material.dart";
import "comment_bloc.dart";
export "comment_bloc.dart";

class CommentProvider extends InheritedWidget {
   
  final CommentsBloc bloc;
  CommentProvider({Key ?key, required Widget child})
      : bloc = CommentsBloc(),
        super(key: key, child: child);
      @override
  bool updateShouldNotify(oldWidget) => true;
  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType(aspect: CommentProvider)
            as CommentProvider)
        .bloc;
  }
}
