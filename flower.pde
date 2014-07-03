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

