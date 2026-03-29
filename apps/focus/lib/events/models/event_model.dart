class Event {
  const Event({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    this.isFixed = false,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json['id'] as String,
        name: json['name'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: DateTime.parse(json['endDate'] as String),
        isFixed: json['isFixed'] as bool? ?? false,
      );

  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final bool isFixed;

  Event copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
    bool? isFixed,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isFixed: isFixed ?? this.isFixed,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
        'isFixed': isFixed,
      };
}
