class Agent {
  final String id;
  final String name;
  final String image;
  final String? fullImage;
  final String rarity;
  final String attribute;
  final AgentDetails? details;

  Agent({
    required this.id,
    required this.name,
    required this.image,
    this.fullImage,
    required this.rarity,
    required this.attribute,
    this.details,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    return Agent(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        fullImage: json['fullImage'],
        rarity: json['rarity'],
        attribute: json['attribute'],
        details: json['details'] != null
            ? AgentDetails.fromJson(json['details'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'fullImage': fullImage,
      'rarity': rarity,
      'attribute': attribute,
      'details': details?.toJson(),
    };
  }
}

class AgentDetails {
  final String description;
  final List<Ability> abilities;
  final Stats stats;
  final String backstory;

  AgentDetails({
    required this.description,
    required this.abilities,
    required this.stats,
    required this.backstory,
  });

  factory AgentDetails.fromJson(Map<String, dynamic> json) {
    return AgentDetails(
      description: json['description'],
      abilities: List<Ability>.from(
          json['abilities'].map((ability) => Ability.fromJson(ability))),
      stats: Stats.fromJson(json['stats']),
      backstory: json['backstory'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'abilities': abilities.map((ability) => ability.toJson()).toList(),
      'stats': stats.toJson(),
      'backstory': backstory,
    };
  }
}

class Ability {
  final String name;
  final String description;
  final int cooldown;
  final dynamic damage;
  final dynamic effect;

  Ability({
    required this.name,
    required this.description,
    required this.cooldown,
    this.damage,
    this.effect,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      name: json['name'],
      description: json['description'],
      cooldown: json['cooldown'],
      damage: json['damage'],
      effect: json['effect'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'cooldown': cooldown,
      'damage': damage,
      'effect': effect,
    };
  }
}

class Stats {
  final int hp;
  final int attack;
  final int defense;
  final int speed;
  final int critRate;
  final int critDamage;

  Stats({
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.critRate,
    required this.critDamage,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      hp: json['hp'],
      attack: json['attack'],
      defense: json['defense'],
      speed: json['speed'],
      critRate: json['critRate'],
      critDamage: json['critDamage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'speed': speed,
      'critRate': critRate,
      'critDamage': critDamage,
    };
  }
}
