library money;

class Money {
  String currencyUnit;
  num amount;

  // TODO: Faltaría expresar el dinero de forma adecuada (con €, $...) y que el html no asumiera que está en euros €
  String toString() => "${amount}"; // "${currencyUnit} ${amount}";

  int toInt() => amount.toInt();

  Money.fromValue(num value) {
    currencyUnit = "EUR";
    amount = value;
  }

  Money.fromJsonObject(String jodaMoney) {
    currencyUnit = jodaMoney.substring(0, 3);
    amount = num.parse(jodaMoney.substring(4).trim());
  }

  Money.zero() {
    currencyUnit = "EUR";
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

  bool isGreaterThan(int other) {

  }

  int compareTo(Money other) {
    return amount.compareTo(other.amount);
  }
}