library contest_info_comp;

import 'package:angular/angular.dart';

@Component(selector: 'contest-info', templateUrl: 'packages/webclient/components/contest_info_comp.html', publishAs: 'contestInfo', useShadowDom: false)
class ContestInfoComp {
    Map contest;
    var matchesInvolved = new List();
    var contestants  = new List();
    var prizes = new List();

    ContestInfoComp(Scope scope, this._router) {
      
      matchesInvolved.add({
        'teams'   : 'ATM - RMA',
        'dateTime': 'DOM. 14/05 19:00'
      });
      matchesInvolved.add({
        'teams'   : 'SEV - BET',
        'dateTime': 'DOM. 14/05 19:15'
      });
      matchesInvolved.add({
        'teams'   : 'REC - LEV',
        'dateTime': 'DOM. 14/05 19:30'
      });
      matchesInvolved.add({
        'teams'   : 'FCB - ESP',
        'dateTime': 'DOM. 15/05 20:00'
      });
      matchesInvolved.add({
        'teams'   : 'MLG - OSA',
        'dateTime': 'DOM. 15/05 20:15'
      });
      matchesInvolved.add({
        'teams'   : 'ZAR - GET',
        'dateTime': 'DOM. 15/05 20:30'
      });
      
      contestants.add({
        'name'    : 'Santiago Reveliñas',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Federico Mon',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Ximo Martinez Albors',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Victor Zincoontrin',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Javichu Lajaraster',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Santiago Revelo',
        'points'  : '0000'
      });
      
      contestants.add({
        'name'    : 'Jhon Doe 1',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Jhon Doe 2',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Jhon Doe 3',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Jhon Doe 4',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Jhon Doe 5',
        'points'  : '0000'
      });
      contestants.add({
        'name'    : 'Jhon Doe 6',
        'points'  : '0000'
      });
      
      prizes.add({'value' : '300,00'});
      prizes.add({'value' : '100,00'});
      prizes.add({'value' : '50,00' });
      
      contest = {
            'description'     : 'TORNEO MULTIJUGADOR (500) LIM. 60M',
            'name'            : 'CONQUISTA EUROPA',
            'entry'           : '25',
            'prize'           : '65.000',
            'rules'           : 'Elige un equipo de 11 jugadores a partir de los siguientes partidos',
            'startDateTime'   : 'COMIENZA EL DOM. 15/05 19:00',
            'matchesInvolved' : matchesInvolved,
            'contestants'     : contestants,
            'prizes'          : prizes,
            'rulesDescription': "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam porta nunc eget purus elementum ornare.<br/> Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Etiam at mollis purus. Maecenas congue odio quis dolor vehicula, in eleifend massa dignissim. Suspendisse potenti. Donec eu purus dui. Pellentesque egestas lacinia arcu, at vulputate lorem varius ut. Mauris diam justo, fermentum vel ligula sed, laoreet blandit lacus.  <br/>In, sollicitudin diam. Donec a imperdiet est, vitae tincidunt lorem. Donec risus elit, pretium sed pharetra vitae, gravida vel nulla."
            
        };
    }

    Router _router;
}
