import "package:rxdart/rxdart.dart";
import "../models/item_models.dart";
import '../resources/repository.dart';
import "dart:async";

class CommentsBloc {
  final _commentFetcher = PublishSubject<int>();
  final _commentOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();

  // Stream
  Stream<Map<int, Future<ItemModel?>>> get itemWithComments =>
      _commentOutput.stream;

  // Sink
  Function(int) get fetchItemWithComments => _commentFetcher.sink.add;

  dispose(){
    _commentFetcher.close();
    _commentOutput.close();
  }
}
