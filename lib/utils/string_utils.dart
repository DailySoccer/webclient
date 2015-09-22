library string_utils;
import 'package:intl/intl.dart';
import 'package:webclient/utils/translate_config.dart';

class StringUtils {

  static NumberFormat decimalFormat = new NumberFormat("0.#", "es_ES");
  static NumberFormat twoDecimalsFormat = new NumberFormat("###,###,###.00", "en_US");
  static NumberFormat thousandsFormat = new NumberFormat.decimalPattern("en_US");


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

  static String parseFantasyPoints(int fantasyPoints) => decimalFormat.format(fantasyPoints * 0.1);

  static String parseSalary(int salaryCap) => thousandsFormat.format(salaryCap);

  static String parsePrize(num money) => ((money*100)%100 == 0)? thousandsFormat.format(money): twoDecimalsFormat.format(money);

  static Map<String, String> stringToMap(String params) {
    Map<String, String> result = {};

    List<String> pairs = params.split(",");

    for (int i=0; i<pairs.length; i++) {
        String pair = pairs[i];
        List<String> keyValue = pair.split(":");
        result.addAll({keyValue[0]:keyValue[1]});
    }
    return result;
  }

  static String Translate(String key, String theGroup) {
    return config.translate(key, group:theGroup);
  }

}