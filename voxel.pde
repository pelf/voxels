class Voxel {
  Vertex[] corners;
  color c;
  boolean draw = true;

  Voxel(int x, int y, int z, color c) {
    this.c = c;
    corners = new Vertex[8];
    // initialize corner coords
    // front face cw:
    // origin is closest-bottom-left corner
    corners[0] = new Vertex(x, y, z);
    corners[1] = new Vertex(x, y + VOXEL_SIZE, z);
    corners[2] = new Vertex(x + VOXEL_SIZE, y + VOXEL_SIZE, z);
    corners[3] = new Vertex(x + VOXEL_SIZE, y, z);
    // back face ccw (when viewed from the front)
    // first is farthest-bottom-right corner
    corners[4] = new Vertex(x + VOXEL_SIZE, y, z + VOXEL_SIZE);
    corners[5] = new Vertex(x + VOXEL_SIZE, y + VOXEL_SIZE, z + VOXEL_SIZE);
    corners[6] = new Vertex(x, y + VOXEL_SIZE, z + VOXEL_SIZE);
    corners[7] = new Vertex(x, y, z + VOXEL_SIZE);
  }


  void projection() {
    this.draw = true;
    
    debug("Projecting voxel ("+this.corners[0].x+","+this.corners[0].y+","+this.corners[0].z+")",2);
    
    // 3d projection steps:
    Vertex v;
    boolean d = false;
    for (int i=0; i<8; i++) {
      v = this.corners[i];
      d = v.projection() || d;
      // do not draw if behind me
      if (v.dz < VOXEL_SIZE) {
        this.draw = false;
        return;
      }
    }
    this.draw = d;
  }

  void draw() {
    debug("Drawing voxel ("+this.corners[0].x+","+this.corners[0].y+","+this.corners[0].z+")",2);
    // stop if behind - FIXME ?
    if (!this.draw) {
      return;
    }
    drawn += 1;
    
    // FIXME - fog of war
    int cz = (int)(this.corners[0].dz / 10.0);
    color c2 = color(red(this.c)+cz, green(this.c)+cz, blue(this.c)+cz);
    fill(c2, OPACITY);
    
    // draw quads
    // front face: 0,1,2,3
    quad(corners[0].dx,corners[0].dy, corners[1].dx,corners[1].dy, corners[2].dx,corners[2].dy, corners[3].dx,corners[3].dy);
    // back face: 4,5,6,7
    quad(corners[4].dx,corners[4].dy, corners[5].dx,corners[5].dy, corners[6].dx,corners[6].dy, corners[7].dx,corners[7].dy);
    // left face: 7,6,1,0
    quad(corners[7].dx,corners[7].dy, corners[6].dx,corners[6].dy, corners[1].dx,corners[1].dy, corners[0].dx,corners[0].dy);
    // right face: 3,2,5,4
    quad(corners[3].dx,corners[3].dy, corners[2].dx,corners[2].dy, corners[5].dx,corners[5].dy, corners[4].dx,corners[4].dy);
    // top face: 1,6,5,2
    quad(corners[1].dx,corners[1].dy, corners[6].dx,corners[6].dy, corners[5].dx,corners[5].dy, corners[2].dx,corners[2].dy);
    // bottom face: 7,0,3,4
    //quad(corners[7].dx,corners[7].dy, corners[0].dx,corners[0].dy, corners[3].dx,corners[3].dy, corners[4].dx,corners[4].dy);
  }
}
