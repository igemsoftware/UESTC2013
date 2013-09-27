package Codon;
import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

import javax.swing.*;
public class ThreadDiag extends Thread
{
private Thread currentThread = null;//实际调用时就是TestThread事务处理线程
private String messages = "";//提示框的提示信息
private JFrame parentFrame = null;//提示框的父窗体
private JDialog clueDiag = null;// “线程正在运行”提示框
private Dimension dimensions = Toolkit.getDefaultToolkit().getScreenSize();
private int width = dimensions.width / 4, height = 60;
public ThreadDiag(JFrame parentFrame, Thread currentThread, String messages)
{
this.parentFrame = parentFrame;
this.currentThread = currentThread;
this.messages = messages;
initDiag();//初始化提示框
}
protected void initDiag()
{
clueDiag = new JDialog(parentFrame,"Running",true);
clueDiag.setCursor(new Cursor(Cursor.WAIT_CURSOR));
JPanel testPanel = new JPanel();
JLabel testLabel = new JLabel(messages);
clueDiag.getContentPane().add(testPanel);
testPanel.add(testLabel);
clueDiag.setDefaultCloseOperation(JDialog.DO_NOTHING_ON_CLOSE);
clueDiag.addWindowListener(new WindowAdapter(){
public void windowClosing(WindowEvent e) {
	Object[] possibilities = { "Yes", "No" };
	 int result=JOptionPane.showOptionDialog(null, "Do you really want to quit?", "Warning", 
			 JOptionPane.YES_NO_OPTION,JOptionPane.INFORMATION_MESSAGE, null, possibilities, possibilities[0]);
	 if(result==JOptionPane.YES_NO_OPTION)
	    {
		 currentThread.interrupt();				
		}
    }
});
(new DisposeDiag()).start();//启动关闭提示框线程
}
@SuppressWarnings("deprecation")
public void run()
{
//显示提示框
int left = (dimensions.width - width)/2;
int top = (dimensions.height - height)/2;
clueDiag.setSize(new Dimension(width,height));
clueDiag.setLocation(left, top);
clueDiag.show();
}
class DisposeDiag extends Thread{
public void run(){
    try{
        currentThread.join();//等待事务处理线程结束
       }catch(InterruptedException e){
        System.out.println("Exception:" + e);
         }
        clueDiag.dispose();//关闭提示框
    }
  }
}
