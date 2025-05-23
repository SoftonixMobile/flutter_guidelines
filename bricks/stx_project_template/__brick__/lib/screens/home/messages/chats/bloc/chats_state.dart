part of 'chats_bloc.dart';

@freezed
sealed class ChatsState with _$ChatsState {
  const factory ChatsState({
    @Default(NetworkStatus.loading) NetworkStatus status,
    @Default([]) List<Chat> chats,
    String? errorMessage,
  }) = _ChatsState;

  factory ChatsState.success(List<Chat> chats) => ChatsState(
    status: NetworkStatus.success,
    chats: chats,
  );
}
