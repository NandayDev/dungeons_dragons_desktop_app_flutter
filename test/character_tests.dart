import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test proficiency bonus", () {
    var character = PlayerCharacter.createNew("", 0, 0, 0, 0, 0, 0, "", 0, 0, 0, 0, 0, 0);
    for (int i = 1; i < 21; i++) {
      character.level = i;
      switch (character.level) {
        case 1:
        case 2:
        case 3:
        case 4:
          expect(character.proficiencyBonus, 2);
          break;

        case 5:
        case 6:
        case 7:
        case 8:
          expect(character.proficiencyBonus, 3);
          break;

        case 9:
        case 10:
        case 11:
        case 12:
          expect(character.proficiencyBonus, 4);
          break;

        case 13:
        case 14:
        case 15:
        case 16:
          expect(character.proficiencyBonus, 5);
          break;

        case 17:
        case 18:
        case 19:
        case 20:
          expect(character.proficiencyBonus, 6);
          break;
      }
    }
  });
}
