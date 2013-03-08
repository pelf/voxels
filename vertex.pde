class Vertex {
  float dx, dy, dz;
  float x,y,z;

  Vertex() {}

  Vertex(float x, float y, float z) {
    this.x = x;
    this.dx = x;
    this.y = y;
    this.dy = y;
    this.z = z;
    this.dz = z;
    debug("Vertex created at "+x+", "+y+", "+z, 1);
  }

  Vertex dup(Vertex v) {
    if (v == null)
      v = new Vertex();
    v.x = this.x;
    v.y = this.y;
    v.z = this.z;
    return v;
  } 

  void camera(Vertex v){
    this.dx = this.x - v.x;
    this.dy = this.y - v.y;
    this.dz = this.z - v.z;
    debug("Vertex moved to "+dx+", "+dy+", "+dz, 1);
  }

  void rotate() {
    float tx;
    tx = this.dx * cam_cos - this.dz * cam_sin;
    this.dz = this.dz * cam_cos + this.dx * cam_sin;
    this.dx = tx;
    debug("Vertex rotated to "+dx+", "+dy+", "+dz, 2);
  }

  void perspective() {
    if (this.dz == 0)
      this.dz = 0.001;
    debug("Vertex before perspective was "+dx+", "+dy+", "+dz, 2);
    this.dx = ((this.dx) * SCALE) / (this.dz);
    this.dy = ((this.dy) * SCALE) / (this.dz);
    debug("Vertex perspective at "+dx+", "+dy+", "+dz, 2);
  }

  void screen() {
    this.dx += HALF_WIDTH;
    this.dy = this.dy*-1 + HALF_HEIGHT;
    debug("Vertex screen at "+dx+", "+dy, 2);
  }
  
  boolean projection() {
    // 1: shift cam pos
    this.camera(camera);
    // 2: rotate camera GOD HELP ME!
    this.rotate();
    // 3: perspective
    this.perspective();
    // 4: map screen coords
    this.screen();
    
    // inside the screen?
    // FIXME - fog of war
    return this.dz < 500 && (this.dx > 0 && this.dx < WIDTH) && (this.dy > 0 && this.dy < HEIGHT);
  }
}

