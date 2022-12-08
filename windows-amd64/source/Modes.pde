final char KEY_VIEW = 'r'; // switch between orthographic and perspective views

// player character
final char KEY_LEFT = 'a';
final char KEY_RIGHT = 'd';
final char KEY_UP = 'w';
final char KEY_DOWN = 's';
final char KEY_SHOOT = ' ';

// useful for debugging to turn textures or collisions on/off
final char KEY_TEXTURE = 't';
final char KEY_COLLISION = 'c';

final char KEY_BONUS = 'b';
final char KEY_NO_CONSTANT_SPEED = '-';
final char KEY_CONSTANT_SPEED = '=';
final char KEY_GODSHOT = '*';
final char KEY_RESET = 'p';

final char KEY_PLAYER1 = '1';
final char KEY_PLAYER2 = '2';
final char KEY_PLAYER3 = '3';

boolean doTextures = true;
boolean doCollision = true;
boolean doGodShot = false;

enum ViewMode {
  ORTHO,
    PERSPEC,
}

boolean orthoMode = true;
boolean perspecMode = false;

void keyPressed()
{
  if (key == KEY_VIEW) {
    orthoMode = !orthoMode;
    perspecMode = !perspecMode;
    if (orthoMode) {
      System.out.println("Current viewing mode: Ortho");
    } else {
      System.out.println("Current viewing mode: Perspective" );
    }
  }

  if (key == KEY_TEXTURE) {
    doTextures = !doTextures;
    System.out.println("doTextures: "+ doTextures);
  }

  if (key == KEY_LEFT) {
    bankLeft = true;
    moveLeft = true;
    newLife = false;
  }
  if (key == KEY_RIGHT) {
    bankRight = true;
    moveRight = true;
    newLife = false;
  }
  if (key == KEY_UP) {
    bankUp = true;
    moveUp = true;
    newLife = false;
  }
  if (key == KEY_DOWN) {
    bankDown = true;
    moveDown = true;
    newLife = false;
  }

  if (key == KEY_COLLISION) {
    doCollision = !doCollision;
    System.out.println("doCollision: "+ doCollision);
  }

  if (key == KEY_GODSHOT) {
    doGodShot = !doGodShot;
    System.out.println("doGodShot: "+ doGodShot);
  }

  if (key == KEY_RESET && gameOver) {
    resetGame();
    startGame = false;
    gameOver =!gameOver;
    System.out.println("Game restarted");
  }

  if (key == KEY_SHOOT && !isPlayerDead) {
    newLife = false;
    for (int i = 0; i < maxPlayerParticles; i++) {
      if (!newPlayer.showPlayerParticles[i]) {
        newPlayer.updatePlayerParticle(i);
        break;
      }
    }
  }

  if (key == KEY_CONSTANT_SPEED) {
    for (int i = 0; i< maxEnemies; i++) {
      enemiesProperties.get(i)[CONSTANT_SPEED]= true;
    }
  }
  if (key == KEY_NO_CONSTANT_SPEED) {
    for (int i = 0; i< maxEnemies; i++) {
      enemiesProperties.get(i)[CONSTANT_SPEED]= false;
    }
  }
  if (key == KEY_PLAYER1 && !startGame) {
    playerImg = loadImage("player1.png");
    ballImg = loadImage("ball1.png");
    startGame = true;
  }
  if (key == KEY_PLAYER2 && !startGame) {
    playerImg = loadImage("player2.png");
    ballImg = loadImage("ball2.png");
    startGame = true;
  }
  if (key == KEY_PLAYER3 && !startGame) {
    playerImg = loadImage("player3.png");
    ballImg = loadImage("ball3.png");
    startGame = true;
  }
}

void keyReleased() {
  if (key == KEY_LEFT) {
    bankLeft = false;
    moveLeft = false;
  }
  if (key == KEY_RIGHT) {
    bankRight = false;
    moveRight = false;
  }
  if (key == KEY_UP) {
    bankUp = false;
    moveUp = false;
  }
  if (key == KEY_DOWN) {
    bankDown = false;
    moveDown = false;
  }
}
