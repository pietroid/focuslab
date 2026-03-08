class Event {
  const Event({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
  });

  final String id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;

  Event copyWith({
    String? id,
    String? name,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return Event(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
