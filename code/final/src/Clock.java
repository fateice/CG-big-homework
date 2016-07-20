import java.awt.*;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.image.BufferedImage;
import java.net.*;
import java.text.*;
import java.util.*;

import javax.swing.*;

@SuppressWarnings("serial")
public class Clock extends JFrame{
	private GregorianCalendar now = new GregorianCalendar();	//现在的时间对象
	private ClockLabel clockLabel = new ClockLabel();
	private JLabel weekLabel = new JLabel();	//星期标签
	private JLabel dateLabel = new JLabel();	//日期标签
	private JLabel remarkLabel = new JLabel();	
	private JLabel timeLabel = new JLabel();	//时间标签，指示时间
	
	//主界面
	public Clock(){
		setTitle("Clock");
		setSize(500,480);
		setLocation(100,100);
		init();
		setResizable(false);
	}
	
	//初始化
	private void init(){
		//remarkLabel.setText("MyClock");
		remarkLabel.setLocation(225, 80);
		remarkLabel.setSize(100,30);
		remarkLabel.setFont(new Font("Bookman Old Style",Font.BOLD,15));
		remarkLabel.setForeground(Color.darkGray);
		
		weekLabel.setSize(60,20);
		weekLabel.setLocation(315, 190);
		weekLabel.setForeground(Color.darkGray);
		weekLabel.setFont(new Font("Arial Narrow",Font.BOLD,12));
		
		//星期标签赋值
		int week = now.get(Calendar.DAY_OF_WEEK);
		switch(week){
		case 1:
			weekLabel.setText("Sunday");
			break;
		case 2:
			weekLabel.setText("Monday");
			break;
		case 3:
			weekLabel.setText("Tuesday");
			break;
		case 4:
			weekLabel.setText("Wednesday");
			break;
		case 5:
			weekLabel.setText("Thursday");
			break;
		case 6:
			weekLabel.setText("Friday");
			break;
		case 7:
			weekLabel.setText("Saturday");
			break;
		}
		
		//初始化日期标签
		dateLabel.setSize(20,20);
		dateLabel.setLocation(370, 190);
		dateLabel.setForeground(Color.darkGray);
		dateLabel.setFont(new Font("Fixedsys",Font.BOLD,12));
		//设置日期标签的值
		dateLabel.setText("" + now.get(Calendar.DATE));
		
		//初始化时间标签
		timeLabel.setSize(500,30);
		timeLabel.setLocation(100, 400);
		timeLabel.setForeground(new Color(0,64,128));
		timeLabel.setFont(new Font("Fixedsys",Font.PLAIN,15));
		
		//添加各组件
		Container con = getContentPane();
		con.setBackground(Color.white);
		con.setLayout(null);
		con.add(weekLabel);
		con.add(dateLabel);
		con.add(remarkLabel);
		con.add(timeLabel);
		con.add(clockLabel);		
	}
	
	public static void main(String[] args){
		Clock clock = new Clock();
		clock.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		clock.setVisible(true);
	}
	 
	//画一个钟
	class ClockLabel extends JLabel implements Runnable{
		private final int WIDTH = 500;
		private final int HEIGHT = 440;
		
		private final int CIRCLE_X_RADIUS = 150;
		private final int CIRCLE_Y_RADIUS = 155;
		
		private final int CIRCLE_X = 250;
		private final int CIRCLE_Y = 200;
		
		
		private final int HOUR_LENGTH = 50;
		private final int MIN_LENGTH = 80;
		private final int SEC_LENGTH = 100;
		
		//指针的角度
		double arcHour = 0;
		double arcMin = 0;
		double arcSec = 0;
		
		//透明度
		int alpha = 50;
		//true表示越来越透明
		boolean flag = false;
		//背景图ID
		int imageID = 0;
		Image img[] = new Image[5];
		//背景图URL
		URL url[] = new URL[]{
			ClockLabel.class.getResource("image/1.jpg"),
			ClockLabel.class.getResource("image/2.jpg"),
		    ClockLabel.class.getResource("image/3.jpg"),
			ClockLabel.class.getResource("image/4.jpg"),
			ClockLabel.class.getResource("image/5.jpg"),
			ClockLabel.class.getResource("image/6.jpg"),
		}; 
		
		//一个具有缓冲区的图像对象
		BufferedImage bufferedImage = null;
		int imageSize = 2*Math.max(CIRCLE_X_RADIUS, CIRCLE_Y_RADIUS);
		Graphics bufferedImageGraphics = null;
		
		//时钟线程，因为时钟每秒都要动一次
		Thread clockThread = null;
		
