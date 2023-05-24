class Process {
  int id = 0;
  String name = "";
  double unitPrice = 0;
  String unit = "";
  int maxAmountEmploees = 0;
  bool createsNewQr = false;

  String getName() {
    return name;
  }

  Process(this.id, this.name, this.unitPrice, this.unit, this.maxAmountEmploees,
      this.createsNewQr);

  Process.empty();
}

List<Process> myProcesses = [
  Process(1, "Chaflan", 5000, "Unidad", 5, false),
  Process(2, "Caja", 5000, "Unidad", 5, false),
  Process(3, "Repisa", 5000, "Unidad", 5, false),
  Process(4, "Desmanche en tanques", 5000, "Unidad", 5, false),
  Process(5, "Inmunizado en tanques", 5000, "Unidad", 5, false),
  Process(6, "Radial", 5000, "Unidad", 5, false),
  Process(7, "Pintura", 5000, "Unidad", 5, false),
];
