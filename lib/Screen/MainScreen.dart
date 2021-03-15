import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotech/Screen/FIrstScreen.dart';
import 'package:infotech/Service/connectivity_service.dart';
import 'package:infotech/bloc/post_bloc.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => PostBloc(
            httpClient: http.Client(),
            connectivityService: ConnectivityService()),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostOffline) {
              return Center(
                child: Text("Offline"),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: state is PostLoadInProgress
                        ? null
                        : () {
                            BlocProvider.of<PostBloc>(context)
                                .add(PostFetched());
                          },
                    child: state is PostLoadInProgress
                        ? CircularProgressIndicator()
                        : Text("Fetch Data"),
                  ),
                  ElevatedButton(
                    onPressed: state is PostSuccess
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => FirstScreen(
                                          allData: state.posts,
                                        )));
                          }
                        : null,
                    child: Text("Show Data"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
