library achivements_comp;

import 'dart:html';
import 'package:angular/angular.dart';
import 'package:webclient/models/user.dart';
import 'package:webclient/utils/string_utils.dart';


@Component(
    selector: 'achivements',
    templateUrl: 'packages/webclient/components/achivements_comp.html',
    useShadowDom: false
)

class AchivementsComp {
/*
  LoadingService loadingService;
  ProfileService profileService;
*/
  AchivementsComp (/*this.loadingService, this.profileService*/) {
  }
  
  List<Achivement> achivementList = [
      new Achivement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerMister.png', style: 'Training', earned: true),
      new Achivement(name: "xcv", description: "qweqweqweqwe", image: '', style: 'Training', earned: true),
      new Achivement(name: "ser", description: "eeeeeeee", image: '', style: 'Oficial', earned: false),
      new Achivement(name: "sds", description: "ddddddd", image: '', style: 'Oficial', earned: true),
      new Achivement(name: "asd", description: "cccccccc", image: '', style: 'Training', earned: true),
      new Achivement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerPrincipiante.png', style: 'Training', earned: true),
      new Achivement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerMister.png', style: 'Oficial', earned: true),
      new Achivement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerMister.png', style: 'ManagerLevel', earned: true),
      new Achivement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerPrincipiante.png', style: 'Player', earned: true),
      new Achivement(name: "asd", description: "qweqweqweqwe", image: 'IconManagerPrincipiante.png', style: 'SkillLevel', earned: true)
    ];

}

class Achivement {

  String name;
  String description;
  String image;
  String style;
  bool earned;

  static const BASIC_STYLE = "basic";
  static const ORANGE_STYLE = "orange";
  
  Achivement({String name: "", String description: "", String image: "", String style: BASIC_STYLE, bool earned: false}) {
    this.name = name;
    this.description = description;
    this.image = image;
    this.style = style;
    this.earned = earned;
  }
  
}