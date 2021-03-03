class Notes{
  int _notesId;
  String _notesTitle;
  String _noteDesc;
  String _date;
  String _priority;
  int _categoryId;
  String categoryTitle;


  Notes( this._notesTitle, this._noteDesc, this._date,
      this._priority, this._categoryId);


  Notes.getId(this._notesId, this._notesTitle, this._noteDesc, this._date,
      this._priority, this._categoryId);


  int get notesId => _notesId;

  set notesId(int value) {
    _notesId = value;
  }

  Map<String,dynamic> toMap(){
    Map map= new Map<String,dynamic>();
    map['notesTitle']=_notesTitle;
    map['notesId']=_notesId;
    map['noteDesc']=_noteDesc;
    map['priority']=_priority;
    map['date']=_date;
    map['categoryId']=_categoryId;
    return map;
  }

   Notes.fromMap(Map<String,dynamic> map){
   this._notesId=map['notesId'];
   this._notesTitle=map['notesTitle'];
   this._noteDesc=map['noteDesc'];
   this._priority=map['priority'];
   this._date=map['date'];
   this._categoryId=map['categoryId'];
   this.categoryTitle=map['categoryName'];
  }

  String get notesTitle => _notesTitle;

  set notesTitle(String value) {
    _notesTitle = value;
  }

  String get noteDesc => _noteDesc;

  set noteDesc(String value) {
    _noteDesc = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get priority => _priority;

  set priority(String value) {
    _priority = value;
  }

  int get categoryId => _categoryId;

  set categoryId(int value) {
    _categoryId = value;
  }
}