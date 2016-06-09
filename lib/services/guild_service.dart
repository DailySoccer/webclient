library guild_service;

import 'dart:async';
import 'package:angular/angular.dart';
import 'package:webclient/services/server_service.dart';
import 'package:webclient/services/profile_service.dart';

@Injectable()
class GuildService {

  GuildService(this._server, this._profileService);
  
  /*
   * Obtener un listado de los Guilds
   */
  Future refreshGuilds() {
    return _server.getGuilds()
        .then((jsonMap) {
          return jsonMap;
        });
  }
  
  /*
   * Un usuario crea un Guild, convirtiéndose en el Administrador del mismo 
   */
  Future createGuild(String name) {
    return _server.createGuild(name)
        .then((jsonMap) {
          return jsonMap;
        });
  }
  
  /*
   * Un usuario solicita entrar en un Guild (aún necesita ser aceptado)
   */
  Future requestFromMember(String guildId) {
    return _server.requestFromMember(guildId)
        .then((jsonMap) {
          return jsonMap;
        });
  }

  /*
   * Un usuario Administrador acepta la entrada en el Guild de otro usuario (previamente DEBE haberlo solicitado)
   */
  Future acceptMember(String userId) {
    return _server.addMemberToGuild(userId)
        .then((jsonMap) {
          return jsonMap;
        });
  }

  /*
   * Un usuario Administrador expulsa a otro usuario del Guild
   */
  Future removeMember(String userId) {
    return _server.removeMember(userId)
        .then((jsonMap) {
          return jsonMap;
        });
  }
  
  /*
   * Un usuario decide salirse de su Guild actual
   */
  Future removeFromGuild() {
    return _server.removeFromGuild()
        .then((jsonMap) {
          return jsonMap;
        });
  }
  
  ServerService _server;
  ProfileService _profileService;
}