import 'dart:async';
import 'dart:convert';
import 'package:infotech/Model/DataModel.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient}) : super(PostInitial());

  //  @override
  // Stream<Transition<PostEvent, PostState>> transformEvents(
  //   Stream<PostEvent> events,
  //   TransitionFunction<PostEvent, PostState> transitionFn,
  // ) {
  //   return super.transformEvents(
  //     events.debounceTime(const Duration(milliseconds: 500)),
  //     transitionFn,
  //   );
  // }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    final currentState = state;
    if (event is PostFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostInitial) {
          final posts = await _fetchPosts(0, 20);
          yield PostSuccess(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostSuccess) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostSuccess(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostFailure();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostSuccess && state.hasReachedMax;

  Future<List<DataModel>> _fetchPosts(int startIndex, int limit) async {
    final response = await httpClient
        .get('https://5ea57aa32d86f00016b45dc2.mockapi.io/api/v1/users');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return DataModel.fromJson(rawPost);
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
