package Codon;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.FileDialog;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.Frame;
import java.awt.GridLayout;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JMenuBar;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.text.BadLocationException;
import javax.swing.text.DefaultCaret;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.w3c.dom.Document;
import org.biojava.bio.BioException;
import org.biojava.bio.seq.Sequence;
import org.biojava.bio.seq.SequenceIterator;
import org.biojava.bio.seq.io.SeqIOTools;
import org.dom4j.io.OutputFormat;
import org.dom4j.io.SAXReader;
import org.dom4j.io.SAXValidator;
import org.dom4j.io.XMLWriter;
import org.dom4j.util.XMLErrorHandler;
import org.w3c.dom.NodeList;

public class codon extends JFrame {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public JMenuBar mb;
	public JPanel contentPane;
	public JPanel inputPane;
	public JPanel buttonPane;
	public JPanel formatPane;
	public JPanel upPane;
	public JPanel examplePane;
	public JPanel sePane;
	public JPanel aPane;
	public JPanel sPane;
	public JPanel allPane;
	public JPanel uploadPane;
	public JPanel outPane;
	public JPanel bioPane;
	public JPanel sdPane;
	public JLabel mLabel;
	public JLabel biobrick;
	public JLabel format;
	public JLabel brief;
	public JLabel shine;
	public JLabel bai;
	public JLabel kong;
	public JLabel mLabelSeq;
	public JLabel mLabelOut;
	public JLabel upload;
	public JTextArea mTxtSeq;
	public JButton mBtnReset;
	public JButton mBtn;
	public JButton file;
	public JButton fasta;
	public JButton genbank;
	public JButton sbol;
	public static JComboBox<String> choice;
	public static JComboBox<String> number;
	public static JComboBox<String> select;
	public static JComboBox<String> sd;
//	public JSplitPane sPane;
	public JTextArea outTxtArea;
	public JFrame testFrame;
	public JLabel backgroundLabel;
	public ImageIcon background;
	private String output;
	private String s;
	private FileDialog fd;
	private String sequ;

	public codon() {
		mb=new JMenuBar();
		contentPane = new JPanel();
		inputPane = new JPanel();
		uploadPane = new JPanel();
		buttonPane = new JPanel();
		upPane = new JPanel();
		examplePane = new JPanel();
		bioPane = new JPanel();
		formatPane = new JPanel();
		allPane = new JPanel();
		sePane = new JPanel();
		sdPane = new JPanel();
		aPane = new JPanel();
		sPane = new JPanel();
		outPane = new JPanel();
		mLabel = new JLabel();
		bai = new JLabel();
		kong = new JLabel();
		biobrick = new JLabel();
		format = new JLabel();
		shine = new JLabel();
		brief = new JLabel();
		mLabelSeq = new JLabel();
		mLabelOut = new JLabel();
		upload = new JLabel();
		mTxtSeq = new JTextArea(5,5);
		mBtnReset = new JButton();
		mBtn = new JButton();
		file = new JButton();
		fasta = new JButton();
		genbank = new JButton();
		sbol = new JButton();
		choice=new JComboBox<String>();
		number=new JComboBox<String>();
		select=new JComboBox<String>();
		sd=new JComboBox<String>();
	//	sPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT);
		outTxtArea = new JTextArea(7,5);
		backgroundLabel = new JLabel("");
		background = new ImageIcon();
		init();
		testFrame = this;
	}

	@SuppressWarnings( "static-access" )
	public void init() {
		  int width = Toolkit.getDefaultToolkit().getScreenSize().width;
		  int height = Toolkit.getDefaultToolkit().getScreenSize().height;
		  this.setLocation(width / 2-380 , height / 2-370 );
		
		this.setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);	// 设置关闭框架不结束程序	
		addWindowListener(new WindowAdapter(){
			public void windowClosing(WindowEvent e){
				Object[] possibilities = { "Yes", "No" };
				 int result=JOptionPane.showOptionDialog(null, "Do you really want to quit Transpeeder?", "Warning", 
						 JOptionPane.YES_NO_OPTION,JOptionPane.INFORMATION_MESSAGE, null, possibilities, possibilities[0]);
				 if(result==JOptionPane.YES_NO_OPTION)
				 {
					System.exit(0);				
					}
				 else
				 {
					setVisible(true);
				 }
			}
		});
		
		this.setResizable(true);// 设置框架可以改变大小
	//	this.setLocation(427, 200);
		this.setSize(760, 740);// 设置框架大小为长700,宽500
		this.setTitle("Transpeeder");// 设置框架标题
		
		//设置背景图片		
/*		this.background = new ImageIcon(codon.class.getResource("/images/1.jpg"));
        this.addComponentListener(new ComponentAdapter(){      //为主面板添加窗口监听器  
            @Override  
            public void componentResized(ComponentEvent e)  
            {                   
            	background.setImage(background.getImage().getScaledInstance(getWidth(),getHeight(),Image.SCALE_DEFAULT));   
            	backgroundLabel.setIcon(background);  
            	backgroundLabel.setSize(getWidth(),getHeight());  
            }  
        });
    	this.getLayeredPane().add(backgroundLabel, new Integer(Integer.MIN_VALUE));*/
		this.setBackground(Color.decode("#f9e6a2"));
       
/*      this.setJMenuBar(mb);
        JMenu fileMenu=new JMenu("File");
        JMenu help=new JMenu("Help");
        mb.add(fileMenu);
        mb.add(help);  
        final CardLayout layout = new CardLayout();
        final Container container = getContentPane();
        container.setLayout(layout);
        container.add(contentPane, "contentPane");
        fileMenu.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent arg0) {
            	 layout.show(container, "contentPane");
            }});*/    
        
        
		this.contentPane.setLayout(new BorderLayout(2, 2));// 设置面板布局管理			

