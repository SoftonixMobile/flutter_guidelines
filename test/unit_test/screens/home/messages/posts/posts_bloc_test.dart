import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_guidelines/blocs/index.dart';
import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/repositories/index.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  /// Default state instance to avoid code repeating
  const defaultState = NetworkListState<Post>(data: []);

  const testItem = Post(id: 1, name: 'Post 1');

  final mockPostRepository = MockPostsRepository();

  late PostsBloc postsBloc;

  group('Post bloc tests', () {
    /// Creating bloc forEach test
    setUp(() {
      postsBloc = PostsBloc(postsRepository: mockPostRepository);
    });

    /// Test for success loading items,
    /// GIVEN initial state
    /// WHEN call .load()
    /// THEN states should be loading and success
    blocTest(
      'Success state with data after load',
      setUp: () {
        when(mockPostRepository.getPosts).thenAnswer((_) async => [testItem]);
      },
      build: () => postsBloc,
      act: (bloc) {
        bloc.load();
      },
      expect: () => [
        defaultState.copyWithLoading(),
        defaultState.copyWithSuccess([testItem]),
      ],
    );

    /// Test for success adding new testItem,
    /// GIVEN state without testItems
    /// WHEN call .addItem()
    /// THEN state should contain new testItem
    blocTest(
      'Adding new element',
      build: () => postsBloc,
      seed: () => defaultState.copyWithSuccess([]),
      act: (bloc) {
        bloc.addItem(testItem);
      },
      expect: () => [
        defaultState.copyWithSuccess([testItem]),
      ],
    );

    /// Test for success removing existing testItem,
    /// GIVEN state with testItem
    /// WHEN call .deleteItem()
    /// THEN state shouldn't contain removed testItem
    blocTest(
      'Removing  existing element ',
      build: () => postsBloc,
      seed: () => defaultState.copyWithSuccess([testItem]),
      act: (bloc) {
        bloc.removeItem(testItem);
      },
      expect: () => [defaultState.copyWithSuccess([])],
    );

    /// Test for removing NOT existing testItem,
    /// GIVEN state without testItem
    /// WHEN call .deleteItem()
    /// THEN state shouldn't emit cause nothing changes
    blocTest(
      'Removing NOT existing element ',
      build: () => postsBloc,
      seed: () => defaultState.copyWithSuccess([]),
      act: (bloc) {
        bloc.removeItem(testItem);
      },
      expect: () => [],
    );
  });
}
