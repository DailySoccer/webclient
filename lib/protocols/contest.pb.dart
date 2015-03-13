///
//  Generated code. Do not modify.
///
library protocols;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';

class Contest_ContestEntry extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Contest_ContestEntry')
    ..a(1, 'contestEntryId', GeneratedMessage.OS)
    ..a(2, 'userId', GeneratedMessage.OS)
    ..hasRequiredFields = false
  ;

  Contest_ContestEntry() : super();
  Contest_ContestEntry.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Contest_ContestEntry.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Contest_ContestEntry clone() => new Contest_ContestEntry()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Contest_ContestEntry create() => new Contest_ContestEntry();
  static PbList<Contest_ContestEntry> createRepeated() => new PbList<Contest_ContestEntry>();

  String get contestEntryId => getField(1);
  void set contestEntryId(String v) { setField(1, v); }
  bool hasContestEntryId() => hasField(1);
  void clearContestEntryId() => clearField(1);

  String get userId => getField(2);
  void set userId(String v) { setField(2, v); }
  bool hasUserId() => hasField(2);
  void clearUserId() => clearField(2);
}

class Contest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('Contest')
    ..a(1, 'contestId', GeneratedMessage.OS)
    ..a(2, 'templateContestId', GeneratedMessage.OS)
    ..a(3, 'state', GeneratedMessage.OS)
    ..a(4, 'name', GeneratedMessage.OS)
    ..m(5, 'contestEntry', Contest_ContestEntry.create, Contest_ContestEntry.createRepeated)
    ..a(6, 'numEntries', GeneratedMessage.O3)
    ..a(7, 'maxEntries', GeneratedMessage.O3)
    ..a(8, 'salaryCap', GeneratedMessage.O3)
    ..a(9, 'entryFee', GeneratedMessage.OS)
    ..a(10, 'prizeType', GeneratedMessage.OS)
    ..a(11, 'startDate', GeneratedMessage.O6, Int64.ZERO)
    ..a(12, 'optaCompetitionId', GeneratedMessage.OS)
    ..p(13, 'templateMatchEventId', GeneratedMessage.PS)
    ..hasRequiredFields = false
  ;

  Contest() : super();
  Contest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  Contest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  Contest clone() => new Contest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static Contest create() => new Contest();
  static PbList<Contest> createRepeated() => new PbList<Contest>();

  String get contestId => getField(1);
  void set contestId(String v) { setField(1, v); }
  bool hasContestId() => hasField(1);
  void clearContestId() => clearField(1);

  String get templateContestId => getField(2);
  void set templateContestId(String v) { setField(2, v); }
  bool hasTemplateContestId() => hasField(2);
  void clearTemplateContestId() => clearField(2);

  String get state => getField(3);
  void set state(String v) { setField(3, v); }
  bool hasState() => hasField(3);
  void clearState() => clearField(3);

  String get name => getField(4);
  void set name(String v) { setField(4, v); }
  bool hasName() => hasField(4);
  void clearName() => clearField(4);

  List<Contest_ContestEntry> get contestEntry => getField(5);

  int get numEntries => getField(6);
  void set numEntries(int v) { setField(6, v); }
  bool hasNumEntries() => hasField(6);
  void clearNumEntries() => clearField(6);

  int get maxEntries => getField(7);
  void set maxEntries(int v) { setField(7, v); }
  bool hasMaxEntries() => hasField(7);
  void clearMaxEntries() => clearField(7);

  int get salaryCap => getField(8);
  void set salaryCap(int v) { setField(8, v); }
  bool hasSalaryCap() => hasField(8);
  void clearSalaryCap() => clearField(8);

  String get entryFee => getField(9);
  void set entryFee(String v) { setField(9, v); }
  bool hasEntryFee() => hasField(9);
  void clearEntryFee() => clearField(9);

  String get prizeType => getField(10);
  void set prizeType(String v) { setField(10, v); }
  bool hasPrizeType() => hasField(10);
  void clearPrizeType() => clearField(10);

  Int64 get startDate => getField(11);
  void set startDate(Int64 v) { setField(11, v); }
  bool hasStartDate() => hasField(11);
  void clearStartDate() => clearField(11);

  String get optaCompetitionId => getField(12);
  void set optaCompetitionId(String v) { setField(12, v); }
  bool hasOptaCompetitionId() => hasField(12);
  void clearOptaCompetitionId() => clearField(12);

  List<String> get templateMatchEventId => getField(13);
}

class ContestList extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('ContestList')
    ..m(1, 'contest', Contest.create, Contest.createRepeated)
    ..hasRequiredFields = false
  ;

  ContestList() : super();
  ContestList.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  ContestList.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  ContestList clone() => new ContestList()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static ContestList create() => new ContestList();
  static PbList<ContestList> createRepeated() => new PbList<ContestList>();

  List<Contest> get contest => getField(1);
}