	//	 this.mLabel.setForeground(Color.yellow);// 设置标签字体颜色
		
		this.mLabel.setText("1.Type/paste sequences below:");// 设置标签标题
		this.mLabel.setFont(new Font(Font.SANS_SERIF, 16, 20));// 设置标签字体
		this.choice.addItem("DNA");
		this.choice.addItem("Protein");
		this.upPane.setLayout(new FlowLayout(0));
		this.upPane.add(mLabel);
		this.upPane.add(choice);
		this.upPane.setOpaque(false);
		
		this.upload.setText("Or upload sequences:");
		this.upload.setFont(new Font(Font.DIALOG, 16, 20));
		this.file.setText("Open File");
		this.uploadPane.setLayout(new FlowLayout(0));
		this.uploadPane.add(upload);
		this.uploadPane.add(file);
		this.uploadPane.setOpaque(false);
		
		this.biobrick.setText("Or choose the device's name in IGEM:");// 设置标签标题
		this.biobrick.setFont(new Font(Font.SANS_SERIF, 16, 20));// 设置标签字体
		this.number.addItem("");
		this.number.addItem("BBa_C0040");
		this.number.addItem("BBa_C0050");
		this.number.addItem("BBa_C0051");
		this.number.addItem("BBa_C0052");
		this.number.addItem("BBa_C0053");
		this.number.addItem("BBa_C0056");
		this.number.addItem("BBa_C0060");
		this.number.addItem("BBa_C0061");
		this.number.addItem("BBa_C0062");
		this.number.addItem("BBa_C0070");
		this.number.addItem("BBa_C0071");
		this.number.addItem("BBa_C0072");
		this.number.addItem("BBa_C0073");
		this.number.addItem("BBa_C0074");
		this.number.addItem("BBa_C0075");
		this.number.addItem("BBa_C0076");
		this.number.addItem("BBa_C0077");
		this.number.addItem("BBa_C0078");
		this.number.addItem("BBa_C0079");
		this.number.addItem("BBa_C0080");
		this.number.addItem("BBa_C0082");
		this.number.addItem("BBa_C0083");
		this.number.addItem("BBa_C0160");
		this.number.addItem("BBa_C0161");
		this.number.addItem("BBa_C0170");
		this.number.addItem("BBa_C0171");
		this.number.addItem("BBa_C0178");
		this.number.addItem("BBa_C0179");
		this.number.addItem("BBa_C2001");
		this.number.addItem("BBa_C2006");		
		this.number.addItem("BBa_E0020");
		this.number.addItem("BBa_E0030");
		this.number.addItem("BBa_E1010");
		this.number.addItem("BBa_E2050");		
		this.number.addItem("BBa_I11021");
		this.number.addItem("BBa_I11031");
		this.number.addItem("BBa_I15008");
		this.number.addItem("BBa_I15009");
		this.number.addItem("BBa_I715022");
		this.number.addItem("BBa_I715032");
		this.number.addItem("BBa_I716155");
		this.number.addItem("BBa_I716210");
		this.number.addItem("BBa_I732006");
		this.number.addItem("BBa_I732100");
		this.number.addItem("BBa_I732101");
		this.number.addItem("BBa_I732105");
		this.number.addItem("BBa_I732106");
		this.number.addItem("BBa_I732107");
		this.number.addItem("BBa_I732110");
		this.number.addItem("BBa_I732112");
		this.number.addItem("BBa_I732115");
		this.number.addItem("BBa_I742107");
		this.number.addItem("BBa_I746200");	
		this.number.addItem("BBa_J22101");
		this.number.addItem("BBa_J52011");
		this.number.addItem("BBa_J52021");		
		this.number.addItem("BBa_K079015");
		this.number.addItem("BBa_K082003");
		this.number.addItem("BBa_K082006");
		this.number.addItem("BBa_K112306");
		this.number.addItem("BBa_K112806");
		this.number.addItem("BBa_K117000");
		this.number.addItem("BBa_K118000");
		this.number.addItem("BBa_K118001");
		this.number.addItem("BBa_K118002");
		this.number.addItem("BBa_K118003");
		this.number.addItem("BBa_K118008");
		this.number.addItem("BBa_K118015");
		this.number.addItem("BBa_K118016");
		this.number.addItem("BBa_K118022");
		this.number.addItem("BBa_K118023");
		this.number.addItem("BBa_K118028");
		this.number.addItem("BBa_K137001");
		this.number.addItem("BBa_K145151");
		this.number.addItem("BBa_K190028");
		this.number.addItem("BBa_K294055");
		this.number.addItem("BBa_K592009");
		this.number.addItem("BBa_K592100");
		this.number.addItem("BBa_K629003");
		this.number.addItem("BBa_K629005");
		this.number.addItem("BBa_K748002");
		this.number.addItem("BBa_K777113");
		this.number.addItem("BBa_K777117");
		this.number.addItem("BBa_K808010");
		this.number.addItem("BBa_K808025");
		this.number.addItem("BBa_K849000");
		this.number.addItem("BBa_K849003");
		this.number.addItem("BBa_K849004");
		this.number.addItem("BBa_K863001");
		this.number.addItem("BBa_K863006");
		this.number.addItem("BBa_K863011");
		this.number.addItem("BBa_K863021");
		this.number.addItem("BBa_K864100");
		this.number.addItem("BBa_K864201");
		this.number.addItem("BBa_K864202");
		this.number.addItem("BBa_K864203");
		this.number.addItem("BBa_K864204");
		this.number.addItem("BBa_K907000");
		
