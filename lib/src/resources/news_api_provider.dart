import 'package:http/http.dart' show Client;
import '../models/item_models.dart';
import 'dart:convert';
import 'repository.dart';
const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider implements Source{
  Client client = Client();
  @override
  Future<List<int>> fetchTopIds() async {
    var response = await client.get(Uri.parse('$_root/topstories.json'));
   
    final ids = json.decode(response.body);

    return ids.cast<int>();
  }

  @override
  Future<ItemModel?> fetchItems(int id) async {
    final response = await client.get(Uri.parse('$_root/item/$id.json'));
    response.toString();
    // print(response.body.toString());
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
