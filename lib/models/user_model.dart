class UserModel {
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? accessCode;
  final String? role;

  const UserModel({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.accessCode,
    this.role,
  });

  toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'accessCode': accessCode,
      'role': role,
    };
  }
}