		this.bioPane.setLayout(new FlowLayout(0));
		this.bioPane.add(biobrick);
		this.bioPane.add(number);
		this.bioPane.setOpaque(false);

		this.brief.setText("The extension for *.seq, *.fasta, *.faa, *.rdf, *.gbk, *.gb, *.fas or *.txt are allowed.");// 设置标签标题
		this.brief.setFont(new Font(Font.SANS_SERIF, 16, 16));// 设置标签字体
		
		this.aPane.setLayout(new BorderLayout());
		this.aPane.add(uploadPane,BorderLayout.NORTH);
		this.aPane.add(brief,BorderLayout.CENTER);
		this.aPane.add(bioPane,BorderLayout.SOUTH);	
		this.aPane.setOpaque(false);
		
		this.inputPane.setLayout(new BorderLayout(1, 1));
		mTxtSeq.setLineWrap(true);// 激活自动换行功能
		mTxtSeq.setWrapStyleWord(true);// 激活断行不断字功能
		JScrollPane jsp1 = new JScrollPane(mTxtSeq);
		// 直接把含有JTextArea组件的滚动条添加到窗体
		inputPane.add(jsp1, BorderLayout.CENTER);
		this.mTxtSeq.setFont(new Font(Font.SANS_SERIF, 16, 20));
		((DefaultCaret) mTxtSeq.getCaret()).setUpdatePolicy(DefaultCaret.ALWAYS_UPDATE);
		this.mLabelSeq.setText(" Input: ");
		this.mLabelSeq.setFont(new Font(Font.DIALOG, 16, 21));
		this.bai.setText("    ");
		this.inputPane.add(upPane, BorderLayout.NORTH);// 加载标签到面板
		this.inputPane.add(mLabelSeq, BorderLayout.WEST);
		this.inputPane.add(aPane, BorderLayout.SOUTH);
		this.inputPane.add(bai, BorderLayout.EAST);
		// this.inputPane.add(mTxtSeq, BorderLayout.CENTER);
		this.inputPane.setOpaque(false);
		
		this.format.setText("2.Select the sequences format you submited:");// 设置标签标题
		this.format.setFont(new Font(Font.SANS_SERIF, 16, 20));// 设置标签字体
		this.select.addItem("FASTA");
		this.select.addItem("GENBANK");
		this.select.addItem("SBOL");
		this.formatPane.setLayout(new FlowLayout(0));
		this.formatPane.add(format);
		this.formatPane.add(select);
		this.formatPane.setOpaque(false);
		
		this.examplePane.setLayout(new FlowLayout(0));
		this.fasta.setText("Example of Fasta");
		this.genbank.setText("Example of Genbank");
		this.sbol.setText("Example of SBOL");
		this.examplePane.add(fasta);
		this.examplePane.add(genbank);
		this.examplePane.add(sbol);
		this.examplePane.setOpaque(false);
		
		this.shine.setText("3.Select the Shine-Dalgarno sequence:");// 设置标签标题
		this.shine.setFont(new Font(Font.SANS_SERIF, 16, 20));// 设置标签字体
		this.sd.addItem("----E.coli----");
		this.sdPane.setLayout(new FlowLayout(0)); 
		this.sdPane.add(shine);
		this.sdPane.add(sd);
		this.sdPane.setOpaque(false);
		
		this.sePane.setLayout(new GridLayout(2,1));
		this.sePane.add(formatPane);
		this.sePane.add(examplePane);
		this.sePane.setOpaque(false);
		
		this.allPane.setLayout(new GridLayout(2,1));
		this.allPane.add(sePane);
		this.allPane.add(sdPane);
		this.allPane.setOpaque(false);

		this.mLabelOut.setText("Output: ");
		this.mLabelOut.setFont(new Font(Font.DIALOG, 16, 18));
		this.kong.setText("    ");
		outTxtArea.setLineWrap(true);
		outTxtArea.setWrapStyleWord(true);
		JScrollPane jsp2 = new JScrollPane(outTxtArea);
		outTxtArea.setFont(new Font("Serif",0,20));
		this.outPane.setLayout(new BorderLayout());
		this.outPane.add(jsp2, BorderLayout.CENTER);
		this.outPane.add(mLabelOut, BorderLayout.WEST);
		this.outPane.add(kong, BorderLayout.EAST);
		this.outPane.setOpaque(false);		
		
		this.sPane.setLayout(new BorderLayout(5, 10));
		this.sPane.add(inputPane,BorderLayout.NORTH);
		this.sPane.add(allPane,BorderLayout.CENTER);
		this.sPane.add(outPane,BorderLayout.SOUTH);
	//	this.sPane.setDividerLocation(300);
		this.sPane.setOpaque(false);
		
		this.mBtnReset.setText("reset");
		this.mBtn.setText("submit");
		this.buttonPane.add(mBtnReset);
		this.buttonPane.add(mBtn);
		this.buttonPane.setOpaque(false);
		
//		this.contentPane.add(aPane, BorderLayout.PAGE_START);

