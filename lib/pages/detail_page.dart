import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/comment_model.dart';

import '../locator.dart';
import '../services/api_service.dart';

class DetailPage extends StatelessWidget {
  const DetailPage(this.id, {super.key});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: _body(),
      ),
    );
  }

  FutureBuilder _body() {
    // final apiService =
    //     ApiService(Dio(BaseOptions(contentType: 'application/json')));

    final apiService = locator<ApiService>();

    return FutureBuilder(
      // future: apiService.getSpecificPost(1),
      future: apiService.getPostComments(int.parse(id!)),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<CommentModel> posts = [...snapshot.data];
          return _buildBody(posts);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildBody(List<CommentModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.abc),
          title: Text(posts[index].name ?? 'Pippo'),
          subtitle: Text(posts[index].body ?? 'Pluto'),
          // onTap: () => context.go('/detail_page/${posts[index].id}'),
        );
      },
    );
  }
}
