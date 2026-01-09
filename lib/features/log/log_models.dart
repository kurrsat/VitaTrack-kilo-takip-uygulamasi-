enum RecordType { weight, water, food, activity, photo }

enum RecordFilter { all, weight, water, food, activity, photo }

extension RecordFilterX on RecordFilter {
  RecordType? toRecordType() {
    switch (this) {
      case RecordFilter.weight:
        return RecordType.weight;
      case RecordFilter.water:
        return RecordType.water;
      case RecordFilter.food:
        return RecordType.food;
      case RecordFilter.activity:
        return RecordType.activity;
      case RecordFilter.photo:
        return RecordType.photo;
      case RecordFilter.all:
        return null;
    }
  }
}

class LogRecord {
  LogRecord({
    required this.id,
    required this.uid,
    required this.type,
    required this.dateTime,
    required this.entry,
  });

  final String id;
  final String uid;
  final RecordType type;
  final DateTime dateTime;
  final Object entry;
}
