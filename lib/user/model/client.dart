class Client {
  static int lastId = 0;
  int id = 0;
  String name = "";
  String representativeFirstName = "";
  String representativeLasttName = "";
  String plate = "";
  int cityId = 0;
  String nit = "";
  DateTime createdAt = DateTime.now();

  // Aux
  String cityName = "";

  Client.empty();

  Client(
      this.id,
      this.name,
      this.representativeFirstName,
      this.representativeLasttName,
      this.plate,
      this.cityId,
      this.cityName,
      this.nit,
      this.createdAt);

  String getName() {
    return name;
  }
  String getRepresentativeName() {
    return "$representativeFirstName $representativeLasttName";
  }
}

List<Client> myClients = [
  Client(0, "", "Seleccionar", "", "", 0, "",
      "", DateTime.now()),
  Client(1, "Cliente 1", "Alvaro", "Hurtado", "ABC1234", 1, "Oruro",
      "7272787013", DateTime.now()),
  Client(2, "Cliente 2", "Tatiana", "Del Carpio", "XYZ4321", 2, "La Paz",
      "7272787013", DateTime.now()),
  Client(3, "Cliente 3", "Ivan", "Hurtado", "ABC1234", 3, "Bogotá",
      "7272787013", DateTime.now()),
  Client(4, "Cliente 4", "María", "Maldonado", "ABC1234", 4, "Cliza",
      "7272787013", DateTime.now()),
];

Client myClient = Client.empty();
