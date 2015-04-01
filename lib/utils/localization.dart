library localization;

import 'package:intl/intl.dart';
import 'package:webclient/localization/messages_all.dart';

class Localization {
  static Localization get instance => _instance;

  Localization () {
    Intl.defaultLocale = 'es_ES';
    initializeMessages("es");
    //Intl.defaultLocale = "en_ES";
  }

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