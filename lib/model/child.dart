class Child {

  final String name;
  final String buildNumber;
  final String status;

  Child({ required this.buildNumber, required this.name, required this.status});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      buildNumber: json['buildNumber'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
    'buildNumber': buildNumber,
    'name': name,
    'status': status,
  };
}
