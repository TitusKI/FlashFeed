import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';

main() {
  test('fetchTopIds returns id', () async {
    final api = NewsApiProvider();

    // api.client doesn't fetch from the the hackerapi rather from the mockClient
    api.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    }); // mock client is like a fake client used to test the client is getting that new request from api

    final ids = await api.fetchTopIds();

    expect(ids, [1, 2, 3, 4]);
  });
  test('fetchItems returns an itemModel', () async {
    final api = NewsApiProvider();
    api.client =
        MockClient((request) async => Response(json.encode({'id': 123}), 200));
    final items = await api.fetchItems(866);
    expect(items.id, 123);
  });
}
