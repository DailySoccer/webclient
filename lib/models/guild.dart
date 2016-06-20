library guild;
import 'package:webclient/models/user.dart';
import 'package:webclient/services/template_references.dart';
import 'package:webclient/services/contest_references.dart';

class Guild {
  String guildId;
  String name;
  List<User> users = [];
  
  Guild.referenceInit(this.guildId);
  
  factory Guild.fromJsonObject(Map jsonMap, TemplateReferences templateReferences, ContestReferences contestReferences) {
    return contestReferences.getGuildById(jsonMap["_id"])._initFromJsonObject(jsonMap, templateReferences, contestReferences);
  }

  Guild _initFromJsonObject(Map jsonMap, TemplateReferences templateReferences, ContestReferences contestReferences) {
    assert(guildId.isNotEmpty);

    name = jsonMap["name"];
    
    // print("Guild: id($guildId) name($name)");
    return this;
  }
}