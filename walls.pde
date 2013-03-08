void walls() {
  floor = new Vertex[4];
  floor[0] = new Vertex(-1*WORLD_SIZE, -100, -1*WORLD_SIZE);
  floor[1] = new Vertex(-1*WORLD_SIZE, -100, WORLD_SIZE);
  floor[2] = new Vertex(WORLD_SIZE, -100, WORLD_SIZE);
  floor[3] = new Vertex(WORLD_SIZE, -100, -1*WORLD_SIZE);
  for(int i=0; i<4; i++) {
    floor[i].perspective();
    floor[i].screen();
  }
  
  /*ceiling = new Vertex[4];
  ceiling[0] = new Vertex(-1*WORLD_SIZE,WORLD_SIZE,-1*WORLD_SIZE);
  ceiling[1] = new Vertex(-1*WORLD_SIZE,WORLD_SIZE,WORLD_SIZE);
  ceiling[2] = new Vertex(WORLD_SIZE,WORLD_SIZE,WORLD_SIZE);
  ceiling[3] = new Vertex(WORLD_SIZE,WORLD_SIZE,-1*WORLD_SIZE);
  for(int i=0; i<4; i++) {
    ceiling[i].perspective();
    ceiling[i].screen();
  }*/
}
