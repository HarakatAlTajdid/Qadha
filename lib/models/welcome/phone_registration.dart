class PhoneRegistration {
  final String phoneCode;
  final String phoneNumber;
  final String password;
  String? verificationId;

  PhoneRegistration(this.phoneCode, this.phoneNumber, this.password);

  String fakeMail() {
    return "$phoneCode${int.parse(phoneNumber.replaceAll(" ", ""))}@gmail.com";
  }

  String prettyPhone() {
    return "+$phoneCode ${int.parse(phoneNumber)}";
  }
}