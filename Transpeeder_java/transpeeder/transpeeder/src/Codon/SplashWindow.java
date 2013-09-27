package Codon;

import java.awt.*;
import java.awt.event.*;

import javax.swing.*;

public class SplashWindow extends JWindow implements ActionListener{
    JLabel back=new JLabel() {
        public void paintComponent(Graphics g) {
        	ImageIcon background=new ImageIcon(codon.class.getResource("/images/test.jpg")); 
            // 图片随窗体大小而变化
            g.drawImage(background.getImage(), 0, 0, this.getSize().width,this.getSize().height,this);
        }
    };    

JProgressBar progressBar=new JProgressBar(1,100);//进度条
Timer timer;//时间组件
 public SplashWindow(){
	Container con=this.getContentPane(); 
	setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
	progressBar.setStringPainted(true);   //允许进度条显示文本
	progressBar.setString("正在加载程序......");
	con.add(back,"Center");
	con.add(progressBar,"South");
	setSize(400,300);
	toFront();        //使界面移到最前
	Dimension size = Toolkit.getDefaultToolkit().getScreenSize();
	setLocation((size.width-getWidth())/2,(size.height-getHeight())/2);
	setVisible(true);
	timer=new javax.swing.Timer(100, this);   //建立时间组件
	timer.addActionListener(this);
	timer.start();  //启动时间组件，开始计时，1/10秒后自动产生行为事件
 }
 
	public void actionPerformed(ActionEvent e) {
		if(progressBar.getValue()<100){
			progressBar.setValue(progressBar.getValue()+1);//设置进度条的值
			timer.restart();
		}else{
			timer.stop();  //停止时间
			dispose();    
			new codon();  //进入主窗口
		}		
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		new SplashWindow(); //建立窗口
		
	}

}
