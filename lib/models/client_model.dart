class UserClient {
  String accessToken = '';
  int? accessTokenExpire;
  String? refreshToken = '';
  String? username = '';
  String? userId = '';
  List<dynamic>? profileImage = [];
  String? email = '';
  bool? isDarkMode = true;
  bool? isVerified = false;

  UserClient();

  UserClient.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    accessTokenExpire = json['accessToken_expire'];
    username = json['username'];
    userId = json['userId'];
    profileImage = json['profileImages'];
    email = json['email'];
    isVerified = json['isVerified'];
  }

  void setAccessToken(String accessToken) => this.accessToken = accessToken;

  void updateUser(String accessToken, int accessTokenExpire, String refreshToken) {
    this.accessToken = accessToken;
    this.accessTokenExpire = accessTokenExpire;
    this.refreshToken = refreshToken;
  }

  void setRefreshToken(String refreshToken) => this.refreshToken = refreshToken;

  UserClient.fromStorage(
      this.refreshToken,
      this.username,
      this.userId,
      this.profileImage,
      this.email,
      this.isDarkMode,
      this.isVerified) : accessToken = '';
}
