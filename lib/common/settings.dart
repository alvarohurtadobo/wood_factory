import 'package:wood_center/wood/model/kit.dart';

const bool DEBUG = false;
String token = "";
int? currentCityId;
int? currentLineId;
int deletedKitId = 0;
int lastKitIdGeneratedQrForDebug = 0;

Kit sourceKit=Kit.empty();
