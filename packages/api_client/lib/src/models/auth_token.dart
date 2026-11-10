/// The session's credentials, held by `AuthSession`.
///
/// Independent of any backend's response shape: map the sign-in response to
/// an [AuthToken] before calling `AuthSession.start`.
class const AuthToken({
  required final String accessToken,
  required final String refreshToken,
}) {
  new fromJson(Map<String, dynamic> json)
    : this(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
      );

  Map<String, dynamic> toJson() => {
    'accessToken': accessToken,
    'refreshToken': refreshToken,
  };

  @override
  bool operator ==(Object other) =>
      other is AuthToken &&
      other.accessToken == accessToken &&
      other.refreshToken == refreshToken;

  @override
  int get hashCode => Object.hash(accessToken, refreshToken);

  @override
  String toString() => 'AuthToken(accessToken: ***, refreshToken: ***)';
}
