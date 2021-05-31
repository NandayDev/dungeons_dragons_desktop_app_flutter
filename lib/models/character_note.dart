import 'base_model.dart';

class CharacterNote extends BaseModel {

  CharacterNote.createNew(this.characterId, this.content, { this.notePriority = NotePriority.DEFAULT })
      : super.createNew();

  CharacterNote.fromExisting(int id, DateTime creationDate, this.characterId, this.content, { this.notePriority = NotePriority.DEFAULT })
      : super.fromExisting(id, creationDate);

  /// Id of the character to which this note is linked to
  int characterId;

  /// Content of the note
  String content;

  /// Which priority this note has
  NotePriority notePriority;
}

enum NotePriority {
  LOW,
  DEFAULT,
  HIGH
}