class MyIssues {
  List<RedmineIssues>? issues;

  MyIssues({this.issues});

  MyIssues.fromJson(Map<String, dynamic> json) {
    if (json['issues'] != null) {
      issues = <RedmineIssues>[];
      json['issues'].forEach((v) {
        issues!.add(RedmineIssues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (issues != null) {
      data['issues'] = issues!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class RedmineIssues {
  int? id;
  Project? project;
  Project? tracker;
  Project? status;
  Project? priority;
  Project? author;
  Project? assignedTo;
  String? subject;
  String? description;
  String? startDate;
  String? dueDate;
  dynamic doneRatio;
  bool? isPrivate;
  dynamic estimatedHours;
  String? createdOn;
  String? updatedOn;
  dynamic closedOn;

  RedmineIssues(
      {this.id,
      this.project,
      this.tracker,
      this.status,
      this.priority,
      this.author,
      this.assignedTo,
      this.subject,
      this.description,
      this.startDate,
      this.dueDate,
      this.doneRatio,
      this.isPrivate,
      this.estimatedHours,
      this.createdOn,
      this.updatedOn,
      this.closedOn});

  RedmineIssues.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    tracker =
        json['tracker'] != null ? Project.fromJson(json['tracker']) : null;
    status = json['status'] != null ? Project.fromJson(json['status']) : null;
    priority =
        json['priority'] != null ? Project.fromJson(json['priority']) : null;
    author = json['author'] != null ? Project.fromJson(json['author']) : null;
    assignedTo = json['assigned_to'] != null
        ? Project.fromJson(json['assigned_to'])
        : null;
    subject = json['subject'];
    description = json['description'];
    startDate = json['start_date'];
    dueDate = json['due_date'];
    doneRatio = json['done_ratio'];
    isPrivate = json['is_private'];
    estimatedHours = json['estimated_hours'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    closedOn = json['closed_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (tracker != null) {
      data['tracker'] = tracker!.toJson();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (priority != null) {
      data['priority'] = priority!.toJson();
    }
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (assignedTo != null) {
      data['assigned_to'] = assignedTo!.toJson();
    }
    data['subject'] = subject;
    data['description'] = description;
    data['start_date'] = startDate;
    data['due_date'] = dueDate;
    data['done_ratio'] = doneRatio;
    data['is_private'] = isPrivate;
    data['estimated_hours'] = estimatedHours;
    data['created_on'] = createdOn;
    data['updated_on'] = updatedOn;
    data['closed_on'] = closedOn;
    return data;
  }
}

class Project {
  int? id;
  String? name;

  Project({this.id, this.name});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
