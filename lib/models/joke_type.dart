class JokeType {
  String type;

  JokeType({required this.type});

  factory JokeType.fromJson(Map<String, dynamic> json) {
    return JokeType(
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
    };
  }
}