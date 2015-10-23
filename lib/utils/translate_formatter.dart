library translate_formatter;

import 'package:angular/angular.dart';
import 'package:webclient/utils/translate_config.dart';

// i18n
@Formatter(name: 'translate')
class TranslateFormatter {
  call(localizableStringToFilter, [group]) {
    return config.translate(localizableStringToFilter, group: group);
  }
}

