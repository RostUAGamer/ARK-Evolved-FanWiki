enum BreedingType {
  egg,
  gestation,
}

class BreedingCreature {
  final String id;
  final String nameUa;
  final String nameEn;
  final String species;
  final String imageUrl;
  final BreedingType breedingType;
  final double? minTempCelsius;
  final double? maxTempCelsius;
  final int baseIncubationSeconds; // Seconds for 1x
  final int baseMaturationSeconds; // Seconds for 1x
  final String primaryFoodUa;
  final String primaryFoodEn;
  final double foodPointsPerUnit; // e.g. Raw meat = 50, Berry = 20
  final int baseBabyFoodPerHour; // Units of food baby consumes per hour at 1x
  final int baseImprintIntervalSeconds; // Official is 28800s (8 hours)
  final String tipsUa;

  const BreedingCreature({
    required this.id,
    required this.nameUa,
    required this.nameEn,
    required this.species,
    required this.imageUrl,
    required this.breedingType,
    this.minTempCelsius,
    this.maxTempCelsius,
    required this.baseIncubationSeconds,
    required this.baseMaturationSeconds,
    required this.primaryFoodUa,
    required this.primaryFoodEn,
    required this.foodPointsPerUnit,
    required this.baseBabyFoodPerHour,
    this.baseImprintIntervalSeconds = 28800,
    required this.tipsUa,
  });

  bool get isEgg => breedingType == BreedingType.egg;

  /// Розрахунок часу інкубації або вагітності
  int getIncubationSeconds(double hatchSpeedMultiplier) {
    if (hatchSpeedMultiplier <= 0) return baseIncubationSeconds;
    return (baseIncubationSeconds / hatchSpeedMultiplier).round().clamp(1, 9999999);
  }

  /// Загальний час вирощування
  int getMaturationSeconds(double matureSpeedMultiplier) {
    if (matureSpeedMultiplier <= 0) return baseMaturationSeconds;
    return (baseMaturationSeconds / matureSpeedMultiplier).round().clamp(1, 9999999);
  }

  /// Стадія Дитинча (0% - 10%)
  int getBabySeconds(double matureSpeedMultiplier) {
    return (getMaturationSeconds(matureSpeedMultiplier) * 0.10).round();
  }

  /// Стадія Підліток (10% - 50%)
  int getJuvenileSeconds(double matureSpeedMultiplier) {
    return (getMaturationSeconds(matureSpeedMultiplier) * 0.40).round();
  }

  /// Стадія Юний (50% - 100%)
  int getAdolescentSeconds(double matureSpeedMultiplier) {
    return (getMaturationSeconds(matureSpeedMultiplier) * 0.50).round();
  }

  /// Кількість їжі для дитинчати (в штуках)
  int getBabyFoodQuantity(double matureSpeedMultiplier) {
    final babyHours = getBabySeconds(matureSpeedMultiplier) / 3600.0;
    return (babyHours * baseBabyFoodPerHour).ceil().clamp(1, 99999);
  }

  /// Загальна кількість їжі на весь цикл дорослішання
  int getTotalFoodQuantity(double matureSpeedMultiplier) {
    // Mature creature consumes less per second as it grows, total approx 4.5x of baby phase
    final total = getBabyFoodQuantity(matureSpeedMultiplier) * 4.5;
    return total.ceil();
  }

  /// Кількість імпринтингів
  int getImprintCount(double matureSpeedMultiplier) {
    final totalSeconds = getMaturationSeconds(matureSpeedMultiplier);
    // On official, interval scales or stays 8h. For faster mature, interval is often clamped or scaled
    final count = (totalSeconds / baseImprintIntervalSeconds).floor();
    return count < 1 ? 1 : count;
  }

  /// Відсоток за 1 підхід імпринтингу
  double getImprintGainPerAction(double matureSpeedMultiplier) {
    final count = getImprintCount(matureSpeedMultiplier);
    return (100.0 / count).clamp(1.0, 100.0);
  }

  /// Форматування часу в красивий текст: "3г 45хв 20с"
  static String formatDuration(int totalSeconds) {
    if (totalSeconds <= 0) return '0с';
    final days = totalSeconds ~/ 86400;
    final hours = (totalSeconds % 86400) ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    final parts = <String>[];
    if (days > 0) parts.add('${days}д');
    if (hours > 0) parts.add('${hours}г');
    if (minutes > 0 && days == 0) parts.add('${minutes}хв');
    if (seconds > 0 && days == 0 && hours == 0) parts.add('${seconds}с');

    return parts.isEmpty ? '${seconds}с' : parts.join(' ');
  }
}
