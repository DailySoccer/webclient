/**
 * DO NOT EDIT. This is code generated via pkg/intl/generate_localized.dart
 * This is a library that provides messages for a messages locale. All the
 * messages from the main program should be duplicated here with the same
 * function name.
 */

library messages_messages;
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

class MessageLookup extends MessageLookupByLibrary {

  get localeName => 'messages';
  static addFunds() => "ADD FUNDS";

  static addFundsDescriptionTip1() => "In order to play Epic Eleven with real money, you need to add funds to your account.";

  static addFundsDescriptionTip2() => "Don\'t worry, you can withdraw your money whenever you want for free.";

  static addFundsMinimumAllowed(amount) => "Minimum allowed is ${amount}";

  static addFundsUsingPaypal() => "You can add funds using PayPal account. The money will be transferred to Fantasy Sports Games S.L.";

  static contestDescriptionActive(tournamentTypeName, numEntries, maxEntries, salaryCap) => "${tournamentTypeName}: ${numEntries} of ${maxEntries} contenders - Salary cap: ${salaryCap}";

  static contestDescriptionLiveOrHistory(tournamentTypeName, salaryCap) => "${tournamentTypeName} - Salary cap: ${salaryCap}";

  static lobbyPlay() => "PLAY";

  static needHelp() => "Need help?";


  final messages = const {
    "addFunds" : addFunds,
    "addFundsDescriptionTip1" : addFundsDescriptionTip1,
    "addFundsDescriptionTip2" : addFundsDescriptionTip2,
    "addFundsMinimumAllowed" : addFundsMinimumAllowed,
    "addFundsUsingPaypal" : addFundsUsingPaypal,
    "contestDescriptionActive" : contestDescriptionActive,
    "contestDescriptionLiveOrHistory" : contestDescriptionLiveOrHistory,
    "lobbyPlay" : lobbyPlay,
    "needHelp" : needHelp
  };
}