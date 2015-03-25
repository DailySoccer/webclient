library money;
import 'package:webclient/utils/string_utils.dart';

class Money {
  static final USD = "USD"; // United States Dollar
  static final EUR = "EUR"; // Euro Member Countries
  static final JPY = "JPY"; // Japan Yen
  static final GBP = "GBP"; // United Kingdom Pound
  static final CHF = "CHF"; // Switzerland Franc
  static final AUD = "AUD"; // Australia Dollar
  static final CAD = "CAD"; // Canada Dollar
  static final String CURRENCY_UNIT_DEFAULT = USD;

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

  // TODO: Existen contests con entryFee en Euros, mostramos únicamente Dollars...
  String toString() => "\$${StringUtils.parsePrize(amount)}";
  // String toString() => "${currentSymbolMap[currencyUnit]}${StringUtils.parsePrize(amount)}";

  int toInt() => amount.toInt();

  Money.fromValue(num value) {
    currencyUnit = CURRENCY_UNIT_DEFAULT;
    amount = (value*100+0.5).toInt()/100.0;
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