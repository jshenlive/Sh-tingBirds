void enemyLevelUp() {
  if (maxEnemies < 10) {
    enemiesProperties.add(maxEnemies, new boolean[NUM_ENEMY_PROPERTIES]);
    newEnemies.add(maxEnemies, new Enemy(maxEnemies));
    birdFrame.add(0.0);
    enemiesProperties.get(maxEnemies)[SHOW]=true;
    maxEnemies++;
    levelUp = false;
  }
  if (score>0 && score % 5 ==0 && minEnemyScale > 0.75 && maxEnemyScale >= minEnemyScale) {
    minEnemyScale -= 0.01;
    maxEnemyScale -= 0.01;
    stepUp-=1;
  }
  System.out.println("Difficulty Increased!");
}

void playerLevelUp() {
  life++;
  System.out.println("Bonus Life!");
}
