
class Tax {

   Tax( {
    required this.taxName,
    required this.countryName,
    required this.taxDefinition,
    required this.taxExample,
  });

  late final String taxName;
  late final String countryName;
  late final String taxDefinition;
  late final String taxExample;

  String get tName => taxName;

  String get cName => countryName;

  String get tDef => taxDefinition;

  String get tExample => taxExample;


  set taName(String newName) {
    taxName = newName;
  }

  set coName(String newCountry) {
   countryName = newCountry;
  }

  set taDef(String newTaxDef) {
   taxDefinition = newTaxDef;
  }

  set taExp(String newTaxExp) {
    taxExample = newTaxExp;
  }

  // Convert a Tax object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    map['tName'] = taxName;
    map['cName'] = countryName;
    map['tDef'] = taxDefinition;
    map['tExp'] = taxExample;

    return map;
  }

  // Extract a Tax object from a Map object
  Tax.fromMapObject(Map<String, dynamic> map) {
    taxName = map['tName'];
    countryName = map['cName'];
    taxDefinition = map['tDef'];
    taxExample = map['tExp'];
  }
}
