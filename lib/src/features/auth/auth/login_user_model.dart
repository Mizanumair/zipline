/// message : "Login successful"
/// user_id : 23
/// name : "Test User 10"
/// profile_photo_url : "https://courier.hnktrecruitment.in/profile/1691485304072-178864766.png"

class LoginUserModel {
  LoginUserModel({
    String? message,
    int? userId,
    String? name,
    String? profilePhotoUrl,
  }) {
    _message = message;
    _userId = userId;
    _name = name;
    _profilePhotoUrl = profilePhotoUrl;
  }

  LoginUserModel.fromJson(dynamic json) {
    _message = json['message'];
    _userId = json['user_id'];
    _name = json['name'];
    _profilePhotoUrl = json['profile_photo_url'];
  }

  String? _message;
  int? _userId;
  String? _name;
  String? _profilePhotoUrl;

  LoginUserModel copyWith({
    String? message,
    int? userId,
    String? name,
    String? profilePhotoUrl,
  }) =>
      LoginUserModel(
        message: message ?? _message,
        userId: userId ?? _userId,
        name: name ?? _name,
        profilePhotoUrl: profilePhotoUrl ?? _profilePhotoUrl,
      );

  String? get message => _message;

  int? get userId => _userId;

  String? get name => _name;

  String? get profilePhotoUrl => _profilePhotoUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['user_id'] = _userId;
    map['name'] = _name;
    map['profile_photo_url'] = _profilePhotoUrl;
    return map;
  }
}
