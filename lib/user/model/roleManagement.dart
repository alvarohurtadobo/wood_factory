import 'package:wood_center/user/model/role.dart';

// Role(1, "Administrador"),
// Role(2, "Coordinador"),
// Role(3, "Encargado de Almacen"),
// Role(4, "Monta Carga"),
// Role(5, "Invitado"),

bool canCreateKits() {
  return (myRole.id == 1 || myRole.id == 6 || myRole.id == 2);
}

bool canDelete() {
  return (myRole.id == 1 || myRole.id == 6 || myRole.id == 2 || myRole.id == 3);
}

bool canUpdateProduct() {
  return (myRole.id == 1 || myRole.id == 6 || myRole.id == 2);
}

bool canUpdateLocation() {
  return (myRole.id == 1 || myRole.id == 6 || myRole.id == 2 || myRole.id == 4);
}

bool canUpdateState() {
  return (myRole.id == 1 || myRole.id == 6 || myRole.id == 2 || myRole.id == 3);
}

bool canUpdateAmoun() {
  return (myRole.id == 1 || myRole.id == 6 || myRole.id == 2 || myRole.id == 3);
}

bool canUpdateOriginProviderEmployee() {
  return (myRole.id == 1 || myRole.id == 6 || myRole.id == 2);
}

bool canUpdateAnything() {
  return canCreateKits() ||
      canUpdateProduct() ||
      canUpdateLocation() ||
      canUpdateState() ||
      canUpdateAmoun() ||
      canUpdateOriginProviderEmployee();
}
