library loading_service;

import 'package:angular/angular.dart';

@Injectable()
class LoadingService {
  static bool loading = false;

  LoadingService();
}