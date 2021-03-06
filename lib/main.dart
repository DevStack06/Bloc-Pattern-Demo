import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotech/Screen/FIrstScreen.dart';
import 'package:infotech/Screen/MainScreen.dart';

import 'bloc/post_bloc.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinite Scroll',
      home: MainScreen(),
    );
  }
}

// body: BlocProvider(
//         create: (context) =>
//             PostBloc(httpClient: http.Client())..add(PostFetched()),
//         child: MainScreen(),
//       ),
