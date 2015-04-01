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

  static contestEntryFee() => "ENTRY FEE";

  static contestPoints() => "POINTS";

  static contestPosition() => "OF";

  static contestPrize() => "PRIZE";

  static footerBlog() => "BLOG";

  static footerHelp() => "HELP";

  static footerLegal() => "LEGAL";

  static footerPrivacyPolicy() => "PRIVACY POLICY";

  static footerTermsOfUse() => "TERMS OF USE";

  static lobbyPlay() => "PLAY";

  static menuAddFuns() => "Add Funds";

  static menuHowItWorks() => "HOW IT WORKS";

  static menuLobby() => "LOBBY";

  static menuLogout() => "Logout";

  static menuMyAccount() => "My Account";

  static menuMyContests() => "MY CONTESTS";

  static menuTransactionHistory() => "Transaction History";

  static needHelp() => "Need help?";

  static tournamentFiftyFifty() => "50/50";

  static tournamentFree() => "Free";

  static tournamentHeadToHead() => "Head to Head";

  static tournamentLeague() => "League";


  final messages = const {
    "addFunds" : addFunds,
    "addFundsDescriptionTip1" : addFundsDescriptionTip1,
    "addFundsDescriptionTip2" : addFundsDescriptionTip2,
    "addFundsMinimumAllowed" : addFundsMinimumAllowed,
    "addFundsUsingPaypal" : addFundsUsingPaypal,
    "contestDescriptionActive" : contestDescriptionActive,
    "contestDescriptionLiveOrHistory" : contestDescriptionLiveOrHistory,
    "contestEntryFee" : contestEntryFee,
    "contestPoints" : contestPoints,
    "contestPosition" : contestPosition,
    "contestPrize" : contestPrize,
    "footerBlog" : footerBlog,
    "footerHelp" : footerHelp,
    "footerLegal" : footerLegal,
    "footerPrivacyPolicy" : footerPrivacyPolicy,
    "footerTermsOfUse" : footerTermsOfUse,
    "lobbyPlay" : lobbyPlay,
    "menuAddFuns" : menuAddFuns,
    "menuHowItWorks" : menuHowItWorks,
    "menuLobby" : menuLobby,
    "menuLogout" : menuLogout,
    "menuMyAccount" : menuMyAccount,
    "menuMyContests" : menuMyContests,
    "menuTransactionHistory" : menuTransactionHistory,
    "needHelp" : needHelp,
    "tournamentFiftyFifty" : tournamentFiftyFifty,
    "tournamentFree" : tournamentFree,
    "tournamentHeadToHead" : tournamentHeadToHead,
    "tournamentLeague" : tournamentLeague
  };
}