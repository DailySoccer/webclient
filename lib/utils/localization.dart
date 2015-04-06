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

  get betaVersion => Intl.message("EPIC ELEVEN: BETA VERSION", name: 'betaVersion');
  get sectionNotAvailable => Intl.message("SECTION NOT AVAILABLE", name: 'sectionNotAvailable');
  get thisIsABetaVersion => Intl.message("Sorry, this is a beta version of Epic Eleven.<br>"
      "We are working hard on all the features that Epic Eleven will include."
      "We will keep you updated."
      "<br><br>"
      "<b>Thank you</b>", name: 'thisIsABetaVersion');

  get dailyFantasyLeagues => Intl.message("DAILY FANTASY LEAGUES", name: 'dailyFantasyLeagues');
  get playWheneverYouWant => Intl.message("Play whenever you want, wherever your want. Win prizes with no season-long commitment.", name: 'playWheneverYouWant');
  get playNow => Intl.message("PLAY NOW", name: 'playNow');
  get competeWithYourFriends => Intl.message("Compete with your friends in La Liga, Premier and Champions", name: 'competeWithYourFriends');
  get createYourLineup => Intl.message("Create your lineup, on your computer, tablet or smartphone in seconds", name: 'createYourLineup');
  get immediateCashPayouts => Intl.message("Immediate cash payouts", name: 'immediateCashPayouts');
  get dailyFantasyLeaguesMobile => Intl.message("DAILY FANTASY <br> LEAGUES", name: 'dailyFantasyLeaguesMobile');
  get landingMobile1 => Intl.message("PLAY AS MANY CONTESTS AS YOU WANT", name: 'landingMobile1');
  get landingMobile2 => Intl.message("CREATE YOUR LINEUP IN SECONDS", name: 'landingMobile2');
  get landingMobile3 => Intl.message("AND WIN CASH", name: 'landingMobile3');

  get fullname => Intl.message("Full Name", name: 'fullname');
  get nickname => Intl.message("Nickname", name: 'nickname');
  get email => Intl.message("Email", name: 'email');
  get password => Intl.message("Password", name: 'password');
  get repeatPassword => Intl.message("Repeat password", name: 'repeatPassword');
  get users => Intl.message("Users", name: 'users');
  get opponent => Intl.message("Opponent", name: 'opponent');
  get editMyAccount => Intl.message("EDIT", name: 'editMyAccount');

  get editAccount => Intl.message("EDIT ACCOUNT", name: 'editAccount');
  get name => Intl.message("Name", name: 'name');
  get lastName => Intl.message("Last name", name: 'lastName');
  get passwordFillBothFieldsToUpdate => Intl.message("Password (Fill the both fields to update it)", name: 'passwordFillBothFieldsToUpdate');
  get saveEditAccount => Intl.message("SAVE", name: 'saveEditAccount');
  get cancelEditAccount => Intl.message("CANCEL", name: 'cancelEditAccount');

  get passwordsDontMatch => Intl.message("Passwords don't match.", name: 'passwordsDontMatch');

  get notifications => Intl.message("NOTIFICATIONS", name: 'notifications');
  get newsletterSpecialOffers => Intl.message("NEWSLETTER/SPECIAL OFFERS", name: 'newsletterSpecialOffers');
  get gameNotifications => Intl.message("GAME NOTIFICATIONS", name: 'gameNotifications');
  get ownTransferNotifications => Intl.message("OWN SOCCER PLAYER TRANSFER NOTIFICACIONS", name: 'ownTransferNotifications');

  get wallet => Intl.message("WALLET", name: 'wallet');
  get transactions => Intl.message("TRANSACCIONES", name: 'transactions');
  get actualBalance => Intl.message("Actual balance", name: 'actualBalance');
  get pendingBonus => Intl.message("Pending bonus", name: 'pendingBonus');

  get transactionHistory => Intl.message("TRANSACTION HISTORY", name: 'transactionHistory');
  get transactionDate => Intl.message("DATE", name: 'transactionDate');
  get transactionId => Intl.message("ID", name: 'transactionId');
  get transactionSubject => Intl.message("SUBJECT", name: 'transactionSubject');
  get transactionValue => Intl.message("VALUE", name: 'transactionValue');
  get transactionBalance => Intl.message("BALANCE", name: 'transactionBalance');

  get signupTitle => Intl.message("SIGN UP", name: 'signupTitle');
  get signupDescription => Intl.message("Don't you have an EPIC ELEVEN account yet?<br>Fill out this form.", name: 'signupDescription');
  nicknameHelper(minLength, maxLength) => Intl.message("Your nickname must be $minLength to $maxLength characters long.", name: 'nicknameHelper', args: [minLength, maxLength]);
  get nicknameInvalid => Intl.message("Invalid Nickname.", name: 'nicknameInvalid');
  get emailHelper => Intl.message("Email:", name: 'emailHelper');
  get emailInvalid => Intl.message("Invalid Email.", name: 'emailInvalid');
  get emailIsNotValid => Intl.message("Email is not valid.", name: 'emailIsNotValid');
  passwordHelper(minLength) => Intl.message("Password: Should be at least $minLength characters.", name: 'passwordHelper', args: [minLength]);
  get passwordTypeItTwice => Intl.message("(Type it twice).", name: 'passwordTypeItTwice');
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
  get contestDetail => Intl.message("DETAIL", name: 'contestDetail');

  contestNumOfContenders(numEntries, maxEntries) => Intl.message("$numEntries of $maxEntries contenders", name: 'contestNumOfContenders', args: [numEntries, maxEntries]);

  get matchesInThisContest => Intl.message("MATCHES IN THIS CONTEST", name: 'matchesInThisContest');
  get matchFinished => Intl.message("Finished", name: 'matchFinished');
  get matchFirstHalf => Intl.message("1st Half", name: 'matchFirstHalf');
  get matchSecondHalf => Intl.message("2nd Half", name: 'matchSecondHalf');

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
  get userNameTitle => Intl.message("PLAYER", name: 'userNameTitle');
  get userRemainingTimeTitle => Intl.message("R.T.", name: 'userRemainingTimeTitle');
  get userRemainingTime => Intl.message("REMAINING TIME", name: 'userRemainingTime');
  get userPrizesTitle => Intl.message("PRIZES", name: 'userPrizesTitle');
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

  get playerOrderPos => Intl.message("Pos.", name: 'playerOrderPos');
  get playerOrderName => Intl.message("Name", name: 'playerOrderName');
  get playerOrderDFP => Intl.message("DFP", name: 'playerOrderDFP');
  get playerOrderMatches => Intl.message("#Matches", name: 'playerOrderMatches');
  get playerOrderSalary => Intl.message("Salary", name: 'playerOrderSalary');

  get players => Intl.message("Players", name: 'players');
  get searchPlayer => Intl.message("Search player...", name: 'searchPlayer');
  get filterAll => Intl.message("ALL", name: 'filterAll');

  get contendersInThisContest => Intl.message("CONTENDERS IN THIS CONTEST", name: 'contendersInThisContest');
  get chooseAContender => Intl.message("Choose a contender to compare lineups", name: 'chooseAContender');

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

  get prizeFree => Intl.message("Free contest. No prizes", name: 'prizeFree');
  get prizeWinner => Intl.message("Winner takes all", name: 'prizeWinner');
  get prizeTop3 => Intl.message("First 3 get prizes", name: 'prizeTop3');
  get prizeTopThird => Intl.message("First # get prizes", name: 'prizeTopThird');
  get prizeFiftyFifty => Intl.message("First # get prizes", name: 'prizeFiftyFifty');

  get eventPassSuccessful => Intl.message("Successful Pass", name: 'eventPassSuccessful');
  get eventPassUnsuccessful => Intl.message("Unsuccessful Pass", name: 'eventPassUnsuccessful');
  get eventTakeOn => Intl.message("Take-on", name: 'eventTakeOn');
  get eventFoulReceived => Intl.message("Foul Received", name: 'eventFoulReceived');
  get eventTackle => Intl.message("Tackle", name: 'eventTackle');
  get eventInterception => Intl.message("Interception", name: 'eventInterception');
  get eventSaveGoalkeeper => Intl.message("Save", name: 'eventSaveGoalkeeper');
  get eventSavePlayer => Intl.message("Saved Shot", name: 'eventSavePlayer');
  get eventClaim => Intl.message("Anticipation", name: 'eventClaim');
  get eventClearance => Intl.message("Clearance", name: 'eventClearance');
  get eventMiss => Intl.message("Missed shot", name: 'eventMiss');
  get eventPost => Intl.message("Post", name: 'eventPost');
  get eventAttemptSaved => Intl.message("Attempted shot", name: 'eventAttemptSaved');
  get eventYellowCard => Intl.message("Yellow Card", name: 'eventYellowCard');
  get eventPunch => Intl.message("Punch", name: 'eventPunch');
  get eventDispossessed => Intl.message("Dispossessed", name: 'eventDispossessed');
  get eventError => Intl.message("Error", name: 'eventError');
  get eventDecisiveError => Intl.message("Decisive Error", name: 'eventDecisiveError');
  get eventAssist => Intl.message("Chance Created", name: 'eventAssist');
  get eventTackleEffective => Intl.message("Completed Tackle", name: 'eventTackleEffective');
  get eventGoal => Intl.message("Goal", name: 'eventGoal');
  get eventOwnGoal => Intl.message("Own Goal", name: 'eventOwnGoal');
  get eventFoulCommitted => Intl.message("Foul Committed", name: 'eventFoulCommitted');
  get eventSecondYellowCard => Intl.message("Second Yellow Card", name: 'eventSecondYellowCard');
  get eventRedCard => Intl.message("Red Card", name: 'eventRedCard');
  get eventCaughtOffside => Intl.message("Offside", name: 'eventCaughtOffside');
  get eventPenaltyCommitted => Intl.message("Penalty Conceded", name: 'eventPenaltyCommitted');
  get eventPenaltyFailed => Intl.message("Missed Penalty", name: 'eventPenaltyFailed');
  get eventGoalkeeperSavesPenalty => Intl.message("Penalty Saved", name: 'eventGoalkeeperSavesPenalty');
  get eventCleanSheet => Intl.message("Clean Sheet", name: 'eventCleanSheet');
  get eventGoalConceded => Intl.message("Goal Conceded", name: 'eventGoalConceded');

  get addFunds => Intl.message("ADD FUNDS", name: 'addFunds');
  get addFundsDescriptionTip1 => Intl.message("In order to play Epic Eleven with real money, you need to add funds to your account.", name: 'addFundsDescriptionTip1');
  get addFundsDescriptionTip2 => Intl.message("Don't worry, you can withdraw your money whenever you want for free.", name: 'addFundsDescriptionTip2');
  get addFundsUsingPaypal => Intl.message("You can add funds using PayPal account. The money will be transferred to Fantasy Sports Games S.L.", name: 'addFundsUsingPaypal');

  addFundsMinimumAllowed(amount) => Intl.message("Minimum allowed is $amount", args: [amount], name: 'addFundsMinimumAllowed');

  get withdrawFunds => Intl.message("Withdraw funds", name: 'withdrawFunds');
  get yourBalanceIs => Intl.message("YOUR BALANCE IS", name: 'yourBalanceIs');
  get howMuchMoneyWantToWithdraw => Intl.message("¿How much money want to withdraw?", name: 'howMuchMoneyWantToWithdraw');

  withdrawMinimumAllowed(amount) => Intl.message("You can only withdraw amounts larger to $amount", args: [amount], name: 'withdrawMinimumAllowed');

  get needHelp => Intl.message("Need help?", name: 'needHelp');

  static Localization _instance = new Localization();
}