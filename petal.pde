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
