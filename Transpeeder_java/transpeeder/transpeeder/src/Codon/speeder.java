package Codon;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Collections;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.biojava.bio.seq.DNATools;
import org.biojava.bio.seq.Sequence;
import org.biojava.bio.seq.SequenceIterator;

public class speeder {
	private static Double score;
	private static final Map<String, String> myMap1;
    static {
    	Map<String, String> codon2aa = new HashMap<String, String>();
    	codon2aa.put("ttt", "F");
	    codon2aa.put("ttc", "F");	 
	    codon2aa.put("atg", "M");	    
	    codon2aa.put("gct", "A");
	    codon2aa.put("gcc", "A");
	    codon2aa.put("gca", "A");	 
	    codon2aa.put("gcg", "A");	    
	    codon2aa.put("cgt", "R");
	    codon2aa.put("cgc", "R");
	    codon2aa.put("cga", "R");	 
	    codon2aa.put("cgg", "R");
	    codon2aa.put("aga", "R");
	    codon2aa.put("agg", "R");	    
	    codon2aa.put("aat", "N");	 
	    codon2aa.put("aac", "N");	    
	    codon2aa.put("gat", "D");
	    codon2aa.put("gac", "D");	    
	    codon2aa.put("tgt", "C");
	    codon2aa.put("tgc", "C");	    
	    codon2aa.put("caa", "Q");	 
	    codon2aa.put("cag", "Q");	    
	    codon2aa.put("gaa", "E");
	    codon2aa.put("gag", "E");	    
	    codon2aa.put("ggt", "G");
	    codon2aa.put("ggc", "G");
	    codon2aa.put("gga", "G");	 
	    codon2aa.put("ggg", "G");	    
	    codon2aa.put("cat", "H");
	    codon2aa.put("cac", "H");	    
	    codon2aa.put("att", "I");
	    codon2aa.put("atc", "I");	    
	    codon2aa.put("ata", "I");	    
	    codon2aa.put("tta", "L");	    
	    codon2aa.put("ttg", "L");
	    codon2aa.put("ctt", "L");
	    codon2aa.put("ctc", "L");	 
	    codon2aa.put("cta", "L");	    
	    codon2aa.put("ctg", "L");	    
	    codon2aa.put("aaa", "K");	    
	    codon2aa.put("aag", "K");	    
	    codon2aa.put("cct", "P");
	    codon2aa.put("ccc", "P");	 
	    codon2aa.put("cca", "P");	    
	    codon2aa.put("ccg", "P");	    
	    codon2aa.put("tct", "S");	    
	    codon2aa.put("tcc", "S");
	    codon2aa.put("tca", "S");	    
	    codon2aa.put("tcg", "S");
	    codon2aa.put("agt", "S");	    
	    codon2aa.put("agc", "S");	    	    
	    codon2aa.put("act", "T");	    
	    codon2aa.put("acc", "T");
	    codon2aa.put("aca", "T");	    
	    codon2aa.put("acg", "T");	    
	    codon2aa.put("tgg", "W");	    
	    codon2aa.put("tat", "Y");	    
	    codon2aa.put("tac", "Y");	    
	    codon2aa.put("gtt", "V");	    
	    codon2aa.put("gtc", "V");
	    codon2aa.put("gta", "V");	    
	    codon2aa.put("gtg", "V");
	    codon2aa.put("taa", "X");
	    codon2aa.put("tga", "X");	    
	    codon2aa.put("tag", "X");
        myMap1 = Collections.unmodifiableMap(codon2aa);
    }
    @SuppressWarnings("rawtypes")
	private static final Map<String, List> myMap2;
    static {
    	@SuppressWarnings("rawtypes")
		Map<String, List> aa2codon = new HashMap<String, List>();
    	List<String> phe = new ArrayList<String>();
	    List<String> met = new ArrayList<String>();
	    List<String> ala = new ArrayList<String>();
	    List<String> arg = new ArrayList<String>();   
	    List<String> asn = new ArrayList<String>();	    
	    List<String> asp = new ArrayList<String>();	    
	    List<String> cys = new ArrayList<String>();	    
	    List<String> gln = new ArrayList<String>();	    
	    List<String> glu = new ArrayList<String>();	    
	    List<String> gly = new ArrayList<String>();	   
	    List<String> his = new ArrayList<String>();	    
	    List<String> ile = new ArrayList<String>();	    
	    List<String> leu = new ArrayList<String>();	    
	    List<String> lys = new ArrayList<String>();		    
	    List<String> pro = new ArrayList<String>();	    	      
	    List<String> ser = new ArrayList<String>();	    	  	    
	    List<String> thr = new ArrayList<String>();	   		    
	    List<String> trp = new ArrayList<String>();		    
	    List<String> tyr = new ArrayList<String>();		    
	    List<String> val = new ArrayList<String>();	    
	    List<String> stop = new ArrayList<String>();	
	    
	    phe.add("ttt");
	    phe.add("ttc");
	    met.add("atg");
	    ala.add("gct");
	    ala.add("gcc");
	    ala.add("gca");
	    ala.add("gcg");	    
	    arg.add("cgt");
	    arg.add("cgc");
	    arg.add("cga");
	    arg.add("cgg");
	    arg.add("aga");
	    arg.add("agg");	    
	    asn.add("aat");
	    asn.add("aac");	    
	    asp.add("gat");
	    asp.add("gac");	    
	    cys.add("tgt");
	    cys.add("tgc");	    
	    gln.add("caa");
	    gln.add("cag");	    
	    glu.add("gaa");
	    glu.add("gag");	    
	    gly.add("ggt");
	    gly.add("ggc");	    
	    gly.add("gga");
	    gly.add("ggg");	    
	    his.add("cat");
	    his.add("cac");	    
	    ile.add("att");
	    ile.add("atc");	    
	    ile.add("ata");	    
	    leu.add("tta");	    
	    leu.add("ttg");
	    leu.add("ctt");
	    leu.add("ctc");	    
	    leu.add("cta");
	    leu.add("ctg");	    
	    lys.add("aaa");
	    lys.add("aag");	    
	    pro.add("cct");
	    pro.add("ccc");	    
	    pro.add("cca");
	    pro.add("ccg");	    
	    ser.add("tct");
	    ser.add("tcc");	    
	    ser.add("tca");
	    ser.add("tcg");	    
	    ser.add("agt");
	    ser.add("agc");	    
	    thr.add("act");
	    thr.add("acc");	    
	    thr.add("aca");	    
	    thr.add("acg");	    
	    trp.add("tgg");	    
	    tyr.add("tat");
	    tyr.add("tac");	    
	    val.add("gtt");
	    val.add("gtc");
	    val.add("gta");
	    val.add("gtg");
	    stop.add("taa");
	    stop.add("tga");
	    stop.add("tag");
	    aa2codon.put("F", phe);
	    aa2codon.put("M", met);
	    aa2codon.put("A", ala);	    
	    aa2codon.put("R", arg);	    
	    aa2codon.put("N", asn);	    
	    aa2codon.put("D", asp); 	    
	    aa2codon.put("C", cys);	    
	    aa2codon.put("Q", gln);	    
	    aa2codon.put("E", glu);    
	    aa2codon.put("G", gly);   
	    aa2codon.put("H", his);	    
	    aa2codon.put("I", ile);	    
	    aa2codon.put("L", leu);	    
	    aa2codon.put("K", lys); 	    
	    aa2codon.put("P", pro);	    
	    aa2codon.put("S", ser);	    	    
	    aa2codon.put("T", thr);	    
	    aa2codon.put("W", trp);	
	    aa2codon.put("Y", tyr);
	    aa2codon.put("V", val);
	    aa2codon.put("X", stop);	

        myMap2 = Collections.unmodifiableMap(aa2codon);
    }

   

