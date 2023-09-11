import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/screens/home/messages/posts/posts_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:patrol/patrol.dart';

@GenerateNiceMocks([MockSpec<PostsBloc>()])
import 'posts_screen.mocks.dart';

void main() {
  patrolWidgetTest(
    'Check successfully displaying list',
    ($) async {
      /// Mock bloc interactions.
      final bloc = MockPostsBloc();
      final state = NetworkListState<Post>(
        status: NetworkStatus.success,
        data: List.generate(
          100,
          (index) => Post(id: index, name: 'Post $index'),
        ),
      );

      when(bloc.state).thenAnswer((_) => state);

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: BlocProvider<PostsBloc>(
            create: (_) => bloc,
            child: const Material(child: PostsScreen()),
          ),
        ),
      );

      await $.pump();

      /// Test if needed elements are present.
      final listOfPosts = $(SliverList);
      final posts = $(Text);

      expect(listOfPosts, findsOneWidget);
      expect(posts, findsAtLeastNWidgets(10));
    },
  );

  patrolWidgetTest(
    'Check loading',
    ($) async {
      /// Mock bloc interactions.
      final bloc = MockPostsBloc();
      const state = NetworkListState<Post>(
        status: NetworkStatus.loading,
        data: [],
      );

      when(bloc.state).thenAnswer((_) => state);

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: BlocProvider<PostsBloc>(
            create: (_) => bloc,
            child: const PostsScreen(),
          ),
        ),
      );

      await $.pump();

      /// Test if needed elements are present.
      final loader = $(CircularProgressIndicator);

      expect(loader, findsOneWidget);
    },
  );

  patrolWidgetTest(
    'Check error',
    ($) async {
      /// Mock bloc interactions.
      final bloc = MockPostsBloc();
      const state = NetworkListState<Post>(
        status: NetworkStatus.failure,
        data: [],
      );

      when(bloc.state).thenAnswer((_) => state);

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: BlocProvider<PostsBloc>(
            create: (_) => bloc,
            child: const PostsScreen(),
          ),
        ),
      );

      await $.pump();

      /// Test if needed elements are present.
      final error = $(Text);
      final errorText = $('Something went wrong');

      expect(error, findsOneWidget);
      expect(errorText, findsOneWidget);
    },
  );
}
