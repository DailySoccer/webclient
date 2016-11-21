library guild_service;

import 'dart:async';
import 'package:angular2/core.dart';
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
  Future requestToEnter(String guildId) {
    return _server.requestToEnter(guildId)
        .then((jsonMap) {
          return jsonMap;
        });
  }

  /*
   * Un usuario Administrador rechaza la entrada de un usuario en el Guild (que previamente había solicitado el acceso)
   */
  Future rejectRequestToEnter(String userId) {
    return _server.rejectRequestToEnter(userId)
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

  /*
   * El leaderboard del guild al que pertenece el usuario
   */
  Future getLeaderboard() {
    return _server.getGuildLeaderboard()
        .then((jsonMap) {
          return jsonMap;
        });
  }
  
  ServerService _server;
  ProfileService _profileService;
}