import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_guidelines/models/index.dart';
import 'package:flutter_guidelines/screens/home/messages/chats/bloc/chats_bloc.dart';
import 'package:flutter_guidelines/screens/home/messages/chats/chats_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:patrol/patrol.dart';

@GenerateNiceMocks([MockSpec<ChatsBloc>()])
import 'chats_screen.mocks.dart';

void main() {
  patrolWidgetTest(
    'Check successfully displaying list',
    ($) async {
      /// Mock bloc interactions.
      final bloc = MockChatsBloc();
      final state = ChatsState.success(
        List.generate(
          100,
          (index) => Chat(id: index, name: 'Chat $index'),
        ),
      );

      when(bloc.state).thenAnswer((_) => state);

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: BlocProvider<ChatsBloc>(
            create: (_) => bloc,
            child: const Material(child: ChatsScreen()),
          ),
        ),
      );

      await $.pump();

      /// Test if needed elements are present.
      final listOfChats = $(SliverList);
      final chats = $(Text);

      expect(listOfChats, findsOneWidget);
      expect(chats, findsAtLeastNWidgets(10));
    },
  );

  patrolWidgetTest(
    'Check loading',
    ($) async {
      /// Mock bloc interactions.
      final bloc = MockChatsBloc();
      const state = ChatsState();

      when(bloc.state).thenAnswer((_) => state);

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: BlocProvider<ChatsBloc>(
            create: (_) => bloc,
            child: const ChatsScreen(),
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
      final bloc = MockChatsBloc();
      const errorMsg = 'Error msg';
      const state = ChatsState(
        status: NetworkStatus.failure,
        errorMessage: errorMsg,
      );

      when(bloc.state).thenAnswer((realInvocation) => state);

      /// Get the widget.
      await $.pumpWidget(
        MaterialApp(
          home: BlocProvider<ChatsBloc>(
            create: (_) => bloc,
            child: const ChatsScreen(),
          ),
        ),
      );

      await $.pump();

      /// Test if needed elements are present.
      final error = $(errorMsg);

      expect(error, findsOneWidget);
    },
  );
}
