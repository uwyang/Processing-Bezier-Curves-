//click mouse to refresh flowers. 
//use "+" and "-" to change the "roundness" of the bezier curve --- 
//when roundness goes to negative regime, interesting things will happen. 


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
    drawFlowers();
    println(roundness);
  } 
  else if (key == '-' || key == '_') {
    roundness -= rStep;
    drawFlowers(); 
    println(roundness);
  }
}



