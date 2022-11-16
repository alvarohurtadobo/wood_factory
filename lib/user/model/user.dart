class User {
  static int lastId = 0;
  int id = 0;
  String email = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String photoUrl = "http://cdn.onlinewebfonts.com/svg/img_569206.png";
  String documentId = "";
  String charge = "";
  int cityId = 0;
  int roleId = 0;

  String fullName()=>"$firstName $lastName";

  User.empty();

  User(
      {this.email = "",
      this.password = "",
      this.firstName = "",
      this.lastName = "",
      this.photoUrl = "http://cdn.onlinewebfonts.com/svg/img_569206.png",
      this.documentId = "",
      this.charge = "",
      this.cityId = 0,
      this.roleId = 0}) {
    lastId++;
    id = lastId;
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "password": password,
      "first_name": firstName,
      "last_name": lastName,
      "photo_url": photoUrl,
      "document_id": documentId,
      "city_id": cityId,
      "role_id": roleId,
    };
  }

  @override
  String toString() {
    return "[USER] $id, $email, $password, $firstName";
  }
}

User myUser = User.empty();

List<User> demoUsers = [
  User(
      email: "admin@mail.com",
      password: "1234",
      firstName: "Administrado",
      lastName: "Administrador",
      photoUrl: "http://cdn.onlinewebfonts.com/svg/img_569206.png",
      documentId: "987654321",
      charge: "",
      cityId: 1,
      roleId: 1),
  User(
      email: "manager@mail.com",
      password: "1234",
      firstName: "Coordinador",
      lastName: "Coordinador",
      photoUrl: "http://cdn.onlinewebfonts.com/svg/img_569206.png",
      documentId: "987654321",
      charge: "",
      cityId: 1,
      roleId: 2),
  User(
      email: "warehouse@mail.com",
      password: "1234",
      firstName: "Almacen",
      lastName: "Almacen",
      photoUrl: "http://cdn.onlinewebfonts.com/svg/img_569206.png",
      documentId: "987654321",
      charge: "",
      cityId: 1,
      roleId: 3),
  User(
      email: "driver@mail.com",
      password: "1234",
      firstName: "Monta",
      lastName: "Carga",
      photoUrl: "http://cdn.onlinewebfonts.com/svg/img_569206.png",
      documentId: "987654321",
      charge: "",
      cityId: 1,
      roleId: 4),
  User(
      email: "guest@mail.com",
      password: "1234",
      firstName: "Invitado",
      lastName: "Invitado",
      photoUrl: "http://cdn.onlinewebfonts.com/svg/img_569206.png",
      documentId: "987654321",
      charge: "",
      cityId: 1,
      roleId: 5),
];
