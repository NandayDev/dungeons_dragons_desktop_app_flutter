enum MainMenuItem {
  PLAYERS,
  NPC,
  MONSTERS,
  COMBAT
}

extension MainMenuItemExtensions on MainMenuItem {
  String getReadableName() {
    switch(this) {
      case MainMenuItem.PLAYERS:
        return "Players";
      case MainMenuItem.NPC:
        return "NPCs";
      case MainMenuItem.MONSTERS:
        return "Monsters";
      case MainMenuItem.COMBAT:
        return "Combat";
    }
  }
}