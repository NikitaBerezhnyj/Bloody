class Donation {
  final int? id;
  final DateTime date;
  final String type;
  final String feeling;
  final String notes;

  Donation({
    this.id,
    required this.date,
    required this.type,
    this.feeling = '',
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type,
      'feeling': feeling,
      'notes': notes,
    };
  }

  factory Donation.fromMap(Map<String, dynamic> map) {
    return Donation(
      id: map['id'] as int?,
      date: DateTime.parse(map['date']),
      type: map['type'],
      feeling: map['feeling'] ?? '',
      notes: map['notes'] ?? '',
    );
  }
}
