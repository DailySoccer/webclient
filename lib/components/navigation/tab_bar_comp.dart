library tab_bar_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/host_server.dart';

@Component(
    selector: 'tab-bar',
    templateUrl: 'packages/webclient/components/navigation/tab_bar_comp.html',
    useShadowDom: false
)
class TabBarComp {

  NavigationBarComp();

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "TabBar", substitutions);
  }
  
}
