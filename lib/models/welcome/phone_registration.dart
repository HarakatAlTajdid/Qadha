class PhoneRegistration {
  final String phoneCode;
  final String phoneNumber;
  final String password;
  String? verificationId;

  PhoneRegistration(this.phoneCode, this.phoneNumber, this.password);

  String fakeMail() {
    if (phoneNumber.trim().isEmpty) {
      return "nothing@gmail.com";
    }
    
    return "$phoneCode${int.parse(phoneNumber.replaceAll(" ", ""))}@gmail.com";
  }

  String prettyPhone() {
    return "+$phoneCode ${int.parse(phoneNumber)}";
  }
}