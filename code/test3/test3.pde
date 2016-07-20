float recx1 = 0;
float recy1 = 0;
float recx2 = 0;
float recy2 = 0;
int mmx,mmy,mmmx,mmmy;
int xf = 0;
int c = 0;

void setup()
{
  smooth();
  background(255);
  size(400,300);
}

class linea
{
  int px1;
  int py1;
  int px2;
  int py2;
  public void setlinea(int px1,int py1,int px2,int py2)
  {
    this.px1 = px1;
    this.py1 = py1;
    this.px2 = px2;
    this.py2 = py2;
  }
  public void drawlinea()
  {
    strokeWeight(1);
    stroke(0);
    line(px1,py1,px2,py2);
  }
}

void draw()
{
  int rx1 = 0;
  int ry1 = 0;
  int rx2 = 0;
  int ry2 = 0;
  //rect
  
  linea liena =  new linea();
  int px1 = 100;
  int py1 = 50;
  int px2 = 270;
  int py2 = 220;
  //point
  
  liena.setlinea(px1,py1,px2,py2);
  liena.drawlinea();
  if(xf == 2)
  {
    setup();
    strokeWeight(1);
    stroke(0);
    noFill();
    rect(recx1,recy1,recx2-recx1,recy2-recy1);
    rx1 = int(recx1);
    ry1 = int(recy1);
    rx2 = int(recx2);
    ry2 = int(recy2);
    //invis(px1,py1,px2,py2);
    
    if (c==0)
    {
      midcut(px1,py1,px2,py2,rx1,ry1,rx2,ry2);
    }
    stroke(0);
    line(mmx,mmy,mmmx,mmmy);
    
  }
}

void midcut(int px1,int py1, int px2,int py2,int rx1,int ry1,int rx2,int ry2)
{
  int ox1 = px1,oy1=py1,ox2 = px2,oy2 = py2;
  boolean fin = true;
  int mx=0, my =0,mx2=0,my2=0;
  //int tempx,tempy;
  while(fin == true)
  {
    if(px1 > rx1 && py1 > ry1 && px2 < rx2 && py2 < ry2)
    {
      mmx = px1;
      mmy = py1;
      mmmx = px2;
      mmmy = py2;
      return;
    }
    else if((rx1 > px1 && rx1 > px2)||(rx2<px1 && rx2<px2)||(ry1>py1 && ry1 > py2)||(ry2 < py1 && ry2 < py2))
    {
      return;
    }
    
    if (px2>rx1 && px2 < rx2 && py2 > ry1 && py2 < ry2)
    {
      mx = px2;
      my = py2;
      break;
    }
    
    mx = (px1 + px2)/2;
    my = (py1 + py2)/2;
    if((rx1 > mx && rx1 > px2)||(rx2 < mx && rx2<px2)||(ry1>py1 && my > py2)||(ry2 < my && ry2 < py2))
    {
      px2 = mx;
      py2 = my;
    }
    else
    {
      px1 = mx;
      py1 = my;
    }
    if(abs(px1 - px2)<2 && abs(py1 - py2)<2)
    {
      fin = false;
    }
  }
  //stroke(0);
  //line(mx,my,400,0);
  //px1 = ox2;
  //py1 = oy2;
  //px2 = ox1;
  //py2 = oy1;

  //fin = true;
  //while(fin == true)
  //{
  //  if(px2 > rx1 && py2 > ry1 && px1 < rx2 && py1 < ry2)
  //  {
  //    println('1');
  //    break;
  //  }
  //  else if((rx1 > px2 && rx1 > px1)||(rx2<px2 && rx2<px1)||(ry1>py2 && ry1 > py1)||(ry2 < py2 && ry2 < py1))
  //  {
  //    if(ry1 - my2>1)
  //    {
  //      my2 = my2+1;
  //    }
       
  //    else
  //    {
  //      println('2');
  //      break;
  //    }

  //  }
    
  //  if (px2>rx1 && px2 < rx2 && py2 > ry1 && py2 < ry2)
  //  {
  //    println('3');
  //    mx2 = px2;
  //    my2 = py2;
  //    break;
      
  //  }
    
  //  mx2 = (px1 + px2)/2;
  //  my2 = (py1 + py2)/2;
  //  if((rx1 > mx2 && rx1 > px2)||(rx2 < mx2 && rx2<px2)||(ry1>py1 && my2 > py2)||(ry2 < my2 && ry2 < py2))
  //  {
  //    px2 = mx2;
  //    py2 = my2;
  //  }
  //  else
  //  {
  //    px1 = mx2;
  //    py1 = my2;
  //  }
  //  if(abs(px1 - px2)<1 && abs(py1 - py2)<1)
  //  {
  //    println('f');
  //    fin = false;
  //  }    
  //}
  
  mmx = mx;
  mmy = my;
  
  ry2 = ry1;
  ry1 = ry1-2;
  py1 = oy1;
  py2 = oy2;
  px1 = ox1;
  px2 = ox2;
  fin = true; //<>//

  while(fin == true)
  {
    if(px1 > rx1 && py1 > ry1 && px2 < rx2 && py2 < ry2)
    {
      mmx = px1;
      mmy = py1;
      mmmx = px2;
      mmmy = py2;
      return;
    }
    else if((rx1 > px1 && rx1 > px2)||(rx2<px1 && rx2<px2)||(ry1>py1 && ry1 > py2)||(ry2 < py1 && ry2 < py2))
    {
      return;
    }
    
    if (px2>rx1 && px2 < rx2 && py2 > ry1 && py2 < ry2)
    {
      mx = px2;
      my = py2;
      break;
    }
    
    mx = (px1 + px2)/2;
    my = (py1 + py2)/2;
    if((rx1 > mx && rx1 > px2)||(rx2 < mx && rx2<px2)||(ry1>py1 && my > py2)||(ry2 < my && ry2 < py2))
    {
      px2 = mx;
      py2 = my;
    }
    else
    {
      px1 = mx;
      py1 = my;
    }
    if(abs(px1 - px2)<2 && abs(py1 - py2)<2) //<>//
    { //<>//
      fin = false;
    }
  }
  mmmx = mx;
  mmmy = my;
  //mmx = mx;
  //mmy = my;
  //mmmx = mx2;
  //mmmy = my2;
  
  //stroke(0);
  //strokeWeight(1);
  //line(mx,my,mx2,my2);

  c = 1;

 
}

void invis(int x1,int y1,int x2,int y2)
{
  strokeWeight(3);
  stroke(get(1,1));
  line(x1,y1,x2,y2);
}

void mousePressed()
{
  if(xf==0)
  {
    recx1 = mouseX;
    recy1 = mouseY;
    point(recx1,recy1);
    xf = 1;
  }
  else
  {
    recx2 = mouseX;
    recy2 = mouseY;
    xf = 2;
  }
}