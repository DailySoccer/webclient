library tab_bar_comp;

import 'package:angular/angular.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/utils/host_server.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/template_service.dart';
import 'package:webclient/services/catalog_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'dart:html';

@Component(
    selector: 'tab-bar',
    templateUrl: 'packages/webclient/components/navigation/tab_bar_comp.html',
    useShadowDom: false
)
class TabBarComp {

  TabBarComp(this._router, this._loadingService, this._view, this._rootElement, this._dateTimeService, this._profileService, this._templateService, this._catalogService);

  String getLocalizedText(key, [Map substitutions]) {
    return StringUtils.translate(key, "TabBar", substitutions);
  }

  Element _rootElement;
  View _view;
  Router _router;
  
  DateTimeService _dateTimeService;
  LoadingService _loadingService;

  TemplateService _templateService;
  CatalogService _catalogService;
  ProfileService _profileService;
}
