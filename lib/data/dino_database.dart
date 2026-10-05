import '../models/dinosaur.dart';

class DinoDatabase {
  static const List<KnockoutWeapon> knockoutWeapons = [
    KnockoutWeapon(
      nameUa: 'Рогатка (Камінь)',
      nameEn: 'Slingshot (Stone)',
      icon: '🪨',
      baseTorporPerHit: 24.5,
      description: 'Початкова зброя, використовує каміння як снаряди.',
    ),
    KnockoutWeapon(
      nameUa: "Дерев'яна дубина",
      nameEn: 'Wooden Club',
      icon: '🪵',
      baseTorporPerHit: 25.0,
      description: 'Зброя ближнього бою для швидкого оглушення.',
    ),
    KnockoutWeapon(
      nameUa: 'Лук + Наркотична стріла',
      nameEn: 'Bow (Tranq Arrow)',
      icon: '🏹',
      baseTorporPerHit: 90.0,
      description: '40 миттєвого торпору + 50 протягом 5 секунд.',
    ),
    KnockoutWeapon(
      nameUa: 'Арбалет + Наркотична стріла',
      nameEn: 'Crossbow (Tranq Arrow)',
      icon: '🎯',
      baseTorporPerHit: 157.5,
      description: '70 миттєвого торпору + 87.5 протягом 5 секунд. Можна стріляти під водою.',
    ),
    KnockoutWeapon(
      nameUa: 'Гвинтівка + Дротик',
      nameEn: 'Longneck (Tranq Dart)',
      icon: '🔫',
      baseTorporPerHit: 221.0,
      description: '156 миттєво + 65 з часом. Низька смертельна шкода цілі.',
    ),
    KnockoutWeapon(
      nameUa: 'Гвинтівка + Покращений дротик',
      nameEn: 'Shocking Tranq Dart',
      icon: '⚡',
      baseTorporPerHit: 442.0,
      description: 'Шоковий дротик подвійної сили: 312 миттєво + 130 з часом.',
    ),
    KnockoutWeapon(
      nameUa: 'Електрошокер',
      nameEn: 'Electric Prod',
      icon: '🔋',
      baseTorporPerHit: 266.0,
      description: 'Миттєвий електричний розряд високої потужності.',
    ),
  ];

