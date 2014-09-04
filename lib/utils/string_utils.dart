class StringUtils {

  static String normalize(String txt) {
    String from = "ÃÀÁÄÂÈÉËÊÌÍÏÎÒÓÖÔÙÚÜÛãàáäâèéëêìíïîòóöôùúüûÑñÇç";
    String to   = "AAAAAEEEEIIIIOOOOUUUUaaaaaeeeeiiiioooouuuunncc";
    Map map = {};

    for (int i = 0; i < from.length; i++ ) {
      map[  from[i] ] = to[i];
    }

    String ret = '';
    String c = '';
    for( int i = 0, j = txt.length; i < j; i++ ) {
      c = txt[i];
      ret += map.containsKey(c) ? map[c] : c;
    }

    return ret;
  }
}