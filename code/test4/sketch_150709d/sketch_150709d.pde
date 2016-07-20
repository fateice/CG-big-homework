int r[] = {234,240,240,22,12,12,138};
int g[] = {24,113,245,242,171,71,18};
int b[] = {24,10,17,11,242,242,242};
int t = 0;
void setup()
{
  smooth();
  background(255);
  size(500,500);
}

int i=500;

void draw(){
  for(int i=0;i<7;i++)
  {
    rainbow(500,500,1000-i*20,r[i],g[i],b[i]);
    fill(255);
  }
  car(i,479,30);
  if(t==0)
  {
    i--;
  }
  if(t==1)
  {
    i++;
  }
  if(i<-50)
  {
    i=0;
    i++;
    t = 1;
  }
  if(i>500)
  {
    i=500;
    i--;
    t=0;
  }
}

void rainbow(int rx,int ry,int ra,int r,int g,int b){
  strokeWeight(10);
  stroke(r,g,b);
  ellipse(rx,ry,ra,ra);
  fill(255);
}

void car(int x,int y,int size)
{
  stroke(1);
  fill(122);
  rect(x,y,size,size/3);
  ellipse(x+size/10,y+size/2,size/5,size/5);
  ellipse(x+size,y+size/2,size/5,size/5);
}