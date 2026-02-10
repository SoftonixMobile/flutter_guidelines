typedef DynamicMap = Map<String, dynamic>;
typedef StringMap = Map<String, String>;

enum AuthStatus {
  initial,
  unauthenticated,
  authenticated
  ;

  bool get isAuthenticated => this == authenticated;
}
