import '../models/breeding_data.dart';

class BreedingDatabase {
  static const List<BreedingCreature> creatures = [
    BreedingCreature(
      id: 'rex',
      nameUa: 'Тиранозавр (Рекс)',
      nameEn: 'Tyrannosaurus Rex',
      species: 'Tyrannosaurus dominum',
      imageUrl: 'https://ark.wiki.gg/images/4/42/Dossier_Rex.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 32.0,
      maxTempCelsius: 34.0,
      baseIncubationSeconds: 18000, // 5 годин
      baseMaturationSeconds: 333300, // ~92 години 35 хвилин
      primaryFoodUa: "Сире м'ясо",
      primaryFoodEn: 'Raw Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 340,
      tipsUa:
          'Потрібно 2-3 кондиціонери або коло з вогнищ для вилуплення. Дитинча швидко набирає вагу, але перші 9 годин вимагає постійного ручного годування.',
    ),
    BreedingCreature(
      id: 'giga',
      nameUa: 'Гіганотозавр (Гіга)',
      nameEn: 'Giganotosaurus',
      species: 'Giganotosaurus furiosa',
      imageUrl: 'https://ark.wiki.gg/images/5/5f/Dossier_Giganotosaurus.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 43.0,
      maxTempCelsius: 44.0,
      baseIncubationSeconds: 180000, // 50 годин
      baseMaturationSeconds: 1008000, // 280 годин (~11.6 днів)
      primaryFoodUa: "Сире м'ясо",
      primaryFoodEn: 'Raw Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 950,
      tipsUa:
          'Найдовше вирощування в грі! Вимагає дуже високої температури (8+ кондиціонерів). Імпринт дає колосальний буст до здоров\'я та шкоди.',
    ),
    BreedingCreature(
      id: 'spino',
      nameUa: 'Спінозавр (Спіно)',
      nameEn: 'Spinosaurus',
      species: 'Spinosaurus aquareliga',
      imageUrl: 'https://ark.wiki.gg/images/e/e0/Dossier_Spinosaurus.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 30.0,
      maxTempCelsius: 32.0,
      baseIncubationSeconds: 13800, // 3 години 50 хвилин
      baseMaturationSeconds: 266640, // 74 години 4 хвилини
      primaryFoodUa: "Сира риба або м'ясо",
      primaryFoodEn: 'Raw Fish / Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 310,
      tipsUa:
          'Швидший у вирощуванні за Рекса. Спіно краще росте біля води, а риба дає відмінний ефект насичення.',
    ),
    BreedingCreature(
      id: 'argy',
      nameUa: 'Аргентавіс (Аргі)',
      nameEn: 'Argentavis',
      species: 'Argentavis magnificens',
      imageUrl: 'https://ark.wiki.gg/images/e/e5/Dossier_Argentavis.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 12.0,
      maxTempCelsius: 13.5,
      baseIncubationSeconds: 10560, // 2 години 56 хвилин
      baseMaturationSeconds: 200100, // 55 годин 35 хвилин
      primaryFoodUa: "Сире м'ясо",
      primaryFoodEn: 'Raw Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 220,
      tipsUa:
          'Вимагає холодної температури (12-13.5°C)! Ідеально інкубувати в сніговому біомі або з кондиціонерами.',
    ),
    BreedingCreature(
      id: 'ptera',
      nameUa: 'Птеранодон (Птера)',
      nameEn: 'Pteranodon',
      species: 'Pteranodon occidentalis',
      imageUrl: 'https://ark.wiki.gg/images/3/30/Dossier_Pteranodon.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 29.0,
      maxTempCelsius: 32.0,
      baseIncubationSeconds: 6000, // 1 година 40 хвилин
      baseMaturationSeconds: 133320, // 37 годин 2 хвилини
      primaryFoodUa: "Сире м'ясо",
      primaryFoodEn: 'Raw Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 140,
      tipsUa:
          'Швидке вилуплення та легкий старт для початкових літунів. Достатньо 2-3 смолоскипів для інкубації.',
    ),
    BreedingCreature(
      id: 'raptor',
      nameUa: 'Ютараптор (Раптор)',
      nameEn: 'Raptor',
      species: 'Utahraptor prime',
      imageUrl: 'https://ark.wiki.gg/images/1/14/Dossier_Raptor.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 20.0,
      maxTempCelsius: 28.0,
      baseIncubationSeconds: 7200, // 2 години
      baseMaturationSeconds: 133320, // 37 годин 2 хвилини
      primaryFoodUa: "Сире м'ясо",
      primaryFoodEn: 'Raw Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 130,
      tipsUa:
          'Широкий температурний діапазон, практично завжди вилуплюється за звичайної кімнатної температури острова.',
    ),
    BreedingCreature(
      id: 'trike',
      nameUa: 'Трицератопс (Трайк)',
      nameEn: 'Triceratops',
      species: 'Triceratops styrax',
      imageUrl: 'https://ark.wiki.gg/images/2/23/Dossier_Triceratops.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 22.0,
      maxTempCelsius: 27.0,
      baseIncubationSeconds: 9000, // 2 години 30 хвилин
      baseMaturationSeconds: 99960, // 27 годин 46 хвилин
      primaryFoodUa: 'Ягоди (Меджобері)',
      primaryFoodEn: 'Berries (Mejoberry)',
      foodPointsPerUnit: 20.0,
      baseBabyFoodPerHour: 280,
      tipsUa:
          'Травоїдний танк! Швидко дорослішає, вимагає багато стаків ягід у годівницях.',
    ),
    BreedingCreature(
      id: 'anky',
      nameUa: 'Анкілозавр (Анкі)',
      nameEn: 'Ankylosaurus',
      species: 'Ankylosaurus magniventris',
      imageUrl: 'https://ark.wiki.gg/images/8/87/Dossier_Ankylosaurus.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 16.0,
      maxTempCelsius: 20.0,
      baseIncubationSeconds: 9360, // 2 години 36 хвилин
      baseMaturationSeconds: 172800, // 48 годин
      primaryFoodUa: 'Ягоди / Овочі',
      primaryFoodEn: 'Berries / Crops',
      foodPointsPerUnit: 20.0,
      baseBabyFoodPerHour: 220,
      tipsUa:
          'Чудовий видобувач металу. Любить прохолодну температуру при вилупленні.',
    ),
    BreedingCreature(
      id: 'bary',
      nameUa: 'Баріонікс (Барі)',
      nameEn: 'Baryonyx',
      species: 'Baryonyx aquafulgur',
      imageUrl: 'https://ark.wiki.gg/images/9/91/Dossier_Baryonyx.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 29.0,
      maxTempCelsius: 35.0,
      baseIncubationSeconds: 7200, // 2 години
      baseMaturationSeconds: 172800, // 48 годин
      primaryFoodUa: 'Сира риба',
      primaryFoodEn: 'Raw Fish Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 180,
      tipsUa:
          'УВАГА: Їсть ВИКЛЮЧНО рибу! Звичайне сире м\'ясо не підходить, заготуйте багато сирої риби заздалегідь.',
    ),
    BreedingCreature(
      id: 'megalodon',
      nameUa: 'Мегалодон (Акула)',
      nameEn: 'Megalodon',
      species: 'Carcharocles megalodon',
      imageUrl: 'https://ark.wiki.gg/images/b/b5/Dossier_Megalodon.png',
      breedingType: BreedingType.gestation,
      minTempCelsius: null,
      maxTempCelsius: null,
      baseIncubationSeconds: 17940, // 4 години 59 хвилин (вагітність)
      baseMaturationSeconds: 259200, // 72 години
      primaryFoodUa: "Сире м'ясо",
      primaryFoodEn: 'Raw Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 300,
      tipsUa:
          'Живородна морська істота (вагітність замість яйця). Дитинча народжується у воді і потребує достатнього простору для руху.',
    ),
    BreedingCreature(
      id: 'thylacoleo',
      nameUa: 'Тилаколео (Сумчастий лев)',
      nameEn: 'Thylacoleo',
      species: 'Thylacoleo furtimorsus',
      imageUrl: 'https://ark.wiki.gg/images/4/4b/Dossier_Thylacoleo.png',
      breedingType: BreedingType.gestation,
      minTempCelsius: null,
      maxTempCelsius: null,
      baseIncubationSeconds: 14400, // 4 години (вагітність)
      baseMaturationSeconds: 168000, // ~46 годин 40 хвилин
      primaryFoodUa: "Сире м'ясо / Баранина",
      primaryFoodEn: 'Raw Meat / Mutton',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 240,
      tipsUa:
          'Ссавець: вагітність триває 4 години. Мати повинна мати достатньо їжі в інвентарі під час вагітності.',
    ),
    BreedingCreature(
      id: 'quetzal',
      nameUa: 'Кетцалькоатль (Кетцаль)',
      nameEn: 'Quetzalcoatlus',
      species: 'Quetzalcoatlus conchapicem',
      imageUrl: 'https://ark.wiki.gg/images/a/a2/Dossier_Quetzalcoatlus.png',
      breedingType: BreedingType.egg,
      minTempCelsius: 15.0,
      maxTempCelsius: 19.0,
      baseIncubationSeconds: 60000, // 16 годин 40 хвилин
      baseMaturationSeconds: 666600, // 185 годин 10 хвилин (~7.7 днів)
      primaryFoodUa: "Сире м'ясо",
      primaryFoodEn: 'Raw Meat',
      foodPointsPerUnit: 50.0,
      baseBabyFoodPerHour: 480,
      tipsUa:
          'Величезний літаючий транспорт. Довгий час інкубації та дорослішання, але повний імпринт робить його неймовірно витривалим.',
    ),
  ];
}
