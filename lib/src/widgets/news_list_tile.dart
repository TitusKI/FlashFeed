import 'package:flutter/material.dart';
import '../models/item_models.dart';
import '../bloc/stories_provider.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  const NewsListTile({Key? key, required this.itemId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc?.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text("Stream Still Loading");
        }
      //  final itemFuture = snapshot.data?[itemId];
      //   if (itemFuture == null){
      //     return const Text('Item not found');
      //   }
        return FutureBuilder(
          future: snapshot.data?[itemId],
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            // if (itemSnapshot.connectionState == ConnectionState.waiting) {
            //   return const Text("Loading...");
            // }


            if (!itemSnapshot.hasData) {
              return Text(" Still loading item $itemId");
            }

            return  Text(itemSnapshot.data!.title ?? "");
          },
        );
      },
    );
  }
}
