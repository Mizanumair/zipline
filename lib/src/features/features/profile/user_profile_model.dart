/// name : "Test User 3"
/// email : "user3@gmail.com"
/// mobile_number : "1234567891"
/// company_name : "XYZ TEST 3"
/// address : "PV"
/// gender : "Female"
/// profile_picture_url : "https://courier.hnktrecruitment.in/profile/1691128651086-979547176.jpeg"

class UserProfileModel {
  UserProfileModel({
    String? name,
    String? email,
    String? mobileNumber,
    String? companyName,
    String? address,
    String? gender,
    String? profilePictureUrl,
  }) {
    _name = name;
    _email = email;
    _mobileNumber = mobileNumber;
    _companyName = companyName;
    _address = address;
    _gender = gender;
    _profilePictureUrl = profilePictureUrl;
  }

  UserProfileModel.fromJson(dynamic json) {
    _name = json['name'];
    _email = json['email'];
    _mobileNumber = json['mobile_number'];
    _companyName = json['company_name'];
    _address = json['address'];
    _gender = json['gender'];
    _profilePictureUrl = json['profile_picture_url'];
  }

  String? _name;
  String? _email;
  String? _mobileNumber;
  String? _companyName;
  String? _address;
  String? _gender;
  String? _profilePictureUrl;

  UserProfileModel copyWith({
    String? name,
    String? email,
    String? mobileNumber,
    String? companyName,
    String? address,
    String? gender,
    String? profilePictureUrl,
  }) =>
      UserProfileModel(
        name: name ?? _name,
        email: email ?? _email,
        mobileNumber: mobileNumber ?? _mobileNumber,
        companyName: companyName ?? _companyName,
        address: address ?? _address,
        gender: gender ?? _gender,
        profilePictureUrl: profilePictureUrl ?? _profilePictureUrl,
      );

  String? get name => _name;

  String? get email => _email;

  String? get mobileNumber => _mobileNumber;

  String? get companyName => _companyName;

  String? get address => _address;

  String? get gender => _gender;

  String? get profilePictureUrl => _profilePictureUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['email'] = _email;
    map['mobile_number'] = _mobileNumber;
    map['company_name'] = _companyName;
    map['address'] = _address;
    map['gender'] = _gender;
    map['profile_picture_url'] = _profilePictureUrl;
    return map;
  }
}
