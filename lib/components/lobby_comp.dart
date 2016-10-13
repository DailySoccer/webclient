library lobby_comp;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/contests_service.dart';
import 'package:webclient/services/refresh_timers_service.dart';
import 'package:webclient/services/loading_service.dart';
import 'package:webclient/services/datetime_service.dart';
import 'package:webclient/services/profile_service.dart';
import 'package:webclient/models/contest.dart';
import 'package:webclient/utils/game_metrics.dart';
import 'package:webclient/services/tutorial_service.dart';
import 'package:webclient/tutorial/tutorial_iniciacion.dart';
import 'package:webclient/utils/string_utils.dart';
import 'package:webclient/services/guild_service.dart';
import 'package:webclient/services/app_state_service.dart';
import 'package:webclient/services/leaderboard_service.dart';

@Component(
  selector: 'lobby',
  templateUrl: 'packages/webclient/components/lobby_comp.html',
  useShadowDom: false
)
class LobbyComp implements DetachAware {
  LoadingService loadingService;
  DateTime selectedDate = null;
  
  bool showNoContestModal = true;
  

  String get today => DateTimeService.today;

  Map<String, List<Contest>> contestListByDay;
  List<Contest> currentContestList;
  List<Map> dayList = new List<Map>();

  bool get isContestListEmpty => !loadingService.isLoading && currentContestList != null && currentContestList.length == 0;

  String getLocalizedText(key, {substitutions: null}) {
    return StringUtils.translate(key, "lobby", substitutions);
  }
  
  String get skillPoints => _profileService.user!= null ? _profileService.user.trueSkill.toString() : "";
  
  
  LobbyComp(RouteProvider routeProvider, this._router, this._appStateService, this._refreshTimersService, this._contestsService, 
            GuildService guildService, this.loadingService, this._profileService, TutorialService tutorialService, this._leaderboardService) {
    refreshTopBar();
    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR, refreshTopBar);
    
    _appStateService.appSecondaryTabBarState.tabList = [];
    _appStateService.appTabBarState.show = true;   

    GameMetrics.logEvent(GameMetrics.LOBBY);

    if (_contestsService.activeContests.isEmpty) {
      loadingService.isLoading = true;
    }

    tutorialService.triggerEnter("lobby");

