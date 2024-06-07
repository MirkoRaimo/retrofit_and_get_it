import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/detail_page.dart';
import 'package:flutter_application_1/services/api_service.dart';
import 'package:go_router/go_router.dart';

import 'package:logger/logger.dart';

import 'locator.dart';
import 'models/post_model.dart';

final logger = Logger();

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(initialLocation: '/', routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MyWidget(),
          routes: [
            GoRoute(
              path: 'detail_page/:id',
              builder: (context, state) => DetailPage(
                state.pathParameters['id'],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Plugin example app'),
      ),
      body: _body(),
    );
  }

  FutureBuilder _body() {
    // final apiService =
    //     ApiService(Dio(BaseOptions(contentType: 'application/json')));

    final apiService = locator<ApiService>();

    return FutureBuilder(
      // future: apiService.getSpecificPost(1),
      future: apiService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.done) {
          final List<PostModel> posts = [...snapshot.data];
          return _buildBody(posts);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildBody(List<PostModel> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.abc),
          title: Text(posts[index].title ?? 'Pippo'),
          subtitle: Text(posts[index].body ?? 'Pluto'),
          onTap: () => context.go('/detail_page/${posts[index].id}'),
        );
      },
    );
  }
}




// FutureBuilder<ResponseData> _buildBody(BuildContext context) {
//   final client = ApiService(Dio(BaseOptions(contentType: "application/json")));
//   return FutureBuilder<ResponseData>(
//     future: client.getUsers(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.done) {

//         final ResponseData posts = snapshot.data;
//         return _buildListView(context, posts);
//       } else {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//     },
//   );
// }