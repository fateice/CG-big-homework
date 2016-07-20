
int lastx=-1,lasty=-1;
int nowx=-1,nowy=-1;
int x0,y0;
int cal=0;
int[][] c = new int[850][650];
void setup()
{
  smooth();
  background(255);
  size(800,600);
}

void drawline(int x1,int y1,int x2,int y2)
{

 
  int x = x1;
  int y = y1;
  int dx = abs(x2-x1);
  int dy = abs(y2-y1);
  int s1,s2;
  if(x2>x1)
  {
    s1 = 1;
  }
  else
  {
    s1= -1;
  }
  if(y2>y1)
  {
    s2 = 1;
  }
  else
  {
    s2 = -1;
  }
  boolean change = false;
  if(dy > dx)
  {
    int temp = dx;
    dx = dy;
    dy = temp;
    change = true;
  }
  int p = 2 * dy - dx;
  for(int i = 0;i<dx;i++)
  {
    point(x,y);
    if(p >=0)
    {
      if(!change)
      {
        y += s2;
      }
      else
      {
        x += s1;
      }
      p -= 2*dx;
    }
    if(!change)
    {
      x += s1;
    }
    else
    {
      y += s2;
    }
    p += 2 * dy;
  }
}

void floodfill(int x,int y,color fillcolor,color oldcolor,int dir)
{
  
  color cur;
  cur = get(x,y);
  int sy = (int)cur;
  if(sy == oldcolor)
  {
    if (dir==0)
    {
      stroke(fillcolor);
      point(x,y);
      floodfill(x+1,y,fillcolor ,oldcolor,1);
      floodfill(x-1,y,fillcolor ,oldcolor,2);
      floodfill(x+1,y-1,fillcolor ,oldcolor,3);
      floodfill(x,y-1,fillcolor ,oldcolor,4); 
      floodfill(x,y+1,fillcolor ,oldcolor,5);
    }
    if(dir == 1)
    {
      stroke(fillcolor);
      point(x,y);
      floodfill(x+1,y,fillcolor ,oldcolor,1);
      floodfill(x,y+1,fillcolor ,oldcolor,1);
    }
    if(dir == 2)
    {
      stroke(fillcolor);
      point(x,y);
      floodfill(x-1,y,fillcolor ,oldcolor,2);
      floodfill(x,y+1,fillcolor ,oldcolor,2); 
    }
    if(dir == 3)
    {
      stroke(fillcolor);
      point(x,y);
      floodfill(x+1,y,fillcolor ,oldcolor,3);
      floodfill(x,y-1,fillcolor ,oldcolor,3);
    }
    if(dir == 4)
    {
      stroke(fillcolor);
      point(x,y);
      floodfill(x-1,y,fillcolor ,oldcolor,4);
      floodfill(x,y-1,fillcolor ,oldcolor,4); 
    }
    if(dir == 5)
    {
      stroke(fillcolor);
      point(x,y);
      floodfill(x,y+1,fillcolor ,oldcolor,5);

    }
  }
}


color fillcolor = color(0,40,50);
color oldcolor = color(255,255,255);

int finish = 0;
int fillc=0;
void draw()
{
  //point(nowx,nowy);
  if(lastx != -1 && nowx != -1)
  {  
    if(finish == 0)
    {
      drawline(lastx,lasty,nowx,nowy);
    }
    if(fillc == 1)
    {
      floodfill(nowx,nowy,fillcolor,oldcolor,0); 
      //floodfill2(nowx,nowy,fillcolor,oldcolor,0); 
    }
    
  }
}

void mousePressed()
{

  
  lastx = nowx;
  lasty = nowy;
  nowx = mouseX;
  nowy = mouseY;
  if (cal==0)
  {
    x0 = nowx;
    y0 = nowy;
  }
  cal++;
}

void keyTyped()
{
  if(key == ' ')
  {
    fillc = 1;
  }
  if(key == 'q')
  {

    drawline(nowx,nowy,x0,y0);
    finish = 1;
  }

}