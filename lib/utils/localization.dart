library localization;

import 'dart:async';
import 'package:intl/intl.dart';
import 'package:webclient/localization/messages_all.dart';

class Localization {
  static Localization get instance => _instance;

  static Future init () {
    Intl.defaultLocale = 'es_ES'; //"en_EN";
    return initializeMessages("es");
  }

  Localization ();

  get menuLobby => Intl.message("LOBBY", name: 'menuLobby');
  get menuMyContests => Intl.message("MY CONTESTS", name: 'menuMyContests');
  get menuHowItWorks => Intl.message("HOW IT WORKS", name: 'menuHowItWorks');
  get menuMyAccount => Intl.message("My Account", name: 'menuMyAccount');
  get menuAddFuns => Intl.message("Add Funds", name: 'menuAddFuns');
  get menuTransactionHistory => Intl.message("Transaction History", name: 'menuTransactionHistory');
  get menuLogout => Intl.message("Logout", name: 'menuLogout');

  get footerHelp => Intl.message("HELP", name: 'footerHelp');
  get footerLegal => Intl.message("LEGAL", name: 'footerLegal');
  get footerTermsOfUse => Intl.message("TERMS OF USE", name: 'footerTermsOfUse');
  get footerPrivacyPolicy => Intl.message("PRIVACY POLICY", name: 'footerPrivacyPolicy');
  get footerBlog => Intl.message("BLOG", name: 'footerBlog');

  contestDescriptionLiveOrHistory(tournamentTypeName, salaryCap) => Intl.message("$tournamentTypeName - Salary cap: $salaryCap",
                            name: 'contestDescriptionLiveOrHistory',
                            args: [tournamentTypeName, salaryCap]);
  contestDescriptionActive(tournamentTypeName, numEntries, maxEntries, salaryCap) => Intl.message("$tournamentTypeName: $numEntries of $maxEntries contenders - Salary cap: $salaryCap",
                            name: 'contestDescriptionActive', args: [tournamentTypeName, numEntries, maxEntries, salaryCap]);

  get lobbyPlay => Intl.message("PLAY", name: 'lobbyPlay');

  get addFunds => Intl.message("ADD FUNDS", name: 'addFunds');
  get addFundsDescriptionTip1 => Intl.message("In order to play Epic Eleven with real money, you need to add funds to your account.", name: 'addFundsDescriptionTip1');
  get addFundsDescriptionTip2 => Intl.message("Don't worry, you can withdraw your money whenever you want for free.", name: 'addFundsDescriptionTip2');
  get addFundsUsingPaypal => Intl.message("You can add funds using PayPal account. The money will be transferred to Fantasy Sports Games S.L.", name: 'addFundsUsingPaypal');

  addFundsMinimumAllowed(amount) => Intl.message("Minimum allowed is $amount", args: [amount], name: 'addFundsMinimumAllowed');

  get needHelp => Intl.message("Need help?", name: 'needHelp');

  static Localization _instance = new Localization();
}