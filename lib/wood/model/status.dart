class Status {
  static int lastId = 0;
  int id = 0;
  String name = "";

  Status(this.name) {
    lastId++;
    id = lastId;
  }
  Status.all() {
    id = 0;
    name = "Todos";
  }

  static List<Status> getStatusListForDropdown() {
    List<Status> myStatusForDropdown = [Status.all()];
    myStatusForDropdown.addAll(myStatus);
    return myStatusForDropdown;
  }

  String getName() {
    return name;
  }
}

List<Status> myStatus = [Status("Bueno"), Status("Hongos"), Status("Torcido")];
