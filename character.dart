class Character {
  String name;
  int level;
  int exp;
  int expToLevelUp;
  int hp;
  int maxHp;
  int attack;
  int defense;
  int gold;

  Character({
    required this.name,
    this.level = 1,
    this.exp = 0,
    this.expToLevelUp = 100,
    this.hp = 100,
    this.maxHp = 100,
    this.attack = 10,
    this.defense = 5,
    this.gold = 0,
  });

  void gainExp(int amount) {
    exp += amount;
    print('$amount 경험치를 획득했습니다!');

    while (exp >= expToLevelUp) {
      levelUp();
    }
  }

  void levelUp() {
    exp -= expToLevelUp;
    level++;
    maxHp += 20;
    hp = maxHp;
    attack += 5;
    defense += 2;
    expToLevelUp = (expToLevelUp * 1.2).toInt();

    print('레벨업! 현재 레벨: $level');
    print('HP +20 (최대 HP $maxHp)');
    print('공격력 +5 (현재 공격력 $attack)');
    print('방어력 +2 (현재 방어력 $defense)');
  }

  void takeDamage(int damage) {
    int actualDamage = (damage - defense ~/ 2).clamp(1, damage);
    hp -= actualDamage;
    if (hp < 0) hp = 0;
    print('$actualDamage의 피해를 입었습니다');
  }

  void heal(int amount) {
    int beforeHp = hp;
    hp = (hp + amount).clamp(0, maxHp);
    int actualHealing = hp - beforeHp;
    print('$actualHealing만큼 체력을 회복했습니다! (현재 HP $hp/$maxHp)');
  }

  void displayStatus() {
    print('캐릭터 정보');
    print('이름 : $name');
    print('레벨 : $level');
    print('HP : $hp/$maxHp');
    print('공격력 : $attack');
    print('방어력 : $defense');
    print('보유 골드 : $gold');
  }

  bool isAlive() {
    return hp > 0;
  }

  void gainGold(int amount) {
    gold += amount;
    print('$amount 골드 획득!');
  }
}
