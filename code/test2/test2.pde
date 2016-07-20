int movlenx = 100;
int movleny = 0;
//ping yi liang
int cen = 50;
//dui chen zhou
float sx = 2;
float sy = 2;
//fang da bi li
float tra = -30;


int xlen = 400;
int ylen = 300;
int[][] a=new int[xlen][ylen];
color[][] c=new color[xlen][ylen];
int finish = 0;
int finish1 = 0;
int finish2 = 0;
int finish3 = 0;
int finish4 = 0;
int finish5 = 0;
void setup()
{
  smooth();
  background(255);
  size(400, 300);
}

void draw()
{
  stroke(23,100,78);
  //ellipse(40,40,40,40);

  triangle(40, 40, 20, 80, 60, 100);
  if (finish == 0)
  {
    fun1();
  }
  if (finish1 == 1)
  {
    fun11();
  }
  if (finish2 == 1)
  {
    fun22();
  }
  if (finish3 == 1)
  {
    fun33();
  }
  if (finish4 == 1)
  {
    fun44();
  }
  if (finish5 == 1)
  {
    fun55();
  }
}

void fun1()
{
  color cur;

  for (int i=0; i<xlen; i++)
  {
    for (int j=0; j<ylen; j++)
    {
      cur = get(i, j);
      if (cur!=get(1, 1))
      {
        a[i][j] = 1;
        c[i][j] = cur;
      }
    }
  }
  finish = 1;
}

void fun11()
{
  for (int i=0; i<xlen; i++)
  {
    for (int j=0; j<ylen; j++)
    {
      if (a[i][j]==1)
      {
        stroke(c[i][j]);
        //stroke(0);
        point(i+movlenx, j+movleny);
      }
    }
  }
}

void keyTyped()
{
  if (key == 'q')
  {
    finish1 = 1;
  }
  if (key == 'w')
  {
    finish2 = 1;
  }
  if (key == 'e')
  {
    finish3 = 1;
  }
  if (key == 'r')
  {
    finish4 = 1;
  }
    if (key == 't')
  {
    finish5 = 1;
  }
}

void fun22()
{
  for (int i=0; i<xlen; i++)
  {
    for (int j=0; j<ylen; j++)
    {
      if (a[i][j] == 1)
      {
        stroke(c[i][j]);
        point(cen-i+cen, j);
      }
    }
  }
}

void fun33()
{
  for (int i=0; i<xlen; i++)
  {
    for (int j=0; j<ylen; j++)
    {
      if (a[i][j] == 1)
      {
        stroke(c[i][j]);
        point(i*sx, j*sy);
      }
    }
  }
}

void fun44()
{
  for (int i=0; i<xlen; i++)
  {
    for (int j=0; j<ylen; j++)
    {
      if (a[i][j] == 1)
      {
        stroke(c[i][j]); 
        point(i*cos(radians(tra))-j*sin(radians(tra)), i*sin(radians(tra))+j*cos(radians(tra))); //<>//
      } //<>//
    } //<>//
  } //<>//
}

void fun55()
{
  int midx = (40 + 20 + 60)/3;
  int midy = (40+80+100)/3;
  point(midx,midy);
  for (int i=0; i<xlen; i++)
  {
    for (int j=0; j<ylen; j++)
    {
      if (a[i][j] == 1)
      {
        stroke(c[i][j]);
        point(i+(i-midx),j+(j-midx)-midy/2);
      }
    }
  }
}