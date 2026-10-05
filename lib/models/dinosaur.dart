enum DietType {
  carnivore,
  herbivore,
  piscivore,
}

enum HabitatType {
  terrestrial,
  flying,
  marine,
  semiAquatic,
}

enum TemperamentType {
  passive,
  neutral,
  aggressive,
}

class TamingFoodItem {
  final String nameUa;
  final String nameEn;
  final String icon; // emoji or label
  final double baseQuantity;
  final double quantityPerLevel;
  final double baseTimeSeconds;
  final double timePerLevelSeconds;
  final double baseEffectiveness; // 0.0 - 1.0
  final double baseNarcotics;
  final double narcoticsPerLevel;

  const TamingFoodItem({
    required this.nameUa,
    required this.nameEn,
    required this.icon,
    required this.baseQuantity,
    required this.quantityPerLevel,
    required this.baseTimeSeconds,
    required this.timePerLevelSeconds,
    required this.baseEffectiveness,
    required this.baseNarcotics,
    required this.narcoticsPerLevel,
  });

  int getQuantity(int level) {
    final val = baseQuantity + (level - 1) * quantityPerLevel;
    return val.ceil().clamp(1, 99999);
  }

  int getTimeSeconds(int level) {
    final val = baseTimeSeconds + (level - 1) * timePerLevelSeconds;
    return val.round().clamp(1, 999999);
  }

  double getEffectiveness(int level) {
    // Slight decline in TE as food count increases
    final loss = (level - 1) * 0.0003;
    return (baseEffectiveness - loss).clamp(0.40, 0.999);
  }

  int getBonusLevels(int level) {
    final te = getEffectiveness(level);
    return ((level / 2.0) * te).floor();
  }

  int getNarcotics(int level) {
    final val = baseNarcotics + (level - 1) * narcoticsPerLevel;
    return val.ceil().clamp(0, 99999);
  }
}

class SpeedStats {
  final int walking;
  final int running;
  final int swimming;
  final int? flying;
  final int? sprintFlying;

  const SpeedStats({
    required this.walking,
    required this.running,
    required this.swimming,
    this.flying,
    this.sprintFlying,
  });
}

class Dinosaur {
  final String id;
  final String nameUa;
  final String nameEn;
  final String species;
  final DietType diet;
  final HabitatType habitat;
  final TemperamentType temperament;
  final String imageUrl;
  final String backupImageUrl;
  final String description;
  final String wikiUrl;
  final String preferredKibble;
  final double baseTorpor;
  final double torporPerLevel;
  final double torporDrainRate; // torpor drained per second
  final SpeedStats speed;
  final List<TamingFoodItem> tamingFoods;
  final double headshotMultiplier; // 1.0 = normal, 2.5 = 2.5x, 0.15 = trike face

  const Dinosaur({
    required this.id,
    required this.nameUa,
    required this.nameEn,
    required this.species,
    required this.diet,
    required this.habitat,
    required this.temperament,
    required this.imageUrl,
    required this.backupImageUrl,
    required this.description,
    required this.wikiUrl,
    required this.preferredKibble,
    required this.baseTorpor,
    required this.torporPerLevel,
    required this.torporDrainRate,
    required this.speed,
    required this.tamingFoods,
    this.headshotMultiplier = 1.0,
  });

  /// Розрахунок торпору за рівнем (формула ARK Wiki)
  double getTorpor(int level) {
    return baseTorpor + (level - 1) * torporPerLevel;
  }

  String get dietStringUa {
    switch (diet) {
      case DietType.carnivore:
        return "М'ясоїдний";
      case DietType.herbivore:
        return "Травоїдний";
      case DietType.piscivore:
        return "Рибоїдний";
    }
  }

  String get habitatStringUa {
    switch (habitat) {
      case HabitatType.terrestrial:
        return "Наземний";
      case HabitatType.flying:
        return "Літун";
      case HabitatType.marine:
        return "Морський";
      case HabitatType.semiAquatic:
        return "Напівводний";
    }
  }

  String get temperamentStringUa {
    switch (temperament) {
      case TemperamentType.passive:
        return "Пасивний";
      case TemperamentType.neutral:
        return "Нейтральний";
      case TemperamentType.aggressive:
        return "Агресивний";
    }
  }
}

class KnockoutWeapon {
  final String nameUa;
  final String nameEn;
  final String icon;
  final double baseTorporPerHit;
  final String description;

  const KnockoutWeapon({
    required this.nameUa,
    required this.nameEn,
    required this.icon,
    required this.baseTorporPerHit,
    required this.description,
  });

  int shotsNeeded(double targetTorpor, {double multiplier = 1.0}) {
    final effective = baseTorporPerHit * multiplier;
    if (effective <= 0) return 0;
    return (targetTorpor / effective).ceil();
  }
}
