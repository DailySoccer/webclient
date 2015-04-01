/**
 * DO NOT EDIT. This is code generated via pkg/intl/generate_localized.dart
 * This is a library that provides messages for a es locale. All the
 * messages from the main program should be duplicated here with the same
 * function name.
 */

library messages_es;
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

class MessageLookup extends MessageLookupByLibrary {

  get localeName => 'es';
  static addFunds() => "AÑADIR FONDOS";

  static addFundsDescriptionTip1() => "Para jugar a Epic Eleven con dinero real, necesitas añadir fondos a tu cuenta.";

  static addFundsDescriptionTip2() => "No te preocupes, prodrás retirarlo cuando quieras de forma gratuita.";

  static addFundsMinimumAllowed(amount) => "Por favor, deposita al menos ${amount} para continuar";

  static addFundsUsingPaypal() => "Puedes usar tu tarjeta de crédito o tu cuenta de PayPal";

  static contestDescriptionActive(tournamentTypeName, numEntries, maxEntries, salaryCap) => "${tournamentTypeName} : ${numEntries} de ${maxEntries} contendientes - Tope salarial: ${salaryCap}";

  static contestDescriptionLiveOrHistory(tournamentTypeName, salaryCap) => "${tournamentTypeName} - Tope salarial: ${salaryCap}";

  static lobbyPlay() => "JUGAR";

  static menuAddFuns() => "Añadir Fondos";

  static menuHowItWorks() => "Cómo Jugar";

  static menuLobby() => "Buscar Torneos";

  static menuLogout() => "Salir";

  static menuMyAccount() => "Mi Cuenta";

  static menuMyContests() => "Mis Torneos";

  static menuTransactionHistory() => "Historial de Transacciones";

  static needHelp() => "¿Necesitas ayuda?";


  final messages = const {
    "addFunds" : addFunds,
    "addFundsDescriptionTip1" : addFundsDescriptionTip1,
    "addFundsDescriptionTip2" : addFundsDescriptionTip2,
    "addFundsMinimumAllowed" : addFundsMinimumAllowed,
    "addFundsUsingPaypal" : addFundsUsingPaypal,
    "contestDescriptionActive" : contestDescriptionActive,
    "contestDescriptionLiveOrHistory" : contestDescriptionLiveOrHistory,
    "lobbyPlay" : lobbyPlay,
    "menuAddFuns" : menuAddFuns,
    "menuHowItWorks" : menuHowItWorks,
    "menuLobby" : menuLobby,
    "menuLogout" : menuLogout,
    "menuMyAccount" : menuMyAccount,
    "menuMyContests" : menuMyContests,
    "menuTransactionHistory" : menuTransactionHistory,
    "needHelp" : needHelp
  };
}