import 'package:flutter/material.dart';
import 'package:flutter_guidelines/app.dart';
import 'package:flutter_guidelines/app_initialization.dart';
import 'package:flutter_guidelines/localization/index.dart';
import 'package:flutter_guidelines/screens/home/messages/chats/pages/chat_details/chat_details_screen.dart';
import 'package:flutter_guidelines/services/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:patrol/patrol.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Messages screen test', () {
    patrolWidgetTest(
        'Open messages screen, check how we are navigated to the chats',
        ($) async {
      // Configure the app.
      await initializeDotenv();
      await initializeLogger();
      await initializeLocalization();
      initializeCrashlytics();
      initializeBlocObserver();
      configureAuthDependencies();

      // Load auth screen.
      await $.pumpWidget(
        EasyLocalization(
          path: CodegenLoader.path,
          supportedLocales: CodegenLoader.supportedLocales,
          fallbackLocale: CodegenLoader.supportedLocales.last,
          assetLoader: const CodegenLoader(),
          child: SoftonixApp(),
        ),
      );

      // Wait couple of seconds till splash is removed.
      await $.pumpAndSettle();

      // We land on Home screen, dashboard tab.
      expect($('Dashboard Screen'), findsOneWidget);

      // Open Messages tab.
      final msgTab = $('Messages');
      await msgTab.tap();
      await $.pump();

      // Check that we have loaded chats. At least 10, because we do not show
      // all that are generated.
      final chatsList = $(SliverList);
      final chatsItems = $(Text);
      expect(chatsList, findsOneWidget);
      expect(chatsItems, findsAtLeastNWidgets(10));

      // Switch tab to posts.
      final postsTab = $('Posts');
      await postsTab.tap();
      await $.pump();

      // Check that we have posts.
      final postsList = $(SliverList);
      final postsItems = $(Text);
      expect(postsList, findsOneWidget);
      expect(postsItems, findsAtLeastNWidgets(10));

      // Return to previous page.
      final chatsTab = $('Chats');
      await chatsTab.tap();
      await $.pump();

      // Open the single chat page.
      await $('Chat 0').tap();
      await $.pump();
      final chat = $(ChatDetailsScreen);
      expect(chat, findsOneWidget);
    });
  });
}
