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

  get filters => Intl.message("FILTERS", name: 'filters');
  get filterSortBy => Intl.message("Sort by", name: 'filterSortBy');
  get filterSearchContest => Intl.message("Search contest", name: 'filterSearchContest');
  get filterCompetition => Intl.message("COMPETITION", name: 'filterCompetition');
  get filterContests => Intl.message("CONTESTS", name: 'filterContests');
  get filterSalaryCap => Intl.message("SALARY CAP", name: 'filterSalaryCap');
  get filterEntryFee => Intl.message("ENTRY FEE", name: 'filterEntryFee');
  get filterMin => Intl.message("MIN", name: 'filterMin');
  get filterMax => Intl.message("MAX", name: 'filterMax');
  get filterClear => Intl.message("CLEAR FILTERS", name: 'filterClear');
  get filterAccept => Intl.message("ACCEPT", name: 'filterAccept');
  get filterSpanishLaLiga => Intl.message("Spanish La Liga", name: 'filterSpanishLaLiga');
  get filterPremierLeague => Intl.message("Premier League", name: 'filterPremierLeague');
  get filterChampionsLeague => Intl.message("Champions League", name: 'filterChampionsLeague');
  get filterFree => Intl.message("Free", name: 'filterFree');
  get filterHeadToHead => Intl.message("Head to Head", name: 'filterHeadToHead');
  get filterLeague => Intl.message("League", name: 'filterLeague');
  get filterFiftyFifty => Intl.message("50 / 50", name: 'filterFiftyFifty');
  get filterTierBeginner => Intl.message("Beginner", name: 'filterTierBeginner');
  get filterTierStandard => Intl.message("Standard", name: 'filterTierStandard');
  get filterTierExpert => Intl.message("Expert", name: 'filterTierExpert');
  get filterOrderByName => Intl.message("Name", name: 'filterOrderByName');
  get filterOrderByEntryFee => Intl.message("Entry Fee", name: 'filterOrderByEntryFee');
  get filterOrderByStartDate => Intl.message("Start Date", name: 'filterOrderByStartDate');
  get filterAvailableContests => Intl.message("Available contests", name: 'filterAvailableContests');

  get nextContest => Intl.message("NEXT CONTEST", name: 'nextContest');

  get contestSalaryCap => Intl.message("Salary cap", name: 'contestSalaryCap');
  get contestEntryFee => Intl.message("ENTRY FEE", name: 'contestEntryFee');
  get contestPosition => Intl.message("OF", name: 'contestPosition');
  get contestPrize => Intl.message("PRIZE", name: 'contestPrize');
  get contestPoints => Intl.message("POINTS", name: 'contestPoints');

  get contestFinished => Intl.message("FINISHED", name: 'contestFinished');
  get contestStartedOn => Intl.message("STARTED ON", name: 'contestStartedOn');
  get contestStartsOn => Intl.message("STARTS ON", name: 'contestStartsOn');
  get contestSoon => Intl.message("SOON", name: 'contestSoon');
  get contestWillStartIn => Intl.message("THE CONTEST WILL START IN", name: 'contestWillStartIn');
  get contestRemaining => Intl.message("REMAINING", name: 'contestRemaining');

  contestNumOfContenders(numEntries, maxEntries) => Intl.message("$numEntries of $maxEntries contenders", name: 'contestNumOfContenders', args: [numEntries, maxEntries]);

  get tournamentFree => Intl.message("Free", name: 'tournamentFree');
  get tournamentHeadToHead => Intl.message("Head to Head", name: 'tournamentHeadToHead');
  get tournamentLeague => Intl.message("League", name: 'tournamentLeague');
  get tournamentFiftyFifty => Intl.message("50/50", name: 'tournamentFiftyFifty');

  get lobbyPlay => Intl.message("PLAY", name: 'lobbyPlay');

  get lineupSaved => Intl.message("Lineup saved", name: 'lineupSaved');
  get yourLineup => Intl.message("Your Lineup", name: 'yourLineup');
  get contestInfo => Intl.message("Contest Info", name: 'contestInfo');
  get cancelPlayerSelection => Intl.message("CANCEL", name: 'cancelPlayerSelection');
  get remainingSalary => Intl.message("REMAINING SALARY", name: 'remainingSalary');
  get deleteFantasyTeam => Intl.message("REMOVE ALL", name: 'deleteFantasyTeam');
  get createFantasyTeam => Intl.message("CONTINUE", name: 'createFantasyTeam');
  get rememberThatYouCanEditYourTeam => Intl.message("Remember that you can edit your team as many times as you want until the contest starts", name: 'rememberThatYouCanEditYourTeam');

  get addFunds => Intl.message("ADD FUNDS", name: 'addFunds');
  get addFundsDescriptionTip1 => Intl.message("In order to play Epic Eleven with real money, you need to add funds to your account.", name: 'addFundsDescriptionTip1');
  get addFundsDescriptionTip2 => Intl.message("Don't worry, you can withdraw your money whenever you want for free.", name: 'addFundsDescriptionTip2');
  get addFundsUsingPaypal => Intl.message("You can add funds using PayPal account. The money will be transferred to Fantasy Sports Games S.L.", name: 'addFundsUsingPaypal');

  addFundsMinimumAllowed(amount) => Intl.message("Minimum allowed is $amount", args: [amount], name: 'addFundsMinimumAllowed');

  get needHelp => Intl.message("Need help?", name: 'needHelp');

  static Localization _instance = new Localization();
}