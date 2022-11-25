class WoodState {
  static int lastId = 0;
  int id = 0;
  String name = "";

  WoodState(this.name) {
    lastId++;
    id = lastId;
  }
  WoodState.all() {
    id = 0;
    name = "Todos";
  }

  WoodState.fromBackendResponse(Map<String,dynamic> myRes){
    id = myRes["id"] ?? 0;
    name = myRes["name"] ?? "";
    // "id": 1,
    // "name": "Hongos",
  }

  static List<WoodState> getStatusListForDropdown() {
    List<WoodState> myStatusForDropdown = [WoodState.all()];
    myStatusForDropdown.addAll(myWoodStates);
    return myStatusForDropdown;
  }

  String getName() {
    return name;
  }
}

List<WoodState> myWoodStates = [WoodState("Bueno"), WoodState("Hongos"), WoodState("Torcido")];
