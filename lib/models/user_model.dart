class UserModel {
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? accessCode;

  const UserModel({
    required this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.accessCode,
  });

  toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'accessCode': accessCode,
    };
  }
}
