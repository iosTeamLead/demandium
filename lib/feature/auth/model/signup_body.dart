class SignUpBody {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;
  String? referCode;

  SignUpBody({this.fName, this.lName, this.phone, this.email='', this.password, this.confirmPassword,this.referCode});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    fName = json['first_name'];
    lName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirm_password'];
    referCode = json['referral_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = fName;
    data['last_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    if(referCode!=null){
      data['referral_code'] = referCode;
    }
    return data;
  }
}
