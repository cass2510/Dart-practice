import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';

class Game {
  Character character;
  Random random = Random();
  bool isRunning = true;

  Game({required this.character});

  void start() {
    print('\n 캐릭터 성장 RPG 시작!');
    print('캐릭터 : ${character.name}');
    character.displayStatus();
    _mainMenu();
  }

  void _mainMenu() {
    while (isRunning) {
      print('\n[메인 메뉴]');
      print('1. 몬스터 사냥');
      print('2. 캐릭터 상태 확인');
      print('3. 게임 종료');
      print('선택 :');

      String? input = stdin.readLineSync();

      switch (input) {
        case '1':
          _battle();
          break;
        case '2':
          character.displayStatus();
          break;
        case '3':
          _endGame();
          break;
        default:
          print('잘못된 입력입니다.');
      }
    }
  }

  void _battle() {
    Monster monster = _spawnMonster();

    print('\n ${monster.name}이(가) 나타났다!');
    print('${monster.name} - Lv.${monster.level} (HP : ${monster.hp})');

    while (character.isAlive() && monster.isAlive()) {
      print('\n[전투 메뉴]');
      print('1. 공격');
      print('2. 회복 (HP 20 회복)');
      print('3. 도망');
      print('선택 :');

      String? input = stdin.readLineSync();

      switch (input) {
        case '1':
          _playerAttack(monster);
          break;
        case '2':
          character.heal(20);
          break;
        case '3':
          print('전투에서 도망쳤습니다');
          return;
        default:
          print('잘못된 입력입니다.');
          continue;
      }

      if (monster.isAlive()) {
        _monsterAttack(monster);
      }
    }

    if (character.isAlive()) {
      _winBattle(monster);
    } else {
      _loseBattle();
    }
  }

  void _playerAttack(Monster monster) {
    int damage = (character.attack * (0.8 + random.nextDouble() * 0.4)).toInt();

    print('${character.name}의 공격! ${monster.name}에게 $damage의 피해를 입혔습니다.');
    monster.takeDamage(damage);

    print('${monster.name}의 남은 HP : ${monster.hp}');
  }

  void _monsterAttack(Monster monster) {
    int damage = (monster.attack * (0.8 + random.nextDouble() * 0.4)).toInt();

    print('${monster.name}의 공격! $damage의 피해를 입었습니다');
    character.takeDamage(damage);

    print('${character.name} : ${character.hp} / ${character.maxHp}');
  }

  void _winBattle(Monster monster) {
    print('\n ${monster.name}을 쓰러뜨렸습니다!');
    character.gainExp(monster.expReward);
    character.gainGold(monster.goldReward);
  }

  void _loseBattle() {
    print('\n세상을 구하지 못했습니다...');
    character.hp = character.maxHp;
    int lostGold = (character.gold * 0.1).toInt();
    character.gold -= lostGold;
    print('$lostGold 골드를 잃었습니다...');
  }

  _spawnMonster() {
    List<String> monsterNames = ['고블린', '늑대', '오크', '스켈레톤', '드래곤'];
    String name = monsterNames[random.nextInt(monsterNames.length)];

    int monsterLevel = (character.level + random.nextInt(5) - 2).clamp(1, 999);

    int baseHp = 30 + (monsterLevel * 10);
    int attack = 8 + (monsterLevel * 2);
    int defense = 2 + (monsterLevel);
    int expReward = 50 * monsterLevel;
    int goldReward = 10 * monsterLevel;

    return Monster(
      name: name,
      level: monsterLevel,
      hp: baseHp,
      maxHp: baseHp,
      attack: attack,
      defense: defense,
      expReward: expReward,
      goldReward: goldReward,
    );
  }

  void _endGame() {
    print('\n게임을 종료합니다...');
    print('최종 기록');
    character.displayStatus();
    isRunning = false;
  }
}
