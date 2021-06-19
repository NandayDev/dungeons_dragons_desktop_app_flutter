import 'package:dungeonsanddragons_helper/services/database.dart';
import 'package:dungeonsanddragons_helper/ui/combat_events/combat_event_list_element_viewmodel.dart';
import 'package:dungeonsanddragons_helper/utilities/database_utility.dart';

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
}