import 'package:dungeonsanddragons_helper/models/combat_event.dart';
import 'package:dungeonsanddragons_helper/services/character_repository.dart';
import 'package:dungeonsanddragons_helper/services/database.dart';
import 'package:dungeonsanddragons_helper/ui/combat_events/combat_event_list_element_viewmodel.dart';
import 'package:dungeonsanddragons_helper/utilities/database_utility.dart';
import 'package:flutter/foundation.dart';

abstract class CombatEventsRepository {

  ///
  /// Returns a list of combat events, in a "paged" manner
  ///
  Future<List<CombatEventListElementViewModel>> getCombatEvents(int count, int skip);

}

class CombatEventsRepositoryImpl extends CombatEventsRepository {

  @override
  Future<List<CombatEventListElementViewModel>> getCombatEvents(int count, int skip) async {

    var database = await DungeonsDatabase.getDatabaseInstance();

    var queryResult = await database.rawQuery(
      "SELECT * FROM ${DungeonsDatabase.COMBAT_EVENTS_TABLE} " +
          "LIMIT $count OFFSET $skip"
    );

    if (!kReleaseMode) {
      if (queryResult.length == 0) {
        await database.insert(DungeonsDatabase.COMBAT_EVENTS_TABLE, MOCK_CE_1._toMap());
        await database.insert(DungeonsDatabase.COMBAT_EVENTS_TABLE, MOCK_CE_2._toMap());
        queryResult = await database.rawQuery(
            "SELECT * FROM ${DungeonsDatabase.COMBAT_EVENTS_TABLE} " +
                "LIMIT $count OFFSET $skip");
      }
    }

    List<CombatEventListElementViewModel> combatEvents = [];

    for (var row in queryResult) {
      combatEvents.add(convertFromRow(row));
    }

    return combatEvents;
  }

  ///
  /// Converts a row from the database (in the form of a map) into a CombatEventListElementViewModel
  ///
  CombatEventListElementViewModel convertFromRow(Map<String,Object?> row) {
    // Converts the string for the characters into an int array //
    var characterIds = DatabaseUtility.transformIntoArrayOfInt(row[DungeonsDatabase.COMBAT_EVENT_CHARACTERS] as String);

    return CombatEventListElementViewModel(
        row[DungeonsDatabase.BASE_MODEL_ID] as int,
        row[DungeonsDatabase.COMBAT_EVENT_NAME] as String,
        DungeonsDatabase.getUtcDateTimeFromMillisecondsSinceEpoch(
            row[DungeonsDatabase.BASE_MODEL_CREATION_DATE] as int),
        characterIds.length,
        row[DungeonsDatabase.COMBAT_EVENT_CURRENT_ROUND] as int);
  }

  static CombatEvent MOCK_CE_1 = CombatEvent.fromExisting(1, DateTime.now().toUtc(),
      "Goblin battle",
      [CharacterRepositoryImpl.MOCK_PC_1,CharacterRepositoryImpl.MOCK_PC_2],
      {
        CharacterRepositoryImpl.MOCK_PC_1: 10,
        CharacterRepositoryImpl.MOCK_PC_2: 26
      },
      {
        CharacterRepositoryImpl.MOCK_PC_1: 6,
        CharacterRepositoryImpl.MOCK_PC_2: 15
      },
      {
        CharacterRepositoryImpl.MOCK_PC_1: true,
        CharacterRepositoryImpl.MOCK_PC_2: false
      },
      2);
  static CombatEvent MOCK_CE_2 = CombatEvent.fromExisting(2, DateTime.now().toUtc(),
      "Goblin battle",
      [CharacterRepositoryImpl.MOCK_PC_1,CharacterRepositoryImpl.MOCK_PC_2],
      {
        CharacterRepositoryImpl.MOCK_PC_1: 18,
        CharacterRepositoryImpl.MOCK_PC_2: 20
      },
      {
        CharacterRepositoryImpl.MOCK_PC_1: 25,
        CharacterRepositoryImpl.MOCK_PC_2: 20
      },
      {
        CharacterRepositoryImpl.MOCK_PC_1: true,
        CharacterRepositoryImpl.MOCK_PC_2: true
      },
      1);
}

extension CombatEventToMap on CombatEvent {
  ///
  /// Converts any character into a map with each property
  /// Useful for database operations
  ///
  Map<String, dynamic> _toMap() {
    var charactersString = DatabaseUtility.transformIntoDatabaseString(characters.map((e) => e.id).toList());
    var currentHpsString = DatabaseUtility.transformIntoDatabaseString(currentHps.values.toList());
    var initiativesRolledString = DatabaseUtility.transformIntoDatabaseString(initiativesRolled.values.toList());
    var isRoundOverString = DatabaseUtility.transformIntoDatabaseString(isRoundOver.values.map((e) => e ? 1 : 0).toList());
    return {
      DungeonsDatabase.BASE_MODEL_ID: id,
      DungeonsDatabase.BASE_MODEL_CREATION_DATE: DungeonsDatabase
          .getMillisecondsSinceEpochFromDateTime(creationDate),
      DungeonsDatabase.COMBAT_EVENT_NAME: name,
      DungeonsDatabase.COMBAT_EVENT_CHARACTERS: charactersString,
      DungeonsDatabase.COMBAT_EVENT_CURRENT_HPS: currentHpsString,
      DungeonsDatabase.COMBAT_EVENT_INITIATIVES_ROLLED: initiativesRolledString,
      DungeonsDatabase.COMBAT_EVENT_IS_ROUND_OVER: isRoundOverString,
      DungeonsDatabase.COMBAT_EVENT_CURRENT_ROUND: currentRound
    };
  }
}