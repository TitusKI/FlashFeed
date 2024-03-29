import 'package:flutter/material.dart';
import 'package:news/src/widgets/loading_container.dart';
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
          return const LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data?[itemId],
          builder: (context, AsyncSnapshot<ItemModel?> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return const LoadingContainer();
            }

            return buildtile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildtile(BuildContext context,ItemModel? item) {
    return Column(
      children: [
        ListTile(
          onTap: (){
             Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(
            item!.title ?? "",
            style: const TextStyle(fontSize: 25),
          ),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: [const Icon(Icons.comment), Text('${item.descendants}')],
          ),
        ),
        const Divider(height: 8.0),
      ],
    );
  }
}
