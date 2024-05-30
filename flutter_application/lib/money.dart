const String tableMoney = "money_table";

class MoneyFields {
  static final List<String> values = [];

  static const String columnId = "id";
  static const String columnIncome = "income";
  static const String columnExpense = "expense";
  static const String columnTarget = "target";
  static const String columnTime = "time";
  static const String columnTimeTarget = "time_target";
}

class Money {
  int? id;
  int? income;
  int? expense;
  int? target;
  String time;
  int? time_target;

  Money(
      {this.id,
      this.income,
      this.expense,
      this.target,
      required this.time,
      this.time_target});

  Map<String, dynamic> toMap() {
    return {
      MoneyFields.columnId: id,
      MoneyFields.columnIncome: income,
      MoneyFields.columnExpense: expense,
      MoneyFields.columnTarget: target,
      MoneyFields.columnTime: time,
      MoneyFields.columnTimeTarget: time_target,
    };
  }

  factory Money.fromMap(Map<String, dynamic> map) {
    return Money(
        id: map[MoneyFields.columnId],
        income: map[MoneyFields.columnIncome],
        expense: map[MoneyFields.columnExpense],
        target: map[MoneyFields.columnTarget],
        time: map[MoneyFields.columnTime],
        time_target: map[MoneyFields.columnTimeTarget]);
  }
}