  static const List<Dinosaur> dinosaurs = [
    Dinosaur(
      id: 'rex',
      nameUa: 'Тиранозавр (Рекс)',
      nameEn: 'Rex (Tyrannosaurus)',
      species: 'Tyrannosaurus dominum',
      diet: DietType.carnivore,
      habitat: HabitatType.terrestrial,
      temperament: TemperamentType.aggressive,
      imageUrl: 'https://ark.wiki.gg/images/4/42/Dossier_Rex.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/4/42/Dossier_Rex.png',
      description:
          'Серед найсмертоносніших істот на острові, Tyrannosaurus dominum — це справжня машина для вбивства. Значно більший за будь-якого відомого науці тиранозавра, він є вершиною харчового ланцюга. Має величезний запас здоров\'я та нищівну силу укусу, а його грізний рев здатний оглушити дрібніших істот і змусити їх мимоволі випорожнитися від жаху. Є незамінним союзником для штурму ворожих баз і битв з босами Обелісків.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Rex',
      preferredKibble: 'Винятковий корм (Exceptional Kibble)',
      baseTorpor: 1550.0,
      torporPerLevel: 93.0,
      torporDrainRate: 0.73,
      speed: SpeedStats(
        walking: 480,
        running: 1104,
        swimming: 300,
      ),
      headshotMultiplier: 1.0,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Винятковий корм',
          nameEn: 'Exceptional Kibble',
          icon: '🥚',
          baseQuantity: 4,
          quantityPerLevel: 0.087, // ~17 at lvl 150
          baseTimeSeconds: 840,
          timePerLevelSeconds: 17.7, // ~58 min at lvl 150
          baseEffectiveness: 0.995,
          baseNarcotics: 0,
          narcoticsPerLevel: 0.1,
        ),
        TamingFoodItem(
          nameUa: 'Сира баранина',
          nameEn: 'Raw Mutton',
          icon: '🥩',
          baseQuantity: 8,
          quantityPerLevel: 0.181, // ~35 at lvl 150
          baseTimeSeconds: 1000,
          timePerLevelSeconds: 21.5, // ~1h 10m at lvl 150
          baseEffectiveness: 0.965,
          baseNarcotics: 5,
          narcoticsPerLevel: 0.23,
        ),
        TamingFoodItem(
          nameUa: 'Першосортне м\'ясо',
          nameEn: 'Raw Prime Meat',
          icon: '🍖',
          baseQuantity: 10,
          quantityPerLevel: 0.228, // ~44 at lvl 150
          baseTimeSeconds: 1250,
          timePerLevelSeconds: 27.0, // ~1h 28m at lvl 150
          baseEffectiveness: 0.938,
          baseNarcotics: 10,
          narcoticsPerLevel: 0.38,
        ),
        TamingFoodItem(
          nameUa: 'Сире м\'ясо',
          nameEn: 'Raw Meat',
          icon: '🍗',
          baseQuantity: 30,
          quantityPerLevel: 0.685, // ~132 at lvl 150
          baseTimeSeconds: 3750,
          timePerLevelSeconds: 81.0, // ~4h 24m at lvl 150
          baseEffectiveness: 0.760,
          baseNarcotics: 40,
          narcoticsPerLevel: 1.48,
        ),
      ],
    ),
    Dinosaur(
      id: 'spino',
      nameUa: 'Спінозавр',
      nameEn: 'Spinosaurus',
      species: 'Spinosaurus aquareliga',
      diet: DietType.piscivore,
      habitat: HabitatType.semiAquatic,
      temperament: TemperamentType.aggressive,
      imageUrl: 'https://ark.wiki.gg/images/4/45/Dossier_Spinosaur.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/4/45/Dossier_Spinosaur.png',
      description:
          'Гігантський напівводний хижак, який часто перевершує навіть Рекса за розмірами та маневреністю біля води. Володіє унікальною здатністю перемикатися між чотириногим і двоногим режимами бою, а також отримує колосальний водний бафф (Hydrated Buff) при контакті з водою, що значно прискорює його швидкість, регенерацію здоров\'я та силу атаки. Його раціон в основному складається з риби, але він без вагань нападе на будь-яку здобич.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Spinosaur',
      preferredKibble: 'Винятковий корм (Exceptional Kibble)',
      baseTorpor: 750.0,
      torporPerLevel: 45.0,
      torporDrainRate: 2.13, // Дуже швидке пробудження!
      speed: SpeedStats(
        walking: 510,
        running: 1224,
        swimming: 720,
      ),
      headshotMultiplier: 1.0,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Винятковий корм',
          nameEn: 'Exceptional Kibble',
          icon: '🥚',
          baseQuantity: 4,
          quantityPerLevel: 0.094, // ~18 at lvl 150
          baseTimeSeconds: 650,
          timePerLevelSeconds: 13.8, // ~45 min
          baseEffectiveness: 0.995,
          baseNarcotics: 20,
          narcoticsPerLevel: 0.61, // ~110 narcotics
        ),
        TamingFoodItem(
          nameUa: 'Сира баранина',
          nameEn: 'Raw Mutton',
          icon: '🥩',
          baseQuantity: 8,
          quantityPerLevel: 0.195, // ~37 at lvl 150
          baseTimeSeconds: 800,
          timePerLevelSeconds: 16.8, // ~55 min
          baseEffectiveness: 0.962,
          baseNarcotics: 35,
          narcoticsPerLevel: 1.04, // ~190
        ),
        TamingFoodItem(
          nameUa: 'Першосортна сира риба',
          nameEn: 'Raw Prime Fish Meat',
          icon: '🐟',
          baseQuantity: 10,
          quantityPerLevel: 0.242, // ~46 at lvl 150
          baseTimeSeconds: 990,
          timePerLevelSeconds: 21.0, // ~1h 09m
          baseEffectiveness: 0.940,
          baseNarcotics: 50,
          narcoticsPerLevel: 1.41, // ~260
        ),
        TamingFoodItem(
          nameUa: 'Сире м\'ясо',
          nameEn: 'Raw Meat',
          icon: '🍗',
          baseQuantity: 30,
          quantityPerLevel: 0.725, // ~138 at lvl 150
          baseTimeSeconds: 2980,
          timePerLevelSeconds: 63.5, // ~3h 27m
          baseEffectiveness: 0.755,
          baseNarcotics: 190,
          narcoticsPerLevel: 5.30, // ~980 narcotics
        ),
      ],
    ),
    Dinosaur(
      id: 'trike',
      nameUa: 'Трицератопс (Трайк)',
      nameEn: 'Triceratops (Trike)',
      species: 'Triceratops styrax',
      diet: DietType.herbivore,
      habitat: HabitatType.terrestrial,
      temperament: TemperamentType.neutral,
      imageUrl: 'https://ark.wiki.gg/images/3/36/Dossier_Trike.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/3/36/Dossier_Trike.png',
      description:
          'Один із найпоширеніших і найкорисніших травоїдних динозаврів для тих, хто тільки розпочинає виживання. Його масивний кістяний лобовий щит знижує отримувану шкоду та торпор у голову на приголомшливі 85%! Трайк володіє нищівним таранним ударом (Rivalry Buff) і здатний збирати колосальну кількість ягід і ягід наркоберрі, що робить його незамінним фермером на ранніх і середніх етапах гри.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Triceratops',
      preferredKibble: 'Простий корм (Simple Kibble)',
      baseTorpor: 250.0,
      torporPerLevel: 15.0,
      torporDrainRate: 0.33,
      speed: SpeedStats(
        walking: 190,
        running: 570,
        swimming: 300,
      ),
      headshotMultiplier: 0.15, // Head shield reduces torpor by 85%!
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Простий корм',
          nameEn: 'Simple Kibble',
          icon: '🥚',
          baseQuantity: 3,
          quantityPerLevel: 0.074, // ~14 at lvl 150
          baseTimeSeconds: 450,
          timePerLevelSeconds: 11.0, // ~35 min
          baseEffectiveness: 0.998,
          baseNarcotics: 0,
          narcoticsPerLevel: 0.0,
        ),
        TamingFoodItem(
          nameUa: 'Овочі (Кукурудза/Морква)',
          nameEn: 'Crops (Corn, Carrot)',
          icon: '🥕',
          baseQuantity: 12,
          quantityPerLevel: 0.295, // ~56 at lvl 150
          baseTimeSeconds: 1080,
          timePerLevelSeconds: 26.5, // ~1h 24m
          baseEffectiveness: 0.955,
          baseNarcotics: 2,
          narcoticsPerLevel: 0.07,
        ),
        TamingFoodItem(
          nameUa: 'Меджобері',
          nameEn: 'Mejoberry',
          icon: '🫐',
          baseQuantity: 16,
          quantityPerLevel: 0.396, // ~75 at lvl 150
          baseTimeSeconds: 1440,
          timePerLevelSeconds: 35.5, // ~1h 52m
          baseEffectiveness: 0.935,
          baseNarcotics: 5,
          narcoticsPerLevel: 0.13,
        ),
        TamingFoodItem(
          nameUa: 'Звичайні ягоди',
          nameEn: 'Berries',
          icon: '🍓',
          baseQuantity: 24,
          quantityPerLevel: 0.591, // ~112 at lvl 150
          baseTimeSeconds: 2160,
          timePerLevelSeconds: 53.0, // ~2h 48m
          baseEffectiveness: 0.855,
          baseNarcotics: 12,
          narcoticsPerLevel: 0.29,
        ),
      ],
    ),
    Dinosaur(
      id: 'pteranodon',
      nameUa: 'Птеранодон',
      nameEn: 'Pteranodon',
      species: 'Pteranodon wyvernus',
      diet: DietType.carnivore,
      habitat: HabitatType.flying,
      temperament: TemperamentType.passive,
      imageUrl: 'https://ark.wiki.gg/images/8/87/Dossier_Pteranodon.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/8/87/Dossier_Pteranodon.png',
      description:
          'Найперший доступний літаючий супутник виживалого. Птеранодон надзвичайно полохливий: від першого ж удару чи пострілу він злітає в небо, тому для його оглушення критично використовувати боласи (Bolas). Хоча він не може переносити важкі вантажі, його швидкість і здатність виконувати бочку (Aileron Roll) роблять його одним із найшвидших розвідників у повітряному просторі острова.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Pteranodon',
      preferredKibble: 'Звичайний корм (Regular Kibble)',
      baseTorpor: 120.0,
      torporPerLevel: 7.2,
      torporDrainRate: 0.40,
      speed: SpeedStats(
        walking: 165,
        running: 371,
        swimming: 150,
        flying: 600,
        sprintFlying: 1350,
      ),
      headshotMultiplier: 2.5,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Звичайний корм',
          nameEn: 'Regular Kibble',
          icon: '🥚',
          baseQuantity: 2,
          quantityPerLevel: 0.047, // ~9 at lvl 150
          baseTimeSeconds: 320,
          timePerLevelSeconds: 7.5, // ~24 min
          baseEffectiveness: 0.997,
          baseNarcotics: 2,
          narcoticsPerLevel: 0.05,
        ),
        TamingFoodItem(
          nameUa: 'Сира баранина',
          nameEn: 'Raw Mutton',
          icon: '🥩',
          baseQuantity: 4,
          quantityPerLevel: 0.094, // ~18 at lvl 150
          baseTimeSeconds: 390,
          timePerLevelSeconds: 9.1, // ~29 min
          baseEffectiveness: 0.968,
          baseNarcotics: 4,
          narcoticsPerLevel: 0.09,
        ),
        TamingFoodItem(
          nameUa: 'Першосортне м\'ясо',
          nameEn: 'Raw Prime Meat',
          icon: '🍖',
          baseQuantity: 5,
          quantityPerLevel: 0.121, // ~23 at lvl 150
          baseTimeSeconds: 480,
          timePerLevelSeconds: 11.2, // ~36 min
          baseEffectiveness: 0.945,
          baseNarcotics: 6,
          narcoticsPerLevel: 0.15,
        ),
        TamingFoodItem(
          nameUa: 'Сире м\'ясо',
          nameEn: 'Raw Meat',
          icon: '🍗',
          baseQuantity: 15,
          quantityPerLevel: 0.356, // ~68 at lvl 150
          baseTimeSeconds: 1450,
          timePerLevelSeconds: 33.8, // ~1h 48m
          baseEffectiveness: 0.785,
          baseNarcotics: 25,
          narcoticsPerLevel: 0.60,
        ),
      ],
    ),
    Dinosaur(
      id: 'baryonyx',
      nameUa: 'Баріонікс',
      nameEn: 'Baryonyx',
      species: 'Baryonyx aquafulgur',
      diet: DietType.piscivore,
      habitat: HabitatType.semiAquatic,
      temperament: TemperamentType.aggressive,
      imageUrl: 'https://ark.wiki.gg/images/7/70/Dossier_Baryonyx.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/7/70/Dossier_Baryonyx.png',
      description:
          'Ідеальний підводний і печерний хижак середнього розміру. У воді Баріонікс практично непереможний проти дрібних і середніх ворогів завдяки своїй здатності виконувати обертовий хвостовий удар, який повністю паралізує та оглушає жертву на кілька секунд. Приручений Баріонікс їсть ВИКЛЮЧНО рибу! Він вміє швидко бігати сушею, дихає під водою без обмеження кисню та зцілюється від кожної з\'їденої риби.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Baryonyx',
      preferredKibble: 'Звичайний корм (Regular Kibble)',
      baseTorpor: 400.0,
      torporPerLevel: 24.0,
      torporDrainRate: 0.58,
      speed: SpeedStats(
        walking: 400,
        running: 1060,
        swimming: 1050,
      ),
      headshotMultiplier: 1.0,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Звичайний корм',
          nameEn: 'Regular Kibble',
          icon: '🥚',
          baseQuantity: 2,
          quantityPerLevel: 0.054, // ~10 at lvl 150
          baseTimeSeconds: 440,
          timePerLevelSeconds: 10.3, // ~33 min
          baseEffectiveness: 0.994,
          baseNarcotics: 2,
          narcoticsPerLevel: 0.07,
        ),
        TamingFoodItem(
          nameUa: 'Першосортна сира риба',
          nameEn: 'Raw Prime Fish Meat',
          icon: '🐟',
          baseQuantity: 5,
          quantityPerLevel: 0.134, // ~25 at lvl 150
          baseTimeSeconds: 600,
          timePerLevelSeconds: 14.1, // ~45 min
          baseEffectiveness: 0.954,
          baseNarcotics: 5,
          narcoticsPerLevel: 0.15,
        ),
        TamingFoodItem(
          nameUa: 'Сира риба',
          nameEn: 'Raw Fish Meat',
          icon: '🐠',
          baseQuantity: 16,
          quantityPerLevel: 0.396, // ~75 at lvl 150
          baseTimeSeconds: 1800,
          timePerLevelSeconds: 42.2, // ~2h 15m
          baseEffectiveness: 0.795,
          baseNarcotics: 30,
          narcoticsPerLevel: 0.74,
        ),
      ],
    ),
    Dinosaur(
      id: 'megalodon',
      nameUa: 'Мегалодон',
      nameEn: 'Megalodon',
      species: 'Carcharodon megalodon',
      diet: DietType.carnivore,
      habitat: HabitatType.marine,
      temperament: TemperamentType.aggressive,
      imageUrl: 'https://ark.wiki.gg/images/f/f6/Dossier_Megalodon.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/f/f6/Dossier_Megalodon.png',
      description:
          'Володар океанічних глибин і головний жах для кожного, хто наважиться відплисти від узбережжя. Мегалодон має гострі, як бритва, щелепи, які накладають на жертву ефект кровотечі (Bleed Effect), що віднімає до 5% максимального здоров\'я цілі. У зграї акули отримують бафф альфи та бонус до опору й шкоди, перетворюючись на смертельну морську ескадру.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Megalodon',
      preferredKibble: 'Відмінний корм (Superior Kibble)',
      baseTorpor: 800.0,
      torporPerLevel: 48.0,
      torporDrainRate: 0.88,
      speed: SpeedStats(
        walking: 0,
        running: 0,
        swimming: 660,
      ),
      headshotMultiplier: 1.0,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Відмінний корм',
          nameEn: 'Superior Kibble',
          icon: '🥚',
          baseQuantity: 3,
          quantityPerLevel: 0.087, // ~16 at lvl 150
          baseTimeSeconds: 560,
          timePerLevelSeconds: 13.2, // ~42 min
          baseEffectiveness: 0.993,
          baseNarcotics: 5,
          narcoticsPerLevel: 0.13,
        ),
        TamingFoodItem(
          nameUa: 'Сира баранина',
          nameEn: 'Raw Mutton',
          icon: '🥩',
          baseQuantity: 7,
          quantityPerLevel: 0.168, // ~32 at lvl 150
          baseTimeSeconds: 680,
          timePerLevelSeconds: 16.0, // ~51 min
          baseEffectiveness: 0.960,
          baseNarcotics: 10,
          narcoticsPerLevel: 0.23,
        ),
        TamingFoodItem(
          nameUa: 'Першосортне м\'ясо',
          nameEn: 'Raw Prime Meat',
          icon: '🍖',
          baseQuantity: 9,
          quantityPerLevel: 0.208, // ~40 at lvl 150
          baseTimeSeconds: 850,
          timePerLevelSeconds: 20.1, // ~1h 04m
          baseEffectiveness: 0.932,
          baseNarcotics: 15,
          narcoticsPerLevel: 0.37,
        ),
        TamingFoodItem(
          nameUa: 'Сире м\'ясо',
          nameEn: 'Raw Meat',
          icon: '🍗',
          baseQuantity: 26,
          quantityPerLevel: 0.631, // ~120 at lvl 150
          baseTimeSeconds: 2560,
          timePerLevelSeconds: 60.4, // ~3h 12m
          baseEffectiveness: 0.748,
          baseNarcotics: 60,
          narcoticsPerLevel: 1.54,
        ),
      ],
    ),
    Dinosaur(
      id: 'ankylosaurus',
      nameUa: 'Анкілозавр (Анкі)',
      nameEn: 'Ankylosaurus (Anky)',
      species: 'Ankylosaurus crassacutis',
      diet: DietType.herbivore,
      habitat: HabitatType.terrestrial,
      temperament: TemperamentType.neutral,
      imageUrl: 'https://ark.wiki.gg/images/1/15/Dossier_Ankylosaurus.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/1/15/Dossier_Ankylosaurus.png',
      description:
          'Найкращий видобувач металу, кременю, обсидіану та кристалів в усьому ARK. Його тіло вкрите товстим кістяним панциром, а на кінці хвоста розташована масивна кістяна булава, здатна трощити найтвердіші гірські породи та розбивати броню хижаків. Приручений Анкілозавр знижує вагу сирого металу в своєму інвентарі на цілих 85%, що робить його незамінним у парі з Аргентавісом для гірничих експедицій.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Ankylosaurus',
      preferredKibble: 'Звичайний корм (Regular Kibble)',
      baseTorpor: 420.0,
      torporPerLevel: 25.2,
      torporDrainRate: 0.42,
      speed: SpeedStats(
        walking: 130,
        running: 384,
        swimming: 300,
      ),
      headshotMultiplier: 1.0,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Звичайний корм',
          nameEn: 'Regular Kibble',
          icon: '🥚',
          baseQuantity: 3,
          quantityPerLevel: 0.087, // ~16 at lvl 150
          baseTimeSeconds: 530,
          timePerLevelSeconds: 12.6, // ~40 min
          baseEffectiveness: 0.994,
          baseNarcotics: 3,
          narcoticsPerLevel: 0.07,
        ),
        TamingFoodItem(
          nameUa: 'Овочі (Кукурудза/Морква)',
          nameEn: 'Crops (Corn, Carrot)',
          icon: '🥕',
          baseQuantity: 14,
          quantityPerLevel: 0.336, // ~64 at lvl 150
          baseTimeSeconds: 1280,
          timePerLevelSeconds: 30.1, // ~1h 36m
          baseEffectiveness: 0.947,
          baseNarcotics: 12,
          narcoticsPerLevel: 0.29,
        ),
        TamingFoodItem(
          nameUa: 'Меджобері',
          nameEn: 'Mejoberry',
          icon: '🫐',
          baseQuantity: 18,
          quantityPerLevel: 0.450, // ~85 at lvl 150
          baseTimeSeconds: 1710,
          timePerLevelSeconds: 40.1, // ~2h 08m
          baseEffectiveness: 0.923,
          baseNarcotics: 18,
          narcoticsPerLevel: 0.45,
        ),
        TamingFoodItem(
          nameUa: 'Звичайні ягоди',
          nameEn: 'Berries',
          icon: '🍓',
          baseQuantity: 28,
          quantityPerLevel: 0.671, // ~128 at lvl 150
          baseTimeSeconds: 2560,
          timePerLevelSeconds: 60.2, // ~3h 12m
          baseEffectiveness: 0.840,
          baseNarcotics: 35,
          narcoticsPerLevel: 0.84,
        ),
      ],
    ),
    Dinosaur(
      id: 'raptor',
      nameUa: 'Раптор (Ютараптор)',
      nameEn: 'Raptor (Utahraptor)',
      species: 'Utahraptor prime',
      diet: DietType.carnivore,
      habitat: HabitatType.terrestrial,
      temperament: TemperamentType.aggressive,
      imageUrl: 'https://ark.wiki.gg/images/d/d3/Dossier_Raptor.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/d/d3/Dossier_Raptor.png',
      description:
          'Швидкий, смертоносний зграйний мисливець. Раптори володіють здатністю збивати виживалого з ніг і притискати до землі, що робить раптову зустріч із ними смертельно небезпечною для одиноких мандрівників. Мають лідерський клич, що підвищує силу всієї зграї. Завдяки своїй спритності та високим стрибкам є чудовими верховими тваринами для маневреного бою та швидкого дослідження суші.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Raptor',
      preferredKibble: 'Простий корм (Simple Kibble)',
      baseTorpor: 180.0,
      torporPerLevel: 10.8,
      torporDrainRate: 0.35,
      speed: SpeedStats(
        walking: 385,
        running: 1078,
        swimming: 300,
      ),
      headshotMultiplier: 3.0,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Простий корм',
          nameEn: 'Simple Kibble',
          icon: '🥚',
          baseQuantity: 2,
          quantityPerLevel: 0.047, // ~9 at lvl 150
          baseTimeSeconds: 260,
          timePerLevelSeconds: 6.3, // ~20 min
          baseEffectiveness: 0.996,
          baseNarcotics: 0,
          narcoticsPerLevel: 0.0,
        ),
        TamingFoodItem(
          nameUa: 'Сира баранина',
          nameEn: 'Raw Mutton',
          icon: '🥩',
          baseQuantity: 4,
          quantityPerLevel: 0.101, // ~19 at lvl 150
          baseTimeSeconds: 320,
          timePerLevelSeconds: 7.5, // ~24 min
          baseEffectiveness: 0.963,
          baseNarcotics: 2,
          narcoticsPerLevel: 0.04,
        ),
        TamingFoodItem(
          nameUa: 'Першосортне м\'ясо',
          nameEn: 'Raw Prime Meat',
          icon: '🍖',
          baseQuantity: 5,
          quantityPerLevel: 0.128, // ~24 at lvl 150
          baseTimeSeconds: 400,
          timePerLevelSeconds: 9.4, // ~30 min
          baseEffectiveness: 0.940,
          baseNarcotics: 3,
          narcoticsPerLevel: 0.08,
        ),
        TamingFoodItem(
          nameUa: 'Сире м\'ясо',
          nameEn: 'Raw Meat',
          icon: '🍗',
          baseQuantity: 15,
          quantityPerLevel: 0.376, // ~71 at lvl 150
          baseTimeSeconds: 1200,
          timePerLevelSeconds: 28.2, // ~1h 30m
          baseEffectiveness: 0.772,
          baseNarcotics: 14,
          narcoticsPerLevel: 0.34,
        ),
      ],
    ),
    Dinosaur(
      id: 'parasaur',
      nameUa: 'Паразауролоф (Паразавр)',
      nameEn: 'Parasaurolophus (Parasaur)',
      species: 'Parasaurolophus amphibio',
      diet: DietType.herbivore,
      habitat: HabitatType.terrestrial,
      temperament: TemperamentType.passive,
      imageUrl: 'https://ark.wiki.gg/images/c/c5/Dossier_Parasaur.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/c/c5/Dossier_Parasaur.png',
      description:
          'Найкращий друг і сторожовий пес для кожного виживалого на ранньому етапі гри. Паразавр спокійний і миролюбний, але володіє унікальною біолокаційною здатністю (Radar Scan): його гребінь може виявляти замаскованих ворогів і небезпечних хижаків поблизу та попереджати господаря звуковим сигналом. Також має здатність відлякувати своїм ревом дрібних хижаків (рапторів, дилофозаврів).',
      wikiUrl: 'https://ark.wiki.gg/wiki/Parasaur',
      preferredKibble: 'Базовий корм (Basic Kibble)',
      baseTorpor: 150.0,
      torporPerLevel: 9.0,
      torporDrainRate: 0.28,
      speed: SpeedStats(
        walking: 190,
        running: 532,
        swimming: 300,
      ),
      headshotMultiplier: 2.5,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Базовий корм',
          nameEn: 'Basic Kibble',
          icon: '🥚',
          baseQuantity: 2,
          quantityPerLevel: 0.047, // ~9 at lvl 150
          baseTimeSeconds: 240,
          timePerLevelSeconds: 5.6, // ~18 min
          baseEffectiveness: 0.998,
          baseNarcotics: 0,
          narcoticsPerLevel: 0.0,
        ),
        TamingFoodItem(
          nameUa: 'Овочі (Кукурудза/Морква)',
          nameEn: 'Crops (Corn, Carrot)',
          icon: '🥕',
          baseQuantity: 8,
          quantityPerLevel: 0.181, // ~35 at lvl 150
          baseTimeSeconds: 590,
          timePerLevelSeconds: 13.8, // ~44 min
          baseEffectiveness: 0.957,
          baseNarcotics: 1,
          narcoticsPerLevel: 0.02,
        ),
        TamingFoodItem(
          nameUa: 'Меджобері',
          nameEn: 'Mejoberry',
          icon: '🫐',
          baseQuantity: 10,
          quantityPerLevel: 0.248, // ~47 at lvl 150
          baseTimeSeconds: 780,
          timePerLevelSeconds: 18.1, // ~58 min
          baseEffectiveness: 0.938,
          baseNarcotics: 2,
          narcoticsPerLevel: 0.05,
        ),
        TamingFoodItem(
          nameUa: 'Звичайні ягоди',
          nameEn: 'Berries',
          icon: '🍓',
          baseQuantity: 15,
          quantityPerLevel: 0.369, // ~70 at lvl 150
          baseTimeSeconds: 1170,
          timePerLevelSeconds: 27.5, // ~1h 28m
          baseEffectiveness: 0.865,
          baseNarcotics: 5,
          narcoticsPerLevel: 0.11,
        ),
      ],
    ),
    Dinosaur(
      id: 'argentavis',
      nameUa: 'Аргентавіс (Аргі)',
      nameEn: 'Argentavis (Argy)',
      species: 'Argentavis atrocollum',
      diet: DietType.carnivore,
      habitat: HabitatType.flying,
      temperament: TemperamentType.aggressive,
      imageUrl: 'https://ark.wiki.gg/images/4/41/Dossier_Argentavis.png',
      backupImageUrl: 'https://static.wikia.nocookie.net/arksurvivalevolved_gamepedia/images/4/41/Dossier_Argentavis.png',
      description:
          'Король небес ARK і незамінний літаючий "вантажівка-верстат". Аргентавіс значно витриваліший за Птеранодона і здатний переносити у своїх кігтях істот середнього розміру (наприклад, вовка, раптора чи шаблезуба). Його сідло працює як мобільний верстак (Smithy), а в інвентарі вага металу, злитків, каменю, обсидіану та кристалів зменшується на 50%! Коли Аргентавіс поїдає тушу, він отримує шалений бафф швидкої регенерації здоров\'я.',
      wikiUrl: 'https://ark.wiki.gg/wiki/Argentavis',
      preferredKibble: 'Відмінний корм (Superior Kibble)',
      baseTorpor: 600.0,
      torporPerLevel: 36.0,
      torporDrainRate: 0.60,
      speed: SpeedStats(
        walking: 120,
        running: 300,
        swimming: 150,
        flying: 650,
        sprintFlying: 1350,
      ),
      headshotMultiplier: 3.0,
      tamingFoods: [
        TamingFoodItem(
          nameUa: 'Відмінний корм',
          nameEn: 'Superior Kibble',
          icon: '🥚',
          baseQuantity: 2,
          quantityPerLevel: 0.060, // ~11 at lvl 150
          baseTimeSeconds: 430,
          timePerLevelSeconds: 10.0, // ~32 min
          baseEffectiveness: 0.995,
          baseNarcotics: 2,
          narcoticsPerLevel: 0.08,
        ),
        TamingFoodItem(
          nameUa: 'Сира баранина',
          nameEn: 'Raw Mutton',
          icon: '🥩',
          baseQuantity: 5,
          quantityPerLevel: 0.114, // ~22 at lvl 150
          baseTimeSeconds: 510,
          timePerLevelSeconds: 11.9, // ~38 min
          baseEffectiveness: 0.965,
          baseNarcotics: 5,
          narcoticsPerLevel: 0.13,
        ),
        TamingFoodItem(
          nameUa: 'Першосортне м\'ясо',
          nameEn: 'Raw Prime Meat',
          icon: '🍖',
          baseQuantity: 6,
          quantityPerLevel: 0.141, // ~27 at lvl 150
          baseTimeSeconds: 630,
          timePerLevelSeconds: 14.8, // ~47 min
          baseEffectiveness: 0.942,
          baseNarcotics: 8,
          narcoticsPerLevel: 0.20,
        ),
        TamingFoodItem(
          nameUa: 'Сире м\'ясо',
          nameEn: 'Raw Meat',
          icon: '🍗',
          baseQuantity: 18,
          quantityPerLevel: 0.423, // ~81 at lvl 150
          baseTimeSeconds: 1910,
          timePerLevelSeconds: 44.4, // ~2h 22m
          baseEffectiveness: 0.770,
          baseNarcotics: 34,
          narcoticsPerLevel: 0.85,
        ),
      ],
    ),
  ];
}
