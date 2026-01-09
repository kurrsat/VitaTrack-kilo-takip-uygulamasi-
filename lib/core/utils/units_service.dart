import 'package:weightvault/domain/models/models.dart';
class UnitsService {
  const UnitsService();

  double toUserWeight({required double weightKg, required UnitsSystem units}) {
    if (units == UnitsSystem.imperial) {
      return weightKg * 2.2046226218;
    }
    return weightKg;
  }

  double toKg({required double weight, required UnitsSystem units}) {
    if (units == UnitsSystem.imperial) {
      return weight / 2.2046226218;
    }
    return weight;
  }

  String weightUnitLabel(UnitsSystem units) {
    return units == UnitsSystem.imperial ? 'lb' : 'kg';
  }

  double heightToUser({required double heightCm, required UnitsSystem units}) {
    if (units == UnitsSystem.imperial) {
      return heightCm / 2.54;
    }
    return heightCm;
  }

  double heightToCm({required double height, required UnitsSystem units}) {
    if (units == UnitsSystem.imperial) {
      return height * 2.54;
    }
    return height;
  }

  String heightUnitLabel(UnitsSystem units) {
    return units == UnitsSystem.imperial ? 'in' : 'cm';
  }
}
