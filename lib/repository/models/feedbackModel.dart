class feedbackModel {
  String? question;
  String? quesId;

  feedbackModel({this.question, this.quesId});

  feedbackModel.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    quesId = json['quesId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['quesId'] = this.quesId;
    return data;
  }
}
