class Notes{
  int _id;
  String _title;
  String _desc;
  String _date;
  int _priority;
  int _categoryId;

  Notes(this._title,this._categoryId, this._desc, this._date, this._priority);

  Notes.id(this._id, this._title, this._desc, this._date, this._priority);

  int get priority => _priority;

  set priority(int value) {
    _priority = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
  int get categoryId =>_categoryId;
  set categoryId(int value){
    _categoryId=value;
  }

  Map<String,dynamic> toMap(){
    Map map= new Map<String,dynamic>();
    map['notesTitle']=_title;
    map['notesId']=_id;
    map['notesDesc']=_desc;
    map['priority']=_priority;
    map['date']=_date;
    map['categoryId']=_categoryId;
    return map;
  }

   Notes.fromMap(Map<String,dynamic> map){
   this._id=map['notesId'];
   this._title=map['notesTitle'];
   this._desc=map['notesDesc'];
   this._priority=map['priority'];
   this._date=map['date'];
   this._categoryId=map['categoryId'];

  }

}