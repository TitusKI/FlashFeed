import 'dart:async';
import '../resources/repository.dart';
import '../models/item_models.dart';
import 'dart:core';
import 'package:rxdart/rxdart.dart';

class StoriesBloc {
  final _repository = Repository();
  // within rxdart world PublishSubject == StreamController
  final _topids = PublishSubject<List<int>>();
final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();
final _itemsFetcher = PublishSubject<int>();


  // Observables == Stream
  Stream<List<int>> get topids => _topids.stream;
  Stream<Map<int, Future<ItemModel?>>> get items => _itemsOutput.stream;

Function(int) get fetchItem => _itemsFetcher.sink.add;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topids.sink.add(ids!);
  }
  StoriesBloc(){
   _itemsFetcher.stream.transform(_itemTransformer()).pipe(_itemsOutput);
  }

_itemTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>(
        (Map<int, Future<ItemModel?>> cache, int id, index) {
          print(index);
      cache[id] = _repository.fetchItems(id);
      return cache;
    }, <int, Future<ItemModel?>>{});
  }

  dispose() {
    _topids.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }
}
