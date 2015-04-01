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

  get nickname => Intl.message("Nickname", name: 'nickname');
  get email => Intl.message("Email", name: 'email');
  get password => Intl.message("Password", name: 'password');
  get repeatPassword => Intl.message("Repeat password", name: 'repeatPassword');
  get users => Intl.message("Users", name: 'users');
  get opponent => Intl.message("Opponent", name: 'opponent');

  get signupTitle => Intl.message("SIGN UP", name: 'signupTitle');
  get signupDescription => Intl.message("Don't you have an EPIC ELEVEN account yet?<br>Fill out this form.", name: 'signupDescription');
  nicknameHelper(minLength, maxLength) => Intl.message("Your nickname must be $minLength to $maxLength characters long.", name: 'nicknameHelper', args: [minLength, maxLength]);
  get nicknameInvalid => Intl.message("Invalid Nickname.", name: 'nicknameInvalid');
  get emailHelper => Intl.message("Email:", name: 'emailHelper');
  get emailInvalid => Intl.message("Invalid Email.", name: 'emailInvalid');
  passwordHelper(minLength) => Intl.message("Password: Should be at least $minLength characters. (Type it twice).", name: 'passwordHelper', args: [minLength]);
  get passwordInvalid => Intl.message("Invalid Password.", name: 'passwordInvalid');
  get signupNow => Intl.message("SIGN UP", name: 'signupNow');
  get cancelSignup => Intl.message("CANCEL", name: 'cancelSignup');
  get haveAnAccount => Intl.message("Already have an account?", name: 'haveAnAccount');
  get loginHere => Intl.message("log in here!", name: 'loginHere');

  get loginTitle => Intl.message("LOG IN", name: 'loginTitle');
  get loginDescription => Intl.message("Enter your email and password.", name: 'loginDescription');
  get forgotYourPassword => Intl.message("Forgot your password?", name: 'forgotYourPassword');
  get cancelLogin => Intl.message("CANCEL", name: 'cancelLogin');
  get loginNow => Intl.message("CONTINUE", name: 'loginNow');
  get doNotHaveAnAccount => Intl.message("Don't have an account?", name: 'doNotHaveAnAccount');
  get signupHere => Intl.message("Sign Up here!", name: 'signupHere');
  get loginError => Intl.message("LOGIN ERROR: The nickname or password is not correct.", name: 'loginError');

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

  get editTheLineup => Intl.message("EDIT THE LINEUP", name: 'editTheLineup');
  get userPositionTitle => Intl.message("POS", name: 'userPositionTitle');
  get userScoreTitle => Intl.message("POINTS", name: 'userScoreTitle');
  get userRemainingTime => Intl.message("REMAINING TIME", name: 'userRemainingTime');
  get closeFantasyTeam => Intl.message("CLOSE", name: 'closeFantasyTeam');
  get playerOwned => Intl.message("OWNED", name: 'playerOwned');

  get fieldPosGoalkeeper => Intl.message("GOALKEEPER", name: 'fieldPosGoalkeeper');
  get fieldPosDefense => Intl.message("DEFENDER", name: 'fieldPosDefense');
  get fieldPosMiddle => Intl.message("MIDFIELDER", name: 'fieldPosMiddle');
  get fieldPosForward => Intl.message("FORWARD", name: 'fieldPosForward');

  get fieldPosGoalkeeperShort => Intl.message("GK", name: 'fieldPosGoalkeeperShort');
  get fieldPosDefenseShort => Intl.message("DEF", name: 'fieldPosDefenseShort');
  get fieldPosMiddleShort => Intl.message("MID", name: 'fieldPosMiddleShort');
  get fieldPosForwardShort => Intl.message("FWD", name: 'fieldPosForwardShort');

  get addPlayerToFantasyTeam => Intl.message("ADD", name: 'addPlayerToFantasyTeam');
  get youHaveSpentTheSalaryCap => Intl.message("You've spent the salary cap", name: 'youHaveSpentTheSalaryCap');
  get choosePlayersThatFitTheBudget => Intl.message("Please choose players that fit the budget.", name: 'choosePlayersThatFitTheBudget');
  youHavePlayersOfSameTeam(maxPlayers) => Intl.message("Ups! It looks like you already have $maxPlayers players of the same team", name: 'youHavePlayersOfSameTeam', args: [maxPlayers]);
  get chooseAnotherPlayer => Intl.message("Please, choose another player...", name: 'chooseAnotherPlayer');

  get haveCompletedYourLineup => Intl.message("WELL DONE! YOU HAVE SUCCESSFULLY COMPLETED YOUR LINEUP", name: 'haveCompletedYourLineup');
  get haveEditedYourLineup => Intl.message("WELL DONE! YOU HAVE SUCCESSFULLY EDITED YOUR LINEUP", name: 'haveEditedYourLineup');
  get havePutYouInEquivalentContest => Intl.message("THE CONTEST WAS FULL, SO WE HAVE PUT YOU IN THIS EQUIVALENT ONE", name: 'havePutYouInEquivalentContest');
  get rememberThatYouCanEdit => Intl.message("Remember that you can edit your lineup as many times as you want before the contest starts", name: 'rememberThatYouCanEdit');
  get cancelContestEntry => Intl.message("CANCEL PARTICIPATION", name: 'cancelContestEntry');
  get backToContests => Intl.message("BACK TO CONTESTS", name: 'backToContests');

  get addFunds => Intl.message("ADD FUNDS", name: 'addFunds');
  get addFundsDescriptionTip1 => Intl.message("In order to play Epic Eleven with real money, you need to add funds to your account.", name: 'addFundsDescriptionTip1');
  get addFundsDescriptionTip2 => Intl.message("Don't worry, you can withdraw your money whenever you want for free.", name: 'addFundsDescriptionTip2');
  get addFundsUsingPaypal => Intl.message("You can add funds using PayPal account. The money will be transferred to Fantasy Sports Games S.L.", name: 'addFundsUsingPaypal');

  addFundsMinimumAllowed(amount) => Intl.message("Minimum allowed is $amount", args: [amount], name: 'addFundsMinimumAllowed');

  get needHelp => Intl.message("Need help?", name: 'needHelp');

  static Localization _instance = new Localization();
}