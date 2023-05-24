import 'package:wood_center/wood/model/process.dart';

class Transformation {
  int id = 0;
  int processId = 0;
  DateTime createdAt = DateTime.now();
  DateTime startedAt = DateTime.now();
  DateTime endAt = DateTime.now();
  String status = "OPEN";
  // aux
  String processName = "";

  Transformation(this.id, this.processId) {
    processId = processId % myProcesses.length;
    processName =
        myProcesses.firstWhere((element) => element.id == processId).name;
  }

  Transformation.empty();
}

List<Transformation> myTransforms = [
  Transformation(1, 2),
  Transformation(2, 4),
  Transformation(3, 2),
  Transformation(4, 1),
  Transformation(5, 3),
  Transformation(6, 4),
  Transformation(7, 5),
];

Transformation myTransform = Transformation(1, 2);