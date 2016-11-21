library xs_not_available_screen_comp;

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/host_server.dart';

@Component(
    selector: 'xs-not-available-screen',
    templateUrl: 'xs_not_available_screen_comp.html'
)
class XsNotAvailableScreenComp {

  XsNotAvailableScreenComp();

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "xsNotAvailable", substitutions);
  }
  
  bool get show => HostServer.isProd;
}
