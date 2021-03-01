class Category {
  String _categoryName;
  int _categoryId;

  Category(this._categoryName);

  Category.withID(this._categoryName, this._categoryId);

  int get categoryId => _categoryId;

  set categoryId(int value) {
    _categoryId = value;
  }

  String get categoryName => _categoryName;

  set categoryName(String value) {
    _categoryName = value;
  }

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map['categoryName'] = _categoryName;
    map['categoryId'] = _categoryId;
    return map;
  }

   Category.fromMap(Map<String, dynamic> map){
    this._categoryId=map['categoryId'];
    this._categoryName=map['categoryName'];

   }
}
