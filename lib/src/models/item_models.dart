import 'dart:convert';

class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String? title;
  final int descendants;
  ItemModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] ?? false,
        type = parsedJson['type'] ?? '',
        time = parsedJson['time'] ?? 0,
        text = parsedJson['text'] ?? '',
        dead = parsedJson['dead'] ?? false,
        parent = parsedJson['parent'] ?? 0,
        kids = parsedJson['kids'] ?? [],
        url = parsedJson['url'] ?? '',
        score = parsedJson['score'] ?? 0,
        title = parsedJson['title'] ?? "Title not avaliable" ,
        descendants = parsedJson['descendants'] ?? 0;

  ItemModel.fromDb(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'],
        deleted = parsedJson['deleted'] == 1,
        type = parsedJson['type'],
        time = parsedJson['time'],
        text = parsedJson['text'],
        dead = parsedJson['dead'] == 1,
        parent = parsedJson['parent'],
        kids = jsonDecode(parsedJson['kids']),
        url = parsedJson['url'],
        score = parsedJson['score'],
        title = parsedJson['title'],
        descendants = parsedJson['descendants'];
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'deleted': deleted ? 1 : 0,
      'type': type,
      'text': text,
      'dead': dead ? 1 : 0,
      'parent': parent,
      'kids': jsonEncode(kids),
      'url': url,
      'score': score,
      'title': title,
      'descendants': descendants
    };
  }
}
