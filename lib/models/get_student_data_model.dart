class GetStudentDataModel {
  String? name;
  String? studentNumber;
  String? branch;
  String? gender;
  String? residency;
  String? email;
  String? phone;
  bool? isVerified;
  int? iV;

  GetStudentDataModel(
      {this.name,
      this.studentNumber,
      this.branch,
      this.gender,
      this.residency,
      this.email,
      this.phone,
      this.isVerified,
      this.iV});

  GetStudentDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    studentNumber = json['studentNumber'];
    branch = json['branch'];
    gender = json['gender'];
    residency = json['residency'];
    email = json['email'];
    phone = json['phone'];
    isVerified = json['isVerified'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['studentNumber'] = this.studentNumber;
    data['branch'] = this.branch;
    data['gender'] = this.gender;
    data['residency'] = this.residency;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['isVerified'] = this.isVerified;
    data['__v'] = this.iV;
    return data;
  }
}
