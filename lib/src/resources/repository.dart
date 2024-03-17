import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_models.dart';

class Repository {
  List<Source> sources = <Source>[
    dpapi,
    NewsApiProvider(),
  ];
  List<Cache> caches = <Cache>[
    dpapi,
  ];

  Future<List<int>>? fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<ItemModel?> fetchItems(int id) async {
    ItemModel? item;
    var source;
    for (source in sources) {
      item = await dpapi.fetchItems(id);
      if (item != null) {
        // If item is found, add it to caches and break the loop
        break;
      } else {
        item = await sources[1].fetchItems(id);
      }
    }
    if (item != null) {
      for (var cache in caches) {
        if (cache != source){
               cache.addItems(item);
        }
       
      }
    }
    return item;

    // var item = await dbapi.fetchItems(id);// we declare it as the var keyword
    // // since we have to overwrite when we need this.
    // if (item != null) {
    //   return item;
    // }
    // item = await api.fetchItems(id);
    // return item;
  }
}

abstract class Source {
  Future<List<int>>? fetchTopIds();
  Future<ItemModel?> fetchItems(int id);
}

abstract class Cache {
  Future<int> addItems(ItemModel item);
}
