library translate_formatter;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/translate_config.dart';

// i18n
@Pipe(name: 'translate')
class TranslateFormatter {
  call(localizableStringToFilter, [group]) {
    return config.translate(localizableStringToFilter, group: group);
  }
}

