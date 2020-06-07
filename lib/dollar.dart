class Dollar {
  int id;
  double buy;
  double sell;
  DateTime date;

  Dollar({this.id, this.buy, this.sell, this.date});

Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buy': buy,
      'sell': sell,
      'date' : date.toIso8601String()
    };
  }
}