    _refreshTimersService.addRefreshTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST, refreshActiveContest);
    
    if (_profileService.isLoggedIn) {
      // EJEMPLOS DE USO del GuildService
      
      // 1. Creación del Guild
      // El usuario creará un Guild (será su administrador)
      /*
      guildService.createGuild("Primer Guild")
        .then((result) {
          print("createGuild => $result");
          
          guildService.refreshGuilds()
            .then((result) => print("refreshGuilds => $result"));
      });
       */
      // 2. Solicitar la entrada en un Guild
      // Un 2º usuario solicitará entrar en el Guild anteriormente creado
      /*
      guildService.refreshGuilds()
        .then((result) {
          print("refreshGuilds => $result");
          
          guildService.requestToEnter("575912bfd4c6b8aa8360cb93")
            .then((result) {
              print("requestToEnter => $result");
            });
        });
         */
      // 3. Rechazar la solicitud de acceso a un usuario
      // El usuario administrador rechaza la solicitud anterior
      /*
      guildService.refreshGuilds()
        .then((result) {
          print("refreshGuilds => $result");
          
          guildService.rejectRequestToEnter("56991fa0d4c6a506ff6973eb")
            .then((result) {
              print("rejectRequestToEnter => $result");
            });
        });
         */
      // 4. Aceptar nuevo miembro en el Guild
      // El usuario administrador acepta la solicitud anterior
      /*
      guildService.refreshGuilds()
        .then((result) {
          print("refreshGuilds => $result");
          
          guildService.acceptMember("56991fa0d4c6a506ff6973eb")
            .then((result) {
              print("acceptMember => $result");
            });
        });
         */
      // 5. Quitar a un miembro del Guild
      // El usuario administrador expulsa a un miembro del Guild
      /*
      guildService.refreshGuilds()
        .then((result) {
          print("refreshGuilds => $result");
          
          guildService.removeMember("56991fa0d4c6a506ff6973eb")
            .then((result) {
              print("removeMember => $result");
            });
        });
         */
      // 6. Salirse del Guild
      // El propio usuario quiere salirse del Guild
      /*
      guildService.refreshGuilds()
        .then((result) {
          print("refreshGuilds => $result");
          
          guildService.removeFromGuild()
            .then((result) {
              print("removeFromGuild => $result");
            });
        });
         */
    }
  }

  void refreshTopBar() {
    _appStateService.appTopBarState.activeState = new AppTopBarStateConfig.userBar(_profileService, _router, _leaderboardService );
  }
  
  String getStaticLocalizedText(key) {
    return StringUtils.translate(key, "lobby");
  }
  
  // Rutina que refresca la lista de concursos
  void refreshActiveContest() {
    _contestsService.refreshActiveContests()
      .then((_) {
        //updateDayList();
        updateContestList();
        loadingService.isLoading = false;
      });
  }

  void updateContestList() {
    currentContestList = _contestsService.activeContests;
    //currentContestList = [];
  }
  
  void updateDayList() {
    dayList = new List<Map>();
    contestListByDay = new Map<String,List<Contest>>();
    DateTime current = DateTimeService.now;
    List<Contest> serverContestList = _contestsService.activeContests;
    
    const int WEEK_DAYS_COUNT = 1; //7; 
    for(int i = 0; i < WEEK_DAYS_COUNT; i++) {
      List<Contest> contestListFiltered = new List<Contest>();
      //contestListFiltered.addAll(serverContestList.where((c) => contestIsAtDate(c, current)));
      contestListFiltered.addAll(serverContestList);
      contestListByDay[_dayKey(current)] = contestListFiltered;

      dayList.add({"weekday": current.weekday.toString(), "monthday": current.day, "date": current, "enabled": contestListFiltered.length > 0});
      current = current.add(new Duration(days: 1));
    }


    if (selectedDate == null) {
      Map firstEnabled = dayList.firstWhere((c) => c['enabled'], orElse: () => null);
      selectedDate = firstEnabled != null? firstEnabled['date'] : DateTimeService.now;
    }

    if (contestListByDay != null) {
      currentContestList = contestListByDay[_dayKey(selectedDate)];
    }
  }

  bool contestIsAtDate(Contest c, DateTime date) {
    return (date.day == c.startDate.day &&
            date.month == c.startDate.month &&
            date.year == c.startDate.year);
  }

  // Handler para el evento de entrar en un concurso
  void onActionClick(Contest contest) {
    _router.go('enter_contest', { "contestId": contest.contestId, "parent": "lobby", "contestEntryId": "none" });
  }

  void onSelectedDayChange(DateTime day) {
    selectedDate = day;
    if (contestListByDay != null) {
      currentContestList = contestListByDay[_dayKey(selectedDate)];
    }
  }

  // Mostramos la ventana modal con la información de ese torneo, si no es la versión movil.
  void onRowClick(Contest contest) {
      onActionClick(contest);
  }

  void detach() {
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_CONTEST_LIST);
    _refreshTimersService.cancelTimer(RefreshTimersService.SECONDS_TO_REFRESH_TOPBAR);
  }

  String _dayKey(DateTime date) {
    return DateTimeService.formatDateWithDayOfTheMonth(date);
  }
  
  bool get showCreateContest => _profileService.isLoggedIn && TutorialService.Instance.isCompleted(TutorialIniciacion.NAME);
  
  void onCreateContestClick() {
    if (!showCreateContest) return;
    _router.go('create_contest', {});
  }

  Router _router;
  ProfileService _profileService;
  RefreshTimersService _refreshTimersService;
  ContestsService _contestsService;
  AppStateService _appStateService;
  LeaderboardService _leaderboardService;
}