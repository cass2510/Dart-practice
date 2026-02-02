import 'character.dart';
import 'game.dart';

void main() {
  Character myCharacter = Character(name: '용사');

  Game game = Game(character: myCharacter);

  game.start();
}
