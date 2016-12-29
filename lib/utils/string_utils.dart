library string_utils;
import 'package:intl/intl.dart';
import 'package:webclient/utils/translate_config.dart';

class StringUtils {

  static NumberFormat decimalFormat = new NumberFormat("0.#", "es_ES");
  static NumberFormat twoDecimalsFormat = new NumberFormat("###,###,##0.00", "es_ES");
  static NumberFormat thousandsFormat = new NumberFormat.decimalPattern("es_ES");


  static String normalize(String txt) {
    String from = "ÃÀÁÄÂÈÉËÊÌÍÏÎÒÓÖÔÙÚÜÛãàáäâèéëêìíïîòóöôùúüûÑñÇç";
    String to   = "AAAAAEEEEIIIIOOOOUUUUaaaaaeeeeiiiioooouuuunncc";
    Map map = {};

    for (int i = 0; i < from.length; i++ ) {
      map[ from[i] ] = to[i];
    }

    String ret = '';
    String c = '';
    for( int i = 0, j = txt.length; i < j; i++ ) {
      c = txt[i];
      ret += map.containsKey(c) ? map[c] : c;
    }

    return ret.toLowerCase();
  }

  static bool isValidEmail(String email) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(email);
  }

  static String parseFantasyPoints(int fantasyPoints) => thousandsFormat.format(fantasyPoints);

  static String parseSalary(int salaryCap) => thousandsFormat.format(salaryCap);

  static String parsePrize(num money) => ((money*100)%100 == 0)? thousandsFormat.format(money): twoDecimalsFormat.format(money);

  static String parseTrueSkill(int trueSkill) => thousandsFormat.format(trueSkill);

  static Map<String, String> stringToMap(String params) {
    Map<String, String> result = {};

    List<String> pairs = params.split(",");

    for (int i=0; i<pairs.length; i++) {
        String pair = pairs[i];
        List<String> keyValue = pair.split(":");
        result.addAll({keyValue[0].trim():keyValue[1].trim()});
    }
    return result;
  }
/*
  static String translate(String key, String theGroup) {
    return config.translate(key, group:theGroup);
  }
*/
  static String translate(String key, String theGroup, [Map substitutions]) {
    String s = config.translate(key, group:theGroup);
    if (substitutions != null) {
      substitutions.forEach( (k,v) => s = s.replaceAll('@$k', '$v') );
    }
    return s;
  }

  static String getDatePattern(String pattern) {
      return config.translate(pattern, group:"date");
  }

  static String getLocale() {
    return config.translate("locale");
  }

  static String formatCurrency(String amount) {
    String currency = config.translate("currency");
    String value = "";

    if (currency == '\$') {
      return currency + amount;
    }

    return  value = amount + currency;
  }
}