class InventoryType {
  static int lastId = 0;
  int id = 0;
  String name = "";

  InventoryType(this.name) {
    lastId++;
    id = lastId;
  }
}

List<InventoryType> myInventoryTypes = [
  InventoryType("PRODUCTO TERMINADO"),
  InventoryType("PRODUCTO EN PROCESO"),
  InventoryType("MERCANCIA DE TERCEROS"),
  InventoryType("MATERIA PRIMA"),
  InventoryType("INSUMOS"),
];
