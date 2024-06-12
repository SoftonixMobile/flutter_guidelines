typedef DynamicMap = Map<String, dynamic>;
typedef StringMap = Map<String, String>;

enum AuthStatus {
  initial,
  unauthenticated,
  authenticated;

  bool get isInitial => this == initial;
  bool get isUnauthenticated => this == unauthenticated;
  bool get isAuthenticated => this == authenticated;
}
