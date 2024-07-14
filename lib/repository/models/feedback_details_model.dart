class FeedbackDetails {
  String? sId;
  Student? student;
  List<Response>? response;

  FeedbackDetails({this.sId, this.student, this.response});

  FeedbackDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(new Response.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.student != null) {
      data['student'] = this.student!.toJson();
    }
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Student {
  String? sId;
  String? name;
  String? studentNumber;
  String? branch;
  String? gender;
  String? residency;
  String? email;
  String? phone;

  Student(
      {this.sId,
      this.name,
      this.studentNumber,
      this.branch,
      this.gender,
      this.residency,
      this.email,
      this.phone});

  Student.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    studentNumber = json['studentNumber'];
    branch = json['branch'];
    gender = json['gender'];
    residency = json['residency'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['studentNumber'] = this.studentNumber;
    data['branch'] = this.branch;
    data['gender'] = this.gender;
    data['residency'] = this.residency;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Response {
  String? question;
  String? ans;

  Response({this.question, this.ans});

  Response.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    ans = json['ans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['ans'] = this.ans;
    return data;
  }
}
