class TimeEntry {
  int? issueId;
  String? hours;
  int? userId;
  String? comments;

  TimeEntry({
    required this.issueId,
    required this.hours,
    required this.userId,
    required this.comments,
  });

  TimeEntry.fromJson(Map<String, dynamic> json) {
    issueId = json['issue_id'];
    hours = json['hours'];
    userId = json['user_id'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['issue_id'] = issueId;
    data['hours'] = hours;
    data['user_id'] = userId;
    data['comments'] = comments;
    return data;
  }
}
