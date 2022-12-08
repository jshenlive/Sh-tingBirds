final int TEXT_SIZE = 32;

final int FRAME_RATE = 60;
final int NUM_BIRD_FRAMES = 4;
final float ANIMATION_FR = 10;
final float ANIMATION_PER_FRAME = ANIMATION_FR/FRAME_RATE;

final float OBJECTS_Z = -0.9;

final int NUM_ENEMY_PROPERTIES = 2;

World newWorld;
Player newPlayer;
ArrayList<Enemy> newEnemies;
ArrayList<Float> birdFrame;
ArrayList<Flock> flock;
ArrayList<boolean[]> enemiesProperties;
PImage playerImg;
PImage poopImg;
PImage ballImg;
PImage featherImg;
PImage snowImg;
PImage tile1;
PImage tile2;
PImage over;
PImage side;
PImage start;
PImage[] birdMove = new PImage[NUM_BIRD_FRAMES];
PImage[] birdPoopMove = new PImage[NUM_BIRD_FRAMES];

int count = 0;
int timer = 0;
int score;
int life;
int bonus;
boolean levelUp;
boolean newLife;
//boolean increaseDifficulty;
boolean startGame;
boolean gameOver;

int maxPlayerParticles; //change on difficulty
int maxEnemies; //change on difficulty
int maxEnemyParticles; //change on difficulty

color black;
color white;
color yellow;
color red;

void setup() {
  size(640, 640, P3D); // change the dimensions if desired
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // use normalized 0..1 texture coords
  textureWrap(REPEAT);
  setupPOGL();
  setupProjections();
  resetMatrix(); // do this here and not in draw() so that you don't reset the camera

  black = color(0);
  white = color(1);
  yellow = color(240/255f, 225/255f, 110/255f);
  red = color(245/255f, 60/255f, 15/255f);

  //Load texture and animation files
  side = loadImage("column.jpg");
  over = loadImage("gameOver.png");
  //playerImg = loadImage("player0.png");
  //ballImg = loadImage("ball0.png");
  poopImg = loadImage("poop.png");
  featherImg = loadImage("feather.png");
  snowImg = loadImage("snow1.png");
  tile1 = loadImage("snow0.png");
  tile2 = loadImage("snow1.png");
  start = loadImage("start.png");

  //initiate game settings
  resetGame();
}

void resetGame() {
  //inital settings
  score = 0;
  maxPlayerParticles = 5; //change on difficulty
  maxEnemies = 1; //change on difficulty
  maxEnemyParticles = 3; //change on difficulty
  life = 2;
  bonus = 50;
  updateOrthoBounds();
  //initate objects
  initiateObjects();
}

void initiateObjects() {
  newWorld = new World();
  newPlayer = new Player();
  birdFrame = new ArrayList<>();
  newEnemies = new ArrayList<Enemy>();
  enemiesProperties = new ArrayList<>();
  flock = new ArrayList<>();

  initiateEnemies();
  setupBird();
}

void initiateEnemies() {
  for (int i = 0; i< maxEnemies; i++) {
    enemiesProperties.add(new boolean[NUM_ENEMY_PROPERTIES]);
    newEnemies.add(new Enemy(i));
    birdFrame.add(0.0);
  }
  enemiesProperties.get(0)[SHOW] = true;
}


void setupBird() {
  for (int i = 0; i<NUM_BIRD_FRAMES; i++) {
    birdMove[i] = loadImage("bird" + i + ".png");
    birdPoopMove[i] = loadImage("birdPoop" + i + ".png");
  }
}



void draw() {
  clear();
  background(1);

  if (orthoMode) {
    resetMatrix();

    setProjection(projectOrtho);
  } else {
    resetMatrix();
    setProjection(projectPerspective);
    camera(0, -1, 0.5,
      0, -0.7, 0,
      0, 0, 1);
  }


  pushMatrix();
  movingWorld();
  popMatrix();
  if (!startGame) {
    startGame();
  }

  if (startGame) {
    pushMatrix();
    textSize(TEXT_SIZE);
    translate(0, 0, OBJECTS_Z);
    scale(0.003, -0.003, 1);
    fill(black);
    text("Score: " + score +"   Life: " + life, -125, -300);
    popMatrix();

    if (!gameOver) {
      pushMatrix();
      movingPlayer();
      popMatrix();
    } else {
      pushMatrix();
      endGame();
      popMatrix();
    }

    pushMatrix();
    movingEnemy();
    pushMatrix();
    translate(0, 0, OBJECTS_Z);
    checkFlock();
    popMatrix();
    popMatrix();
    if (timer == 750) {
      enemyLevelUp();
      timer = 0;
    }

    timer++;
  }
}

void movingWorld() {
  count ++;
  if (count > (TOTAL_GRID_LENGTH+20)*2) {
    newWorld.newGrid();
    //changed = true;
    count = 0;
  }
  translate(0, -(float)count/200);
  newWorld.draw();
}

void movingPlayer() {
  newPlayer.draw();
}

void movingEnemy() {
  for (int i = 0; i<maxEnemies; i++) {
    newEnemies.get(i).draw();
  }
}

void checkFlock() {
  for (int i =0; i< flock.size(); i++) {
    Flock curr = flock.get(i);
    curr.run();
    curr.delete();
    if (curr.numNodes<1) {
      if (curr.isPlayer) {
        if (life == 0) {
          gameOver=true;
        } else {
          newPlayer = new Player();
          isPlayerDead = false;
          newLife = true;
        }
      }
      flock.remove(curr);
    }
  }
}

void startGame() {
  translate(0, 0, OBJECTS_Z);
  scale(1, 1, -0.1);
  noStroke();
  drawTextureSquare3D(start, OBJECTS_Z);
}


void endGame() {
  translate(0, 0, OBJECTS_Z);
  scale(1, 1, -0.1);
  noStroke();
  drawTextureSquare3D(over, OBJECTS_Z);
}
