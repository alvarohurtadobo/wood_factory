class Role {
  int id = 0;
  String name = "";

  Role(this.id, this.name);
  Role.empty();

  @override
  String toString() {
    return "[ROLE] $id, $name";
  }
}

Role myRole = Role.empty();

List<Role> myRoles = [
  Role(1, "Administrador"),
  Role(2, "Coordinador"),
  Role(3, "Encargado de Almacen"),
  Role(4, "Monta Carga"),
  Role(5, "Invitado"),
];
