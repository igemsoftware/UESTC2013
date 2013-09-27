package Codon;

/**
 * ClustalWAlign.java
 * 
 * @author Dickson S. Guedes (guedes@unisul.br)
 * @author Israel S. de Medeiros (israelbrz@gmail.com)
 * @version 1.0	
 * @serialData 20060120 
 * 
 * Copyright (c) 2006.
 * 
 */
 
import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.util.NoSuchElementException;
import java.util.Scanner;

import org.biojava.bio.BioException;
import org.biojava.bio.seq.Sequence;
import org.biojava.bio.seq.SequenceIterator;
import org.biojava.bio.seq.db.HashSequenceDB;
import org.biojava.bio.seq.db.SequenceDB;
import org.biojava.bio.seq.io.SeqIOTools;
import org.biojava.bio.symbol.AlphabetManager;
import org.biojava.utils.ChangeVetoException;
 
@SuppressWarnings("deprecation")
public class ClustalWAlign {
 
	// This are Constants, but I'll change...
	private static final String fileFormat = "fasta";
//	private static final String clustalwPath = "D:\\Program Files\\eclipse\\workspace\\CodonAdaptation\\bin\\";
	private static final String clustalwPath1 = codon.class.getClass().getResource("/").getPath().replaceAll("%20", " ")+"ClustalW2/";
	private static final String clustalwPath = clustalwPath1.substring(1).replace("/", "\\");
	private SequenceDB 		dbSequences;
	private String			strAlfa;
	private String 			fileName;
	private Double			guideTree;
	private Double          cScore;
 
 
	public ClustalWAlign () {
 
		this.dbSequences = new HashSequenceDB();
		this.strAlfa = "DNA";
 
	}
 
	public ClustalWAlign (String fileName) {
 
		this.dbSequences = new HashSequenceDB();
		this.strAlfa = "DNA";
		this.fileName = fileName;
 
	}
 
 
	public ClustalWAlign (SequenceIterator itSequences, String strAlfa) throws BioException, ChangeVetoException {
 
		this.dbSequences = new HashSequenceDB();
 
		this.strAlfa = strAlfa;
 
		while (itSequences.hasNext()) {
			this.dbSequences.addSequence(itSequences.nextSequence());
		}
 
	}
 
	public ClustalWAlign (BufferedReader bufSequences, String strAlfa) throws BioException, ChangeVetoException {
 
		this.dbSequences = new HashSequenceDB();
		this.strAlfa = strAlfa;
 
		SequenceIterator itSequences = (SequenceIterator)SeqIOTools.fileToBiojava(fileFormat,strAlfa,bufSequences);	
 
		while (itSequences.hasNext()) {
			this.dbSequences.addSequence(itSequences.nextSequence());
		}		
	}
 
	public void addSequence(Sequence seqSequence) throws BioException, ChangeVetoException {
		this.dbSequences.addSequence(seqSequence);
	}
 
	public void removeSequence(String idSequence) throws BioException, ChangeVetoException {
		this.dbSequences.removeSequence(idSequence);
	}
 
	public int doMultAlign() {	
		int exitVal=999;
 
		try {
		//	System.out.println("clustalwPath:"+clustalwPath);
 
			FileOutputStream newFile = new FileOutputStream(clustalwPath + fileName + ".input");
 
			SeqIOTools.writeFasta(newFile,this.dbSequences);
 
			Runtime rt = Runtime.getRuntime();
 
			String [] strComando =  
								{clustalwPath+"clustalw2.exe",
								"/infile="  + clustalwPath + fileName + ".input",
								"/outfile=" + clustalwPath + fileName + ".output",
								"/output=" + fileFormat,
								"/align"};
 
			Process proc = rt.exec(strComando);
			InputStream stdin = proc.getInputStream();
			BufferedReader br = new BufferedReader(new InputStreamReader(stdin));

			String line = null;
			while ( (line = br.readLine()) != null) {
				// do nothing only read "stdout" from ClustalW
                                // you can put a System.out.print here to prints
                                // the output from ClustalW to console.
				if (line.startsWith("Alignment Score")) {
					String[] array = line.split(" ");
					cScore = (double) Integer.parseInt(array[array.length-1]);
				}
			}
 
			exitVal = proc.waitFor();
	//		System.out.println("exitVal!!"+exitVal);
			if (exitVal == 0) {
				this.dbSequences = SeqIOTools.readFasta(
						new BufferedInputStream(
								new FileInputStream(
										clustalwPath +fileName +".output")),
								AlphabetManager.alphabetForName(strAlfa)
				);
				
				Scanner s = new Scanner(new File(clustalwPath + fileName + ".dnd"));
				s.useDelimiter("\n");
				double tree1=0.0;
				double tree2=0.0;
				double tree3=0.0;
				int q=2;
				while(s.hasNextLine()){
					try{
					s.nextLine();
					String ar= s.next();
					//System.out.println(ar);
					if(ar.startsWith("Sequence2:")){
					 tree2 =Double.parseDouble(ar.substring(10, 17)); 				
			//		System.out.println("tree2。。。"+tree2);						
					}
					if(ar.startsWith("Sequence1:")){
					 tree1 =Double.parseDouble(ar.substring(10, 17)); 				
			//		System.out.println("tree1。。。"+tree1);						
					}
					if(ar.startsWith("Sequence3:")){
					 tree3 =Double.parseDouble(ar.substring(10, 17)); 				
			//		System.out.println("tree3。。。"+tree3);						
					}	
				}catch ( NoSuchElementException elementException ){									  }
				          }
				
				  BigDecimal b1 = new BigDecimal(Double.toString(tree1));         				  			         			  
			      BigDecimal b2 = new BigDecimal(Double.toString(tree2));
			      BigDecimal b3 = new BigDecimal(Double.toString(tree3));
			      BigDecimal b4 = new BigDecimal(q);
				this.guideTree=(b1.add(b1).add(b2).add(b3)).divide(b4).doubleValue();
			//	System.out.println("guideTree:"+guideTree);
			}
 
		} catch (Throwable t) {
			t.printStackTrace();
		}
		return (exitVal);
	}
	
	public Double getScore() {
		return this.cScore;
	}
 
	public void setAlphabet(String strAlfa) {
		this.strAlfa = strAlfa;
	}
 
	public SequenceDB getDBSequences() {
		return this.dbSequences;
	}
 
	public SequenceIterator getIterator() {
		return this.dbSequences.sequenceIterator();
	}
 
	public Double getGuideTree() {
		return guideTree;
	}
 
	public void setGuideTree(Double guideTree) {
		this.guideTree = guideTree;
	}	
}