import 'package:flutter/material.dart';
import '../bloc/stories_provider.dart';
import '../widgets/news_list_tile.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);
    bloc?.fetchTopIds();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Top News'),
      ),
      body: buildList(bloc!),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
        stream: bloc.topids,
        builder: (context, AsyncSnapshot<List<int>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, int index) {
                // return Text("${snapshot.data![index]}");
                bloc.fetchItem(snapshot.data![index]);
                return NewsListTile(
                  itemId: snapshot.data![index],
                );
              });
        });
  }
}