	@SuppressWarnings("unchecked")
	public static List<List<String>> a(String seq){
		List<String> sequence1 = new ArrayList<String>();
		List<String> sequence2 = new ArrayList<String>();
		List<List<String>> sequences = new ArrayList<List<String>>();
		// TODO Auto-generated method stub
	    String SD="AGGAGGT";		
	    String fSD="AGGTAGG";     
	    String c;
	
		if((seq.length()-3)%6==0){
		    String StarCodon="";
		    StarCodon=seq.substring(0, 3);
		    sequence1.add(StarCodon);
			sequence2.add(StarCodon);
		for(int i=3;i<seq.length();i=i+6)
		{
		 String a=seq.substring(i,i+3);
	//	 System.out.println(a);
		 String b=seq.substring(i+3,i+6);
	//	 System.out.println(b);		 
		 String aa = myMap1.get(a);
		 List<String> acodons = myMap2.get(aa);
		 String bb = myMap1.get(b);
		 List<String> bcodons = myMap2.get(bb);
		 double min = 1e10;
		 double max = -1e10;
		 List<String> minCodons = new ArrayList<String>();	
		 List<String> maxCodons = new ArrayList<String>();
		 for (String codonA: acodons) {
			/* if (bcodons == null) {
				 System.out.println("error:bcodons is null");
			 }*/
			 for (String codonB: bcodons) {
		    c = codonA+codonB;
		    double score = xuliebidui(c, SD, fSD);
		    if (max < score) {
		        max = score;
		        maxCodons.clear();
		  maxCodons.add(c);
		   } else if (max == score) {
		   maxCodons.add(c); 		  
		   }
		    if (min > score) {
		        min = score;
		        minCodons.clear();
		        minCodons.add(c);
		   } else if (min == score) {
		   minCodons.add(c); 		  
		   } 	    
		  }	
		 }
		 
         double[] zhi1=new double[maxCodons.size()];
         double[] zhi2=new double[minCodons.size()];
			try {
           	 InputStream is=codon.class.getClass().getResourceAsStream("/Codon/ecoli.txt"); 
           	 BufferedReader fileBuffer=new BufferedReader(new InputStreamReader(is));
				String str="";
			    while((str=fileBuffer.readLine())!=null){
			    	for(int j=0;j<maxCodons.size();j++){
			    	if(str.startsWith(maxCodons.get(j).toUpperCase())){
			    		String[] array = str.split(" ");
			 //   		System.out.println("...."+array[array.length-1]);
						zhi1[j]=Double.parseDouble(array[array.length-1]);
			 //   		System.out.println(str);	
			    	   }
			    	}
			    	for(int j=0;j<minCodons.size();j++){
			    	if(str.startsWith(minCodons.get(j).toUpperCase())){
			    		String[] array = str.split(" ");
			 //   		System.out.println("...."+array[array.length-1]);
						zhi2[j]=Double.parseDouble(array[array.length-1]);
			 //   		System.out.println(str);	
			    	   }
			    	}
				}		    			    
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Double> list1 = new ArrayList<Double>();
			List<Double> list2 = new ArrayList<Double>();
			 for (double v :zhi1){
				    list1.add(v);
				   }
			 java.util.Arrays.sort(zhi1);
	//		 System.out.println(zhi1[0]+"~~~~"+zhi1[zhi1.length-1]);
			 int dex1=list1.indexOf(zhi1[zhi1.length-1]);
	//		 System.out.println("。。。。"+dex1);
			 String temp1=maxCodons.get(dex1);
			 sequence1.add(temp1);	
			 for (double v :zhi2){
				    list2.add(v);
				   }
			 java.util.Arrays.sort(zhi2);
	//		 System.out.println(zhi2[0]+"@@@@"+zhi2[zhi2.length-1]);
			 int dex2=list2.indexOf(zhi2[0]);
	//		 System.out.println("。。。。"+dex2);
			 String temp2=minCodons.get(dex2);
			 sequence2.add(temp2);
		}
		}
		if(seq.length()%6==0){
			for(int i=0;i<seq.length();i=i+6)
			{
			 String a=seq.substring(i,i+3);
		//	 System.out.println(a);
			 String b=seq.substring(i+3,i+6);
		//	 System.out.println(b);			 
			 String aa = myMap1.get(a);
			 List<String> acodons = myMap2.get(aa);
			 String bb = myMap1.get(b);
			 List<String> bcodons = myMap2.get(bb);
			 double min = 1e10;
			 double max = -1e10;
			 List<String> minCodons = new ArrayList<String>();	
			 List<String> maxCodons = new ArrayList<String>();
			 for (String codonA: acodons) {
				/* if (bcodons == null) {
					 System.out.println("error:bcodons is null");
				 }*/
				 for (String codonB: bcodons) {
			    c = codonA+codonB;
			    double score = xuliebidui(c, SD, fSD);
			    if (max < score) {
			        max = score;
			        maxCodons.clear();
			  maxCodons.add(c);
			   } else if (max == score) {
			   maxCodons.add(c); 		  
			   }
			    if (min > score) {
			        min = score;
			        minCodons.clear();
			        minCodons.add(c);
			   } else if (min == score) {
			   minCodons.add(c); 		  
			   } 	    
			  }	
			 }
	
	         double[] zhi1=new double[maxCodons.size()];
	         double[] zhi2=new double[minCodons.size()];
				try {
		           	 InputStream is=codon.class.getClass().getResourceAsStream("/Codon/ecoli.txt"); 
		           	 BufferedReader fileBuffer=new BufferedReader(new InputStreamReader(is));
					String str="";
				    while((str=fileBuffer.readLine())!=null){
				    	for(int j=0;j<maxCodons.size();j++){
				    	if(str.startsWith(maxCodons.get(j).toUpperCase())){
				    		String[] array = str.split(" ");
				 //   		System.out.println("...."+array[array.length-1]);
							zhi1[j]=Double.parseDouble(array[array.length-1]);
				//    		System.out.println(str);	
				    	   }
				    	}
				    	for(int j=0;j<minCodons.size();j++){
				    	if(str.startsWith(minCodons.get(j).toUpperCase())){
				    		String[] array = str.split(" ");
				 //   		System.out.println("...."+array[array.length-1]);
							zhi2[j]=Double.parseDouble(array[array.length-1]);
				  //  		System.out.println(str);	
				    	   }
				    	}
					}		    			    
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				List<Double> list1 = new ArrayList<Double>();
				List<Double> list2 = new ArrayList<Double>();
				 for (double v :zhi1){
					    list1.add(v);
					   }
				 java.util.Arrays.sort(zhi1);
		//		 System.out.println(zhi1[0]+"~~~~"+zhi1[zhi1.length-1]);
				 int dex1=list1.indexOf(zhi1[zhi1.length-1]);
		//		 System.out.println("。。。。"+dex1);
				 String temp1=maxCodons.get(dex1);
				 sequence1.add(temp1);	
				 for (double w :zhi2){
					    list2.add(w);
					   }
				 java.util.Arrays.sort(zhi2);
		//		 System.out.println(zhi2[0]+"@@@@"+zhi2[zhi2.length-1]);
				 int dex2=list2.indexOf(zhi2[0]);
		//		 System.out.println("。。。。"+dex2);
				 String temp2=minCodons.get(dex2);
				 sequence2.add(temp2);				 						 		 		 
			  }					 						 				
			}
		sequences.add(sequence1);
		sequences.add(sequence2);	
		return sequences;					
		}
	
	@SuppressWarnings("unchecked")
	public static List<List<String>> b(String seq){
		List<String> sequence1 = new ArrayList<String>();
		List<String> sequence2 = new ArrayList<String>();
		List<List<String>> sequences = new ArrayList<List<String>>();
		// TODO Auto-generated method stub
	    String SD="AGGAGGT";		
	    String fSD="AGGTAGG";     
	    String c;
	
		if(seq.length()%2!=0){
		    String StarCodon="atg";
		    sequence1.add(StarCodon);
			sequence2.add(StarCodon);
		for(int i=1;i<seq.length();i=i+2)
		{
		 String a=seq.substring(i,i+1);
	//	 System.out.println(a);
		 String b=seq.substring(i+1,i+2);
	//	 System.out.println(b);		 
		 List<String> acodons = myMap2.get(a);
	//	 System.out.println("..................................................."+acodons);
		 List<String> bcodons = myMap2.get(b);
		 double min = 1e10;
		 double max = -1e10;
		 List<String> minCodons = new ArrayList<String>();	
		 List<String> maxCodons = new ArrayList<String>();
		 for (String codonA: acodons) {
			/* if (bcodons == null) {
				 System.out.println("error:bcodons is null");
			 }*/
			 for (String codonB: bcodons) {
		    c = codonA+codonB;
		    double score = xuliebidui(c, SD, fSD);
		    if (max < score) {
		        max = score;
		        maxCodons.clear();
		  maxCodons.add(c);
		   } else if (max == score) {
		   maxCodons.add(c); 		  
		   }
		    if (min > score) {
		        min = score;
		        minCodons.clear();
		        minCodons.add(c);
		   } else if (min == score) {
		   minCodons.add(c); 		  
		   } 	    
		  }	
		 }
//		 String url = codon.class.getClass().getResource("/").getPath().replaceAll("%20", " ");
//         System.out.println(url);
//         String path = url+ "Codon/";	
         double[] zhi1=new double[maxCodons.size()];
         double[] zhi2=new double[minCodons.size()];
			try {
//				File file = new File(path+"ecoli.txt");//创建文件对象
//				@SuppressWarnings("resource")
//				BufferedReader fileBuffer = new BufferedReader(new FileReader(file));
	           	 InputStream is=codon.class.getClass().getResourceAsStream("/Codon/ecoli.txt"); 
	           	 BufferedReader fileBuffer=new BufferedReader(new InputStreamReader(is));
				String str="";
			    while((str=fileBuffer.readLine())!=null){
			    	for(int j=0;j<maxCodons.size();j++){
			    	if(str.startsWith(maxCodons.get(j).toUpperCase())){
			    		String[] array = str.split(" ");
			   // 		System.out.println("...."+array[array.length-1]);
						zhi1[j]=Double.parseDouble(array[array.length-1]);
			    //		System.out.println(str);	
			    	   }
			    	}
			    	for(int j=0;j<minCodons.size();j++){
			    	if(str.startsWith(minCodons.get(j).toUpperCase())){
			    		String[] array = str.split(" ");
			  //  		System.out.println("...."+array[array.length-1]);
						zhi2[j]=Double.parseDouble(array[array.length-1]);
			  //  		System.out.println(str);	
			    	   }
			    	}
				}		    			    
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			List<Double> list1 = new ArrayList<Double>();
			List<Double> list2 = new ArrayList<Double>();
			 for (double v :zhi1){
				    list1.add(v);
				   }
			 java.util.Arrays.sort(zhi1);
		//	 System.out.println(zhi1[0]+"~~~~"+zhi1[zhi1.length-1]);
			 int dex1=list1.indexOf(zhi1[zhi1.length-1]);
		//	 System.out.println("。。。。"+dex1);
			 String temp1=maxCodons.get(dex1);
			 sequence1.add(temp1);	
			 for (double v :zhi2){
				    list2.add(v);
				   }
			 java.util.Arrays.sort(zhi2);
		//	 System.out.println(zhi2[0]+"@@@@"+zhi2[zhi2.length-1]);
			 int dex2=list2.indexOf(zhi2[0]);
		//	 System.out.println("。。。。"+dex2);
			 String temp2=minCodons.get(dex2);
			 sequence2.add(temp2);
		}
		}
		if(seq.length()%2==0){
			for(int i=0;i<seq.length();i=i+2)
			{
			 String a=seq.substring(i,i+1);
		//	 System.out.println(a);
			 String b=seq.substring(i+1,i+2);
		//	 System.out.println(b);			 
			 List<String> acodons = myMap2.get(a);
			 List<String> bcodons = myMap2.get(b);
			 double min = 1e10;
			 double max = -1e10;
			 List<String> minCodons = new ArrayList<String>();	
			 List<String> maxCodons = new ArrayList<String>();
			 for (String codonA: acodons) {
				/* if (bcodons == null) {
					 System.out.println("error:bcodons is null");
				 }*/
				 for (String codonB: bcodons) {
			    c = codonA+codonB;
			    double score = xuliebidui(c, SD, fSD);
			    if (max < score) {
			        max = score;
			        maxCodons.clear();
			  maxCodons.add(c);
			   } else if (max == score) {
			   maxCodons.add(c); 		  
			   }
			    if (min > score) {
			        min = score;
			        minCodons.clear();
			        minCodons.add(c);
			   } else if (min == score) {
			   minCodons.add(c); 		  
			   } 	    
			  }	
			 }

	         double[] zhi1=new double[maxCodons.size()];
	         double[] zhi2=new double[minCodons.size()];
				try {
		           	 InputStream is=codon.class.getClass().getResourceAsStream("/Codon/ecoli.txt"); 
		           	 BufferedReader fileBuffer=new BufferedReader(new InputStreamReader(is));
					String str="";
				    while((str=fileBuffer.readLine())!=null){
				    	for(int j=0;j<maxCodons.size();j++){
				    	if(str.startsWith(maxCodons.get(j).toUpperCase())){
				    		String[] array = str.split(" ");
				   // 		System.out.println("...."+array[array.length-1]);
							zhi1[j]=Double.parseDouble(array[array.length-1]);
				   // 		System.out.println(str);	
				    	   }
				    	}
				    	for(int j=0;j<minCodons.size();j++){
				    	if(str.startsWith(minCodons.get(j).toUpperCase())){
				    		String[] array = str.split(" ");
				    //		System.out.println("...."+array[array.length-1]);
							zhi2[j]=Double.parseDouble(array[array.length-1]);
				    //		System.out.println(str);	
				    	   }
				    	}
					}		    			    
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				List<Double> list1 = new ArrayList<Double>();
				List<Double> list2 = new ArrayList<Double>();
				 for (double v :zhi1){
					    list1.add(v);
					   }
				 java.util.Arrays.sort(zhi1);
		//		 System.out.println(zhi1[0]+"~~~~"+zhi1[zhi1.length-1]);
				 int dex1=list1.indexOf(zhi1[zhi1.length-1]);
		//		 System.out.println("。。。。"+dex1);
				 String temp1=maxCodons.get(dex1);
				 sequence1.add(temp1);	
				 for (double w :zhi2){
					    list2.add(w);
					   }
				 java.util.Arrays.sort(zhi2);
		//		 System.out.println(zhi2[0]+"@@@@"+zhi2[zhi2.length-1]);
				 int dex2=list2.indexOf(zhi2[0]);
		//		 System.out.println("。。。。"+dex2);
				 String temp2=minCodons.get(dex2);
				 sequence2.add(temp2);				 						 		 		 
			  }					 						 				
			}
		sequences.add(sequence1);
		sequences.add(sequence2);	
		return sequences;					
		}
	//序列比对算法实现
	public static Double xuliebidui(String Sequence1,String Sequence2,String Sequence3) {
		try {
			// First create an instance for ClustalWAlign
			ClustalWAlign alSequences = new ClustalWAlign("FakeSequencesFile");
 
			// Now only add Sequences to alSequences
			alSequences.addSequence(DNATools.createDNASequence(Sequence1,"Sequence1"));
			alSequences.addSequence(DNATools.createDNASequence(Sequence2,"Sequence2"));
			alSequences.addSequence(DNATools.createDNASequence(Sequence3,"Sequence3"));
 
			// Here you are calling the core of class - The Multi-Alignment!
			alSequences.doMultAlign();
 
			// Now, you want to see results. Well...
			SequenceIterator it = alSequences.getIterator();
 
			while (it.hasNext()) {
				Sequence seq = it.nextSequence();
		//		System.out.println(seq.getName() + ": " + seq.seqString());
			}
 
		//	System.out.println("GUIDE TREE:............." + alSequences.getGuideTree());
			
		//	System.out.println("SCORE: " + alSequences.getScore());
			score=alSequences.getGuideTree();
 
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return score;
	}
}
