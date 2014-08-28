library webclient_test;

import 'package:unittest/unittest.dart';
import 'package:unittest/html_enhanced_config.dart';
// import 'package:unittest/html_config.dart';

part 'unit/profile_service_test.dart';
part 'unit/contest_service_test.dart';

main() {

  // Cazamos la excepcion que salta cuando estamos corriendo bajo karma al intentar reconfigurar (puesto
  // que karma configura primero)
  try {
    //useHtmlConfiguration();
    useHtmlEnhancedConfiguration();
  } catch (exc) {}

  // Podemos filtrar ciertos grupos
  // filterTests("valid");

  // 27/08/2014: Comentamos el codigo real de test puesto que se habia quedado obsoleto y no lo mantenemos,
  //             dejamos unicamente el esqueleto del framework de testeo.
  testContestService();
  testProfileService();

}
