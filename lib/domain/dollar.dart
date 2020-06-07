class Dollar {
 final int id;
 final double buy;
 final double sell;
 final DateTime date;


  const Dollar({this.id, this.buy, this.sell, this.date});

Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'buy': buy,
      'sell': sell,
      'date' : date.toIso8601String()
    };
  }
}
