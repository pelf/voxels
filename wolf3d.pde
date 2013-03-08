int DEBUG = 4;

int WIDTH = 640;
int HALF_WIDTH = WIDTH / 2;
int HEIGHT = 480;
int HALF_HEIGHT = HEIGHT / 2;

int WORLD_SIZE = 100;
int VOXEL_SIZE = 10;
int OPACITY = 255;
int SCALE = 1000;

float GROUND = 5;
float SPEED = 5;
float ROT_SPEED = PI/32;
float V_SPEED = 12;
float G = -3;

float v_speed = 0;
int jumps = 10;

Vertex camera;
Vertex[] floor, ceiling, wall1, wall2, wall3, wall4;
float camera_angle, cam_cos, cam_sin;

int VOXEL_COUNT = 50*50;
Voxel[] voxels;

boolean moved = true;
int drawn = 0;

void setup() {
  size(WIDTH, HEIGHT, P3D);
  background(255);
  fill(0);
  noStroke();
  //noLoop();
  frameRate(60);

  // game vars
  camera = new Vertex(0, GROUND, -100);
  camera_angle = 0;
  
  // walls
  //walls();

  voxels = new Voxel[VOXEL_COUNT];

  // voxels 
  for (int i=0;i<50;i++) {
    for (int j=0;j<50;j++) {
        voxels[i*50+j] = new Voxel(i*VOXEL_SIZE*4 - 102*VOXEL_SIZE, 0, j*VOXEL_SIZE*4 - 100*VOXEL_SIZE, color(random(150,200),random(200,250),random(200,250)));
    }
  }
  
  voxels[(int)random(VOXEL_COUNT)].c = color(250,100,100);

  textAlign(CENTER);
}


//////////////////////////////////////////////////////////////////
void draw() {
  background(255);
  
  cam_cos = cos(camera_angle);
  cam_sin = sin(camera_angle);
  
  // jumping ?
  if (v_speed > 0 || camera.y > GROUND) {
    camera.y += v_speed;
    v_speed += G;
    moved = true;
    // hit the ground?
    if (camera.y <= GROUND) {
      camera.y = GROUND; //adjust, just in case
      v_speed = 0;
    }
  }
  //debug(camera.y+" "+v_speed,4);
  
  if (moved) {
    // perspective
    for(int i=0; i<VOXEL_COUNT; i++) {
      voxels[i].projection();  
    }
    // draw order?
    sortV(voxels);
    
    moved = false;
  }
  
  drawn = 0;
  // draw
  for(int i=0; i<VOXEL_COUNT; i++) {
    voxels[i].draw();
  }
  
  //debug(drawn+" ",4);
  
  textSize(48);
  fill(175);
  text("touch the red voxel",HALF_WIDTH,60);
  textSize(32);
  fill(225);
  text("you have "+(jumps > 0 ? jumps : "no")+" " + (jumps == 1 ? "jump" : "jumps")+" left",HALF_WIDTH,100);
   
}
////////////////////////////////////////////////////////////////

void keyPressed() {
  if (keyCode == LEFT) {
    camera_angle -= ROT_SPEED;
  } else if (keyCode == RIGHT) {
    camera_angle += ROT_SPEED;
  }
  if (keyCode == UP) {
    camera.x += sin(camera_angle)*SPEED;
    camera.z += cos(camera_angle)*SPEED;
  } else if (keyCode == DOWN) {
    camera.x -= sin(camera_angle)*SPEED;
    camera.z -= cos(camera_angle)*SPEED;
  }
  if (key == 'q') {
    camera.y += 5;
  } else if (key == 'a') {
    //camera.y -= 5;
  } else if (jumps > 0 && key == 'z' && camera.y <= 5) {
    v_speed = V_SPEED;
    jumps--;
  }
  moved = true;
}



void debug(String s, int l) {
  if (l == DEBUG)
    println(s);
}

void sortV(Voxel[] x) {
    for (int i=0; i<x.length-1; i++) {
        int minIndex = i;
        for (int j=i+1; j<x.length; j++) {
            if (x[minIndex].corners[0].dz < x[j].corners[0].dz) {
                minIndex = j;  // remember index of new minimum
            }
        }
        if (minIndex != i) { 
            // exchange current element with smallest remaining.
            Voxel temp = x[i];
            x[i] = x[minIndex];
            x[minIndex] = temp;
        }
    }
}