		public ClockLabel(){
			this.setSize(WIDTH,HEIGHT);
			arcHour = now.get(Calendar.HOUR)*30;
			arcMin = now.get(Calendar.MINUTE)*6;
			arcSec = now.get(Calendar.SECOND)*6;
			
			Toolkit tk = this.getToolkit();
			img[0]=tk.createImage(url[0]);
			img[1]=tk.createImage(url[1]);
			img[2]=tk.createImage(url[2]);
			img[3]=tk.createImage(url[3]);
			img[4]=tk.createImage(url[4]);
			try{
				//使用MediaTracker加载图片对象
				MediaTracker mt = new MediaTracker(this);
				mt.addImage(img[0], 0);
				mt.addImage(img[1], 0);
				mt.addImage(img[2], 0);
				mt.addImage(img[3], 0);
				mt.addImage(img[4], 0);
				mt.waitForAll();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			//一个有缓冲的Image对象
			bufferedImage = new BufferedImage(imageSize,imageSize,BufferedImage.TYPE_INT_ARGB);
			bufferedImageGraphics = bufferedImage.createGraphics();
			
			//启动线程
			clockThread = new Thread(this);
			clockThread.start();
		}
		
		public void paint(Graphics g1){
			Graphics2D g = (Graphics2D) g1;
			for(int i=0;i<360;i = i + 6){
				g.setColor(Color.blue);
				g.setStroke(new BasicStroke(2));
				
				if(i%90==0){
					g.setStroke(new BasicStroke(5));
					g.drawLine(CIRCLE_X+(int)(Math.cos(i*Math.PI/180)*CIRCLE_X_RADIUS),
							CIRCLE_Y+(int)(Math.sin(i*Math.PI/180)*CIRCLE_Y_RADIUS), 
							CIRCLE_X+(int)(Math.cos(i*Math.PI/180)*CIRCLE_X_RADIUS),
							CIRCLE_Y+(int)(Math.sin(i*Math.PI/180)*CIRCLE_Y_RADIUS));
				}else if(i%30==0){
					g.setColor(Color.red);
					g.drawLine(CIRCLE_X+(int)(Math.cos(i*Math.PI/180)*CIRCLE_X_RADIUS),
							CIRCLE_Y+(int)(Math.sin(i*Math.PI/180)*CIRCLE_Y_RADIUS), 
							CIRCLE_X+(int)(Math.cos(i*Math.PI/180)*CIRCLE_X_RADIUS),
							CIRCLE_Y+(int)(Math.sin(i*Math.PI/180)*CIRCLE_Y_RADIUS));
				}else{
					g.drawLine(CIRCLE_X+(int)(Math.cos(i*Math.PI/180)*CIRCLE_X_RADIUS),
							CIRCLE_Y+(int)(Math.sin(i*Math.PI/180)*CIRCLE_Y_RADIUS), 
							CIRCLE_X+(int)(Math.cos(i*Math.PI/180)*CIRCLE_X_RADIUS),
							CIRCLE_Y+(int)(Math.sin(i*Math.PI/180)*CIRCLE_Y_RADIUS));
				}
			}
			
			Line2D.Double lh = new Line2D.Double(CIRCLE_X,CIRCLE_Y,CIRCLE_X+Math.cos((arcHour-90)*Math.PI/180)*HOUR_LENGTH,CIRCLE_Y+Math.sin((arcHour-90)*Math.PI/180)*HOUR_LENGTH);
			
			g.setStroke(new BasicStroke(6));
			g.setColor(new Color(0,128,0));
			
			g.draw(lh);
			
			
			Line2D.Double lm = new Line2D.Double(CIRCLE_X,CIRCLE_Y,CIRCLE_X+Math.cos((arcMin-90)*Math.PI/180)*MIN_LENGTH,CIRCLE_Y+Math.sin((arcMin-90)*Math.PI/180)*MIN_LENGTH);
			g.setStroke(new BasicStroke(3));
			g.setColor(new Color(0,128,192));
			g.draw(lm);
			
			
			Line2D.Double ls = new Line2D.Double(CIRCLE_X,CIRCLE_Y,CIRCLE_X+Math.cos((arcSec-90)*Math.PI/180)*SEC_LENGTH,CIRCLE_Y+Math.sin((arcSec-90)*Math.PI/180)*SEC_LENGTH);
			g.setStroke(new BasicStroke(1));
			g.setColor(new Color((int)(Math.random()*255),(int)(Math.random()*255),(int)(Math.random()*255)));
			g.draw(ls);
			
			
			bufferedImageGraphics.drawImage(img[imageID],0,0,imageSize,imageSize,0,0,imageSize+10,imageSize+10,this);

			for(int j=0;j<imageSize;j++){
				for(int i=0;i<imageSize;i++){
					int pix = bufferedImage.getRGB(i,j);
					Color c = new Color(pix);
					int r = c.getRed();
					int gr = c.getGreen();
					int b = c.getBlue();
					int newpix = new Color(r,gr,b,alpha).getRGB();
					bufferedImage.setRGB(i,j,newpix);
				}
			}
			
			g.clip(new Ellipse2D.Double(95, 45, imageSize, imageSize));
			g.setColor(Color.white);
			g.drawImage(bufferedImage, 95, 45, this);
		}
		
		public void run(){
			try{
				while(clockThread!=null){
					DateFormat df = DateFormat.getDateTimeInstance(DateFormat.FULL,DateFormat.FULL);
					String s = df.format(new Date());
					timeLabel.setText(s);
					
					arcSec += 6;
					arcMin += 0.1;
					arcHour += 0.1/60;
					if(arcSec >= 360){
						arcSec = 0;
					}
					if(arcMin >= 360){
						arcMin = 0;
					}
					if(arcHour >= 360){
						arcHour = 0;
					}
					if(flag){
						alpha += 10;
						if(alpha==50){
							flag =! flag;
						}
					}else{
						alpha -= 10;
						if(alpha == 0){
							flag =! flag;
							imageID++;
							if(imageID==4){
								imageID = 0;
							}
						}
					}
					repaint();
					Thread.sleep(1000);
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
}






