
float roundness = 5;
float rStep = 0.1;
float angleAdd = 11;
float maxR = 20;
float tierStep = 2;
flower f;

float size = 120;

void setup() {
  size(800, 600);
  frameRate(25);
  
  drawFlowers();
}

void draw() {
}

void drawFlowers(){
  colorMode(RGB);
  background(255);
  int rowNum = ceil(height/size)+2;
  int colNum = ceil(width/size)+2;
  //float wMargin = (width - size*colNum)/2 + size/2;
  //float hMargin = (height - size*rowNum)/2 + size/2;
  float wMargin = (width - size*colNum)/2;
  float hMargin = (height - size*rowNum)/2;
  
  
  for(int i=0; i<colNum; i++){
    for(int j=0; j<rowNum; j++){
      int pointNum = (int)(3 + random(7));
      int currTierNum = (int)(2 + random(6));
      angleAdd = (PI/pointNum)*(0.95 + random(0.05));
      //tierStep = max(2, (maxR/((float)currTierNum))*(random(0.5) + 0.2));
      tierStep = 2 + random(1);
      pushMatrix();
      translate(wMargin + i*size, hMargin + j*size);
      drawFlower(pointNum, currTierNum);
      popMatrix();
      //println(i + " " + j);
    }
  }
}

void drawFlower(int numPetal, int numTiers) {
  float currR = maxR;
  float currA = 0;
  int baseColor = (int)random(255);

  for (int i=0; i< numTiers; i++) {
    float currColor = (float)i/numTiers;
    currColor = 255*currColor;
    /*colorMode(RGB);
    currColor = 255*(1- currColor);
     fill(currColor, 100);*/
    colorMode(HSB);
    fill(baseColor, currColor, 200, 200);
    f = new flower(numPetal, currR-=tierStep, currA+=angleAdd);
    f.roundness = roundness;
    drawFlowerTier(f);
  }
}


void drawFlowerTier(flower f) {
  f.initPetals();
  f.drawPetals();
  /*
  stroke(192, 0, 0);
   float w = abs((abs(f.roundness) -1)*f.petalSize);
   line(-w, 0, w, 0);
   line(0, -w, 0, w);
   */
}

void mouseClicked(){
  background(255);
  drawFlowers();
}

void keyPressed() {
  if(key == ENTER){
    saveFrame("flowers###.jpg");
  }
  
  if (key == '=' || key == '+' ) {
    roundness += rStep;
    //println(currDepth);
  } 
  else if (key == '-' || key == '_') {
    roundness -= rStep; 
    //println(currDepth);
  }
}



class flower {
  int petalNum = 5;
  float initAngle = random(2*PI);
  float roundness = 1;
  float petalSize = 50;
  float eachAngle = 2*PI/petalNum;
  petal[] petals = new petal[petalNum];
  PVector currVec;


  flower(int n) {
    setPetalNum(n);
  }

  flower(int n, float size, float a) {
    setPetalNum(n);
    this.petalSize = size;
    this.initAngle = a;
  }
  
  void setPetalNum(int n){
    this.petalNum = n;
    petals = new petal[petalNum];
    this.eachAngle = 2*PI/petalNum;
  }
  
  flower(int n, float size) {
    setPetalNum(n);
    this.petalSize = size;
  }


  void initPetals() {
    currVec = new PVector(cos(initAngle), sin(initAngle));
    currVec.mult(petalSize);
    for (int i=0; i<petalNum; i++) {
      petal currPetal = new petal(currVec, eachAngle);
      petals[i] = currPetal;
      currPetal.roundness = this.roundness;
      currVec = currPetal.endPt;
    }
  }

  void drawPetals() {
   
    PVector v1 = new PVector(100, 0);
    petal p1 = new petal(v1, PI/2);
    beginShape();
    for (int i=0; i< petalNum; i++) {
      petals[i].drawShape();
    }
    endShape();
  }
}

class petal{
  PVector startPt;
  PVector endPt;
  float angle; //rotate: clockwise
  PVector centerPt= new PVector(0, 0);
  float petalSize;
  float roundness=1;
  
  petal(PVector pt, float angle){
    this.startPt = pt;
    petalSize = startPt.mag();
    endPt = startPt.get();
    endPt.rotate(angle);
  }
  
  petal(PVector ptstart, PVector ptend){
    this.startPt = ptstart;
    this.endPt = ptend;
    this.angle = PVector.angleBetween(startPt, endPt);
  }
  
  void drawShape(){
    PVector lb = PVector.lerp(startPt, centerPt, roundness);
    PVector rb = PVector.lerp(endPt, centerPt, roundness);
    vertex(startPt.x, startPt.y);
    bezierVertex(lb.x, lb.y, rb.x, rb.y, endPt.x, endPt.y);
  }
  
  
}

