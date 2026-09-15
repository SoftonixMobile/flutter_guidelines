part of 'chats_bloc.dart';

@freezed
sealed class ChatsState with _$ChatsState {
  const factory({
    @Default(NetworkStatus.initial) NetworkStatus status,
    @Default([]) List<Chat> chats,
    String? errorMessage,
  }) = _ChatsState;

  factory success(List<Chat> chats) => ChatsState(
    status: .success,
    chats: chats,
  );
}
