///
/// Base class for all database models of the application
///
abstract class BaseModel {

  /// Constructor for a new model of the database
  BaseModel.createNew() {
    this.id = 0;
    this.creationDate = DateTime.now().toUtc();
  }

  /// Constructor for an already existing model in the database
  BaseModel.fromExisting(this.id, this.creationDate);

  /// Database id
  late int id;

  /// Date in which this entry was created
  late DateTime creationDate;

}