		this.contentPane.add(sPane, BorderLayout.CENTER);
		this.contentPane.add(buttonPane, BorderLayout.SOUTH);	
		this.contentPane.setOpaque(false);
		
		this.setContentPane(contentPane);
		this.setVisible(true);// 加载面板到框架

		fasta.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				sequ="";
				mTxtSeq.setText("");
				outTxtArea.setText("");
				file.setText("Open File");
				number.setSelectedItem("");
				select.setSelectedItem("FASTA");
				
//         		 String url = codon.class.getClass().getResource("/").getPath().replaceAll("%20", " ");
//                 System.out.println(url);
//                 String path = url+ "Codon/";
                 try {
//                	 File file = new File(path+"fasta.txt");    
//					FileReader fr = new FileReader(file);    
//					BufferedReader br = new BufferedReader(fr);  
                	 
                	 InputStream is=this.getClass().getResourceAsStream("/Codon/fasta.txt"); 
                	 BufferedReader br=new BufferedReader(new InputStreamReader(is));
					String aline=null; 
					while ((aline = br.readLine()) != null)//按行读取文本 
					{	sequ+=aline+"\n";
						}
//					fr.close();
					br.close();					
	                mTxtSeq.setText(sequ);
				}
				catch (IOException ioe){             
					System.out.println(ioe);       
					}				
			}
		});		
		genbank.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				sequ="";
				mTxtSeq.setText("");
				outTxtArea.setText("");
				file.setText("Open File");
				number.setSelectedItem("");
				select.setSelectedItem("GENBANK");

                 try {
                	 InputStream is=this.getClass().getResourceAsStream("/Codon/genbank.txt"); 
                	 BufferedReader br=new BufferedReader(new InputStreamReader(is));
					String aline=null; 
					while ((aline = br.readLine()) != null)//按行读取文本 
					{	sequ+=aline+"\n";
						}
					br.close();
	                mTxtSeq.setText(sequ);
				}
				catch (IOException ioe){             
					System.out.println(ioe);       
					}
			}
		});		
		sbol.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				sequ="";
				mTxtSeq.setText("");
				outTxtArea.setText("");
				file.setText("Open File");
				number.setSelectedItem("");
				select.setSelectedItem("SBOL");

             try {
            	 InputStream is=this.getClass().getResourceAsStream("/Codon/sbol.txt"); 
            	 BufferedReader br=new BufferedReader(new InputStreamReader(is));
				String aline=null; 
				while ((aline = br.readLine()) != null)//按行读取文本 
				{	sequ+=aline+"\n";
					}
//				fr.close();
				br.close();
                mTxtSeq.setText(sequ);
			}
			catch (IOException ioe){             
				System.out.println(ioe);       
				}			
			}
		});
		

		mBtnReset.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				mTxtSeq.setText("");
				outTxtArea.setText("");
				file.setText("Open File");
				number.setSelectedItem("");
			}
		});
		file.addActionListener(new ActionListener()  {
			public void actionPerformed(ActionEvent e) {
				file.setText("Open File");
				Frame f = new Frame();
				mTxtSeq.setText("");
				outTxtArea.setText("");
				fd = new FileDialog(f, "Open",FileDialog.LOAD);    
				fd.setVisible(true);   //创建并显示打开文件对话框     
				if ((fd.getDirectory()!=null) && (fd.getFile()!=null)){
				if (fd.getFile().contains(".")){
				    String dire=fd.getFile().substring(fd.getFile().indexOf("."));
					if(dire.equals(".seq")||dire.equals(".fasta")||dire.equals(".faa")||dire.equals(".rdf")
					  ||dire.equals(".gbk")||dire.equals(".gb")||dire.equals(".fas")||dire.equals(".txt")) {       
					file.setText(fd.getFile());  				
					}
					else{
						JOptionPane.showMessageDialog(null,
								"File Type Error!"+"\n"+"The file type must be: *.seq,*.fasta,*.faa,*.rdf,,*.gbk,*.gb ,*.fas or *.txt!","warning", 
								JOptionPane.INFORMATION_MESSAGE
								);
					  }

				}
				else{
					JOptionPane.showMessageDialog(null,
							"File Type Error!"+"\n"+"The file type must be: *.seq,*.fasta,*.faa,*.rdf,,*.gbk,*.gb ,*.fas or *.txt!","warning", 
							JOptionPane.INFORMATION_MESSAGE
							);
				   }
				}

			}
			});

		mBtn.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				outTxtArea.setText("");
				output = "";
				sequ="";
			//	System.out.println("choice:"+choice.getSelectedItem());
			if(mTxtSeq.getText().length()!=0||!file.getText().equals("Open File")||!number.getSelectedItem().equals("")){
				if((mTxtSeq.getText().length()!=0 && file.getText().equals("Open File")&& number.getSelectedItem().equals(""))
				   ||(mTxtSeq.getText().length()==0&&!file.getText().equals("Open File")&& number.getSelectedItem().equals(""))
				   ||(mTxtSeq.getText().length()==0&& file.getText().equals("Open File")&&!number.getSelectedItem().equals("")) ){
					if(select.getSelectedItem().equals("FASTA")&&mTxtSeq.getText().length()!=0){
					//mTxtSeq.append("\0"); 				
					try {
					String start = mTxtSeq.getText(mTxtSeq.getLineStartOffset(0), mTxtSeq.getLineEndOffset(0) - mTxtSeq.getLineStartOffset(0));					
				//	System.out.println("start:"+start);
					if(!start.contains("<?xml")&&!start.contains("LOCUS")){
			                for (int i = 0; i < mTxtSeq.getLineCount(); i++) { 
			                    try { 
			                    // getText(int offset,int length)
			                       String a=mTxtSeq.getText(mTxtSeq.getLineStartOffset(i), mTxtSeq.getLineEndOffset(i) - mTxtSeq.getLineStartOffset(i));
									if (a.length()!=0){//按行读取文本 
										if(!a.substring(0, 1).equals(">")){
										a=a.replace("\n", "");
										sequ+=a;
									   }
									}
			                    } catch (BadLocationException ex) { 
			                        ex.printStackTrace(); 
			                    }
			                }
			     
						if(sequ.length()!=0){
							sequ = sequ.toLowerCase();
							jisuan();
						}else{
							JOptionPane.showMessageDialog(null,
									"There are some non-amino acid or non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
									JOptionPane.INFORMATION_MESSAGE
									);
						     }
					  }
					else{
						JOptionPane.showMessageDialog(null,
								"There are some non-amino acid or non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
								JOptionPane.INFORMATION_MESSAGE
								);
					}
					} catch (BadLocationException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					  }
				}
					if(select.getSelectedItem().equals("GENBANK")&&mTxtSeq.getText().length()!=0){

                           String s = mTxtSeq.getText();
                           String[] sp = s.split("\n"); //此处用"换行\n"
                           if(sp[0].startsWith("LOCUS")&&sp[sp.length-1].endsWith("//")){
                           StringBuffer sb = new StringBuffer();
                           for (String x : sp) {
                                 sb.append(x + "\r\n"); //"回车+换行"即"\r\n"
                                 }
                  		 String url = codon.class.getClass().getResource("/").getPath().replaceAll("%20", " ");
               //          System.out.println(url);
//                         String path = url+ "Codon/";
                         String path = url;
                         try {
                       	 File file = new File(path+"ClustalW2/GENBANK.txt");
                        	 PrintWriter out = new PrintWriter(file);
                               out.write(sb.toString());
                               out.flush();
//                            FileReader fr = new FileReader(file);    
//       						BufferedReader br = new BufferedReader(fr);  
                         	 InputStream is=new FileInputStream(new File(path+"ClustalW2/GENBANK.txt")); 
                       	 BufferedReader br=new BufferedReader(new InputStreamReader(is)); 
							//文件格式
							String format = "GENBANK";
							String alpha="DNA";
							//字母表
							if(choice.getSelectedItem().equals("DNA")){
							alpha = "DNA";
							}else{
							alpha = "AA";
							}
							SequenceIterator iter =(SequenceIterator)SeqIOTools.fileToBiojava(format,alpha, br);

									// 以FASTA格式输出,可以使用任何输出流,不仅仅是System.out
							while(iter.hasNext()){
								Sequence seq = iter.nextSequence();
							//	System.out.println("........"+seq.seqString());
								sequ=seq.seqString();
								
							}
							if(sequ.length()!=0){
								sequ = sequ.toLowerCase();
								jisuan();
							}else{
								JOptionPane.showMessageDialog(null,
										"There are some non-amino acid or non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
										JOptionPane.INFORMATION_MESSAGE
										);
							  }
 						   }
     					catch (IOException ioe){             
     						System.out.println(ioe);       
     						} catch (BioException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
                      }
                      else{
							JOptionPane.showMessageDialog(null,
									"The file is not genbank format.It should be start with 'LOCUS' and end with '//'.Please check your file.","warning", 
									JOptionPane.INFORMATION_MESSAGE
									);   
                           }
					}
					if(select.getSelectedItem().equals("SBOL")&&mTxtSeq.getText().length()!=0){

                        String s = mTxtSeq.getText();
                        String[] sp = s.split("\n"); //此处用"换行\n"就可以了
                       if(sp[0].contains("<?xml")){ 
                        StringBuffer sb = new StringBuffer();
                        for (String x : sp) {
                              sb.append(x + "\r\n"); //经测试，这个地方一定要用"回车+换行"即"\r\n"
                              }
               		 String url = codon.class.getClass().getResource("/").getPath().replaceAll("%20", " ");
           //           System.out.println(url);
//                      String path = url+ "Codon/";
                      String path = url;
                      try {
                     	 File file = new File(path+"ClustalW2/SBOL.txt");
                     	 PrintWriter out = new PrintWriter(file);
                            out.write(sb.toString());
                            out.flush();
    						DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

    						DocumentBuilder builder = factory.newDocumentBuilder();

    						Document doc = builder.parse(file);
    					
    						sequ=doc.getElementsByTagName("nucleotides").item(0).getFirstChild().getNodeValue();

    						if(sequ.length()!=0){
    							sequ = sequ.toLowerCase();
    							jisuan();
    						}else{
    							JOptionPane.showMessageDialog(null,
    									"There are some non-amino acid or non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
    									JOptionPane.INFORMATION_MESSAGE
    									);
    						  }	
						   }catch (Exception ioe) {

								ioe.printStackTrace();

								}
					  }
                       else{
 							JOptionPane.showMessageDialog(null,
 									"The file is not SBOL format.Please check your file.","warning", 
 									JOptionPane.INFORMATION_MESSAGE
 									);   
                            }
					}
				if(select.getSelectedItem().equals("FASTA")&&!file.getText().equals("Open File")){
					try {   //以缓冲区方式读取文件内容    
						File file1 = new File(fd.getDirectory(),fd.getFile());     
						FileReader fr = new FileReader(file1);    
						BufferedReader br = new BufferedReader(fr);    
						String aline=br.readLine(); 
						if(aline.startsWith(">")){
				//		System.out.println("aline:"+aline);
						while ((aline=br.readLine()) != null)//按行读取文本 
							{if(!aline.startsWith(">")){
								sequ+=aline;
							   }
							}
						fr.close();     
						br.close(); 
						if(sequ.length()!=0){
							sequ = sequ.toLowerCase();
							jisuan();
						}else{
							JOptionPane.showMessageDialog(null,
									"There are some non-amino acid or non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
									JOptionPane.INFORMATION_MESSAGE
									);
						  }
						 }
						else{
							JOptionPane.showMessageDialog(null,
									"The file is not FASTA format.It should be start with '>'.Please check your file.","warning", 
									JOptionPane.INFORMATION_MESSAGE
									);
						}						
					}
					catch (IOException ioe){             
						System.out.println(ioe);       
						}
				  }
				if(select.getSelectedItem().equals("GENBANK")&&!file.getText().equals("Open File")){
					try {   //以缓冲区方式读取文件内容    

						//准备一个缓冲
						File file2 = new File(fd.getDirectory(),fd.getFile());
						BufferedReader br = new BufferedReader(new FileReader(file2));
						String aline=br.readLine(); 
						//文件格式
						String format = "GENBANK";
						String alpha="DNA";
						//字母表
						if(choice.getSelectedItem().equals("DNA")){
						alpha = "DNA";
						}else{
						alpha = "AA";
						}
						String strLastLine = null;
						String line;
						while ((line=br.readLine ())!= null)
						{
						    strLastLine = line;
						}
						if(aline.startsWith("LOCUS")&&strLastLine.endsWith("//")){
						BufferedReader newbr = new BufferedReader(new FileReader(file2));
						SequenceIterator iter =(SequenceIterator)SeqIOTools.fileToBiojava(format,alpha, newbr);

								// 以FASTA格式输出,可以使用任何输出流,不仅仅是System.out
						while(iter.hasNext()){
							Sequence seq = iter.nextSequence();
						//	System.out.println(seq.seqString());
							sequ=seq.seqString();
							
						}
						if(sequ.length()!=0){
							sequ = sequ.toLowerCase();
							jisuan();
						}else{
							JOptionPane.showMessageDialog(null,
									"There are some non-amino acid or non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
									JOptionPane.INFORMATION_MESSAGE
									);
						  }
						}else{
							JOptionPane.showMessageDialog(null,
									"The file is not genbank format.It should be start with 'LOCUS' and end with '//'.Please check your file.","warning", 
									JOptionPane.INFORMATION_MESSAGE
									);   
						}
						} catch (FileNotFoundException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}      catch (BioException ex) {
					        //not in GenBank format
					        ex.printStackTrace();
					      }catch (NoSuchElementException ex) {
					        //request for more sequence when there isn't any
					        ex.printStackTrace();
					      } catch (IOException e1) {
							// TODO Auto-generated catch block
							e1.printStackTrace();
						}
				  }
				if(select.getSelectedItem().equals("SBOL")&&!file.getText().equals("Open File")){
					try {   //以缓冲区方式读取文件内容            
						File file3 = new File(fd.getDirectory(),fd.getFile());  
						BufferedReader br = new BufferedReader(new FileReader(file3));
						String aline=br.readLine();

				//	validateXMLByXSD(fd.getDirectory()+fd.getFile());
						
						if(aline.startsWith("<?xml")){
						DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

						DocumentBuilder builder = factory.newDocumentBuilder();

						Document doc = builder.parse(file3);
						
						NodeList nl = doc.getElementsByTagName("dnaSequence");
						if(null != nl&&nl.getLength()>0){
						sequ=doc.getElementsByTagName("nucleotides").item(0).getFirstChild().getNodeValue();

						if(sequ.length()!=0){
							sequ = sequ.toLowerCase();
							jisuan();
						}else{
							JOptionPane.showMessageDialog(null,
									"There are some non-amino acid or non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
									JOptionPane.INFORMATION_MESSAGE
									);
						  }	
						}else{
							JOptionPane.showMessageDialog(null,
									"There are some non-amino acid or non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
									JOptionPane.INFORMATION_MESSAGE
									);
						  }
						}
						else{
 							JOptionPane.showMessageDialog(null,
 									"The file is not SBOL format.Please check your file.","warning", 
 									JOptionPane.INFORMATION_MESSAGE
 									); 
						}
						}catch (Exception ioe) {

							ioe.printStackTrace();

							}
				   }
				
				
				if(!number.getSelectedItem().equals("")){
	                 try {
	                	 
	                	 InputStream is=this.getClass().getResourceAsStream("/Codon/cds_igem.txt"); 
	                	 BufferedReader br=new BufferedReader(new InputStreamReader(is)); 
						String idseq="";
						while ((idseq = br.readLine()) != null)//按行读取文本 
						  {	
					    	if(idseq.startsWith(number.getSelectedItem().toString())){
					    		String[] array = idseq.split(" ");
								sequ=array[array.length-1];
					    	   }
						  }
						br.close();	
				//		System.out.println("序列：：：："+sequ);
						sequ = sequ.toLowerCase();
						jisuan();
					    }
					catch (IOException ioe){             
						System.out.println(ioe);       
						   }																																			
				}
				
																																	
			//	System.out.println("Sequ"+sequ);
			    }
				else{
					JOptionPane.showMessageDialog(null,
							"Please do not input and upload sequence at the same time.","warning", 
							JOptionPane.INFORMATION_MESSAGE
							);
				}
			   }
			else{
				JOptionPane.showMessageDialog(null,
						"Please input or upload sequence!","warning", 
						JOptionPane.INFORMATION_MESSAGE
						);
			  }
			}
		});
	}
	
	
	

	
	 /* 
      通过XSD（XML Schema）校验XML 
	  @param xmlFileName 
     */ 
    /*public boolean validateXMLByXSD(String xmlFileName) {
    	boolean checkxml = false;
        String xsdFileName = getClass().getResource("/Codon/checkxml.txt").getPath().replaceAll("%20", " ");       
        System.out.println("xsdFileName:"+xsdFileName);
        try { 
            //创建默认的XML错误处理器 
            XMLErrorHandler errorHandler = new XMLErrorHandler(); 
            //获取基于 SAX 的解析器的实例 
            SAXParserFactory factory = SAXParserFactory.newInstance(); 
            //解析器在解析时验证 XML 内容。 
            factory.setValidating(true); 
            //指定由此代码生成的解析器将提供对 XML 名称空间的支持。 
            factory.setNamespaceAware(true); 
            //使用当前配置的工厂参数创建 SAXParser 的一个新实例。 
            SAXParser parser = factory.newSAXParser(); 
            //创建一个读取工具 
            SAXReader xmlReader = new SAXReader(); 
            //获取要校验xml文档实例 
            org.dom4j.Document xmlDocument = (org.dom4j.Document) xmlReader.read(new File(xmlFileName)); 
            //设置 XMLReader 的基础实现中的特定属性。核心功能和属性列表可以在 [url]http://sax.sourceforge.net/?selected=get-set[/url] 中找到。 
            parser.setProperty( 
                    "http://java.sun.com/xml/jaxp/properties/schemaLanguage", 
                    "http://www.w3.org/2001/XMLSchema"); 
            parser.setProperty( 
                    "http://java.sun.com/xml/jaxp/properties/schemaSource", 
                    "file:" + xsdFileName); 
            //创建一个SAXValidator校验工具，并设置校验工具的属性 
            SAXValidator validator = new SAXValidator(parser.getXMLReader()); 
            //设置校验工具的错误处理器，当发生错误时，可以从处理器对象中得到错误信息。 
            validator.setErrorHandler(errorHandler); 
            //校验 
            validator.validate(xmlDocument); 

            //如果错误信息不为空，说明校验失败，打印错误信息 
            if (errorHandler.getErrors().hasContent()) { 
                System.out.println("XML文件通过XSD文件校验失败！"); 
            } else { 
            	checkxml=true;
                System.out.println("Good! XML文件通过XSD文件校验成功！"); 
            } 
        } catch (Exception ex) { 
            System.out.println("XML文件: " + xmlFileName + " 通过XSD文件:" + xsdFileName + "检验失败。\n原因： " + ex.getMessage()); 
            ex.printStackTrace(); 
        }
		
		return checkxml; 
    }*/
  

	
	public  void jisuan() {
		
			if(choice.getSelectedItem().equals("DNA")){
		     //      System.out.println("sequ~~~~"+sequ);
			if (check(sequ.toUpperCase())) {
		     //      System.out.println("sequ:::::"+sequ);
               if(sequ.length()%3==0){
             //      System.out.println("sequ::"+sequ);
						// System.out.println("rsequ:"+rsequ);
						 s= getDNA(sequ);						
				//		System.out.println("ORF:" + s);								
				Thread  tran= new Thread(new Tran());//新生成一个处理事务线程
				tran.start();//启动事务线程
				
				(new ThreadDiag(testFrame, tran , "Please wait for a moment......")).start();//启动等待提示框线程		
				
			        }else{
				        JOptionPane.showMessageDialog(null,
						"The length of sequence is not 3N,please check your seqence!","warning", 
						JOptionPane.INFORMATION_MESSAGE
						);
			          }
			} else {
				JOptionPane.showMessageDialog(null,
						"There are some non-nucleotide character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
						JOptionPane.INFORMATION_MESSAGE
						);
			}
		}
			if(choice.getSelectedItem().equals("Protein")){
			if (check(sequ.toUpperCase())) {
						 s= getProtein(sequ).toUpperCase();						
				//		System.out.println("ORF:" + s);								
				Thread  tran= new Thread(new Tran());//新生成一个处理事务线程
				tran.start();//启动事务线程
				(new ThreadDiag(testFrame, tran , "Please wait for a moment......")).start();//启动等待提示框线程		
				
			} else {
				JOptionPane.showMessageDialog(null,
						"There are some non-amino acid character in your sequence,or maybe you have chosen the incorrect format,please check your seqence.","warning", 
						JOptionPane.INFORMATION_MESSAGE
						);
			}
		}
	}
	class Tran implements Runnable{
		public void run()
		 {	
		         	String seq1 = "";
		         	String seq2 = "";
		         	List<List<String>> sequences = null;
		         	if(choice.getSelectedItem().equals("DNA")){
							sequences = speeder.a(s);
		         	}
		         	if(choice.getSelectedItem().equals("Protein")){
							sequences = speeder.b(s);
		         	}
					//	    System.out.println("sequences:"+sequences.size());
							List<String> buf1 = new ArrayList<String>();
							List<String> buf2 = new ArrayList<String>();
							buf1=sequences.get(0);
							buf2=sequences.get(1);
							for (int i = 0; i < buf1.size(); i++) {
								seq1 += buf1.get(i);
							}
							for (int i = 0; i < buf2.size(); i++) {
								seq2 += buf2.get(i);
							}

/*							output+="ORF:"+"\n";
							output+=s+"\n";*/
							output+="Fast sequence is:"+ "\n";;
								output += seq1+ "\n";
							output+="\n"+"Slow sequence is:"+ "\n";;
							output += seq2+ "\n";
/*									output += ("Stated:" + (orf.start + 1)
										+ "--" + (orf.end + 3))
										+ "\n";*/
						
						outTxtArea.setText(output);	
		 }
	}
	public static boolean check(String aim) {
		boolean boo = true;
		for (int i = 0; i < aim.length(); i++) {
			String single = aim.substring(i, i + 1);
       if(choice.getSelectedItem().equals("DNA")){
			if ((!single.equals("A")) & (!single.equals("C"))
					& (!single.equals("T")) & (!single.equals("G"))) {
				boo = false;
				// System.out.println(boo);
			   }
		  }
       if(choice.getSelectedItem().equals("Protein")){
			if ((!single.equals("A")) & (!single.equals("R"))
					& (!single.equals("N")) & (!single.equals("D"))
					&(!single.equals("C")) & (!single.equals("Q"))
					& (!single.equals("E")) & (!single.equals("G"))
					&(!single.equals("H")) & (!single.equals("I"))
					& (!single.equals("L")) & (!single.equals("K"))
					&(!single.equals("M")) & (!single.equals("F"))
					& (!single.equals("P")) & (!single.equals("S"))
					&(!single.equals("T")) & (!single.equals("W"))
					& (!single.equals("Y")) & (!single.equals("V"))) {
				boo = false;
				// System.out.println(boo);
			   }
		  }
		}
		return boo;

	}

	public String getDNA(String sequence) {
		String orf="";
		String a= sequence.substring(0,3);
		String b = sequence.substring(sequence.length()-3, sequence.length());
		
		if (a.equals("atg")&&(b.equals("tga") || b.equals("taa")
				|| b.equals("tag"))) {
			orf=sequence;
			for (int i = 3;  i < sequence.length() - 3; i = i + 3) {							
						String b1 = sequence.substring(i, i + 3);
						if (b1.equals("tga") || b1.equals("taa")
								|| b1.equals("tag")) {
							if(!output.contains("WARNING"))  
							{  
							output="WARNING:There is(are) a termination codon(s) in the sequence."+"\n";
							}	
						}                     						
									
			     }
	       }
		if (!a.equals("atg")&&(b.equals("tga") || b.equals("taa")
				|| b.equals("tag"))) {
			orf="atg"+sequence;
			output="The sequence is lack of initiation codon ,a initiation codon has been added to the head of the sequence."+"\n";
			for (int i = 0;  i < sequence.length() - 3; i = i + 3) {							
						String b1 = sequence.substring(i, i + 3);
						if (b1.equals("tga") || b1.equals("taa")
								|| b1.equals("tag")) {
							if(!output.contains("WARNING"))  
							{  
							output+="WARNING:There is(are) a termination codon(s) in the sequence."+"\n";
							}	
						}                     						
								
			     }
	       }
		if (a.equals("atg")&&(!b.equals("tga") && !b.equals("taa")
				&& !b.equals("tag"))) {
			orf=sequence+"taa";
			output="The sequence is lack of termination codon,a termination codon has been added to the tail of the sequence."+"\n";	
			for (int i = 3;  i < sequence.length(); i = i + 3) {							
						String b1 = sequence.substring(i, i + 3);
						if (b1.equals("tga") || b1.equals("taa")
								|| b1.equals("tag")) {
							if(!output.contains("WARNING"))  
							{  
							output+="WARNING:There is(are) a termination codon(s) in the sequence."+"\n";
							}	
						}                     						
									
			     }
	       }
		if (!a.equals("atg")&&(!b.equals("tga") && !b.equals("taa")
				&& !b.equals("tag"))) {
			orf="atg"+sequence+"taa";
			output="The sequence is lack of initiation codon and termination codon ,a initiation codon and a termination codon have been added to the head and tail of the sequence respectively."+"\n";	
			for (int i = 0;  i < sequence.length(); i = i + 3) {							
						String b1 = sequence.substring(i, i + 3);
						if (b1.equals("tga") || b1.equals("taa")
								|| b1.equals("tag")) {
							if(!output.contains("WARNING"))  
							{  
							output+="WARNING:There is(are) a termination codon(s) in the sequence."+"\n";
							}
						}                     										
			     }
	       }
		
		return orf;
	}
	public String getProtein(String sequence) {
		String orf="";
		String a= sequence.substring(0,1).toUpperCase();
	//	System.out.println("a~~~~~~~~~~~~~~~~~~~"+a);
		if (a.equals("M")) {
			orf=sequence+"X";
			output="The sequence is lack of termination codon,a termination codon has been added to the tail of the sequence."+"\n";	
	       }
		if (!a.equals("M")) {
			orf="M"+sequence+"X";
			output="The sequence is lack of initiation codon and termination codon ,a initiation codon and a termination codon have been added to the head and tail of the sequence respectively."+"\n";	
	       }		
		return orf;
	}

}
