class Child {


  final String name;
  final String? id;
  final String buildNumber;
  final String status;

  Child({ this.id,required this.buildNumber, required this.name, required this.status});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id:json['_id'],
      buildNumber: json['BuildId'],
      name: json['Name'],
      status: json['Status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'buildNumber': buildNumber,
    'name': name,
    'status': status,
  };
}
