library money;

class Money {
  static final USD = "USD"; // United States Dollar
  static final EUR = "EUR"; // Euro Member Countries
  static final JPY = "JPY"; // Japan Yen
  static final GBP = "GBP"; // United Kingdom Pound
  static final CHF = "CHF"; // Switzerland Franc
  static final AUD = "AUD"; // Australia Dollar
  static final CAD = "CAD"; // Canada Dollar
  static final String CURRENCY_UNIT_DEFAULT = EUR;

  // http://www.xe.com/symbols.php
  static Map<String, String> currentSymbolMap = {
    USD : "\$",
    JPY : "¥",
    EUR : "€",
    GBP : "£",
    CHF : "CHF",
    AUD : "\$",
    CAD : "\$"
  };

  String currencyUnit;
  num amount;

  String toString() => "${amount}${currentSymbolMap[currencyUnit]}";

  int toInt() => amount.toInt();

  Money.fromValue(num value) {
    currencyUnit = CURRENCY_UNIT_DEFAULT;
    amount = value;
  }

  Money.fromJsonObject(String jodaMoney) {
    currencyUnit = jodaMoney.substring(0, 3);
    amount = num.parse(jodaMoney.substring(4).trim());
  }

  Money.zero() {
    currencyUnit = CURRENCY_UNIT_DEFAULT;
    amount = 0;
  }

  Money plus(Money money) {
    return new Money.fromValue(amount + money.amount);
  }

  Money minus(Money money) {
    return new Money.fromValue(amount - money.amount);
  }

  bool operator >=(Money other) {
    return amount >= other.amount;
  }

  bool operator <=(Money other) {
    return amount <= other.amount;
  }

  int compareTo(Money other) {
    return amount.compareTo(other.amount);
  }
}