import sys,os
import webbrowser
from Bio.Seq import Seq
from Bio.Alphabet import IUPAC
from Bio.Seq import Seq,reverse_complement, transcribe, back_transcribe, translate
from Bio import SeqIO
file_name_input=sys.argv[1]
file_type="fasta"
species="ecoli"
sd_dict={"ecoli":"AGGAGGT"}
sd_seq=sd_dict[species]
species_dict_file=open(species)
codon_key=[]
codon_value=[]
codon_count={}
for line in species_dict_file:
      line=line.strip().split()
      codon_key.append(line[0])
      codon_value.append(int(line[1]))
      codon_count=dict(zip(codon_key,codon_value))

species_dict_file.close()
      

Ala=A=["GCT","GCC","GCA","GCG"]
Arg=R=["CGT","CGC","CGA","CGG","AGA","AGG"]
Asn=N=["AAT","AAC"]
Asp=D=["GAT","GAC"]
Cys=C=["TGT","TGC"]
Gln=Q=["CAA","CAG"]
Glu=E=["GAA","GAG"]
Gly=G=["GGT","GGC","GGA","GGG"]
His=H=["CAT","CAC"]
Ile=I=["ATT","ATC","ATA"]
Leu=L=["TTA","TTG","CTT","CTC","CTA","CTG"]
Lys=K=["AAA","AAG"]
Met=M=["ATG"]
Phe=F=["TTT","TTC"]
Pro=P=["CCT","CCC","CCA","CCG"]
Ser=S=["TCT","TCC","TCA","TCG","AGT","AGC"]
Thr=T=["ACT","ACC","ACA","ACG"]
Trp=W=["TGG"]
Tyr=Y=["TAT","TAC"]
Val=V=["GTT","GTC","GTA","GTG"]
stop_codon=X=["TGA","TAA","TAG"]

aa=[A,R,N,D,C,Q,E,G,H,I,L,K,M,F,P,S,T,W,Y,V,X]
aa_dic={"A":A,"R":R,"N":N,"D":D,"C":C,"Q":Q,"E":E,"G":G,"H":H,"I":I,"L":L,"K":K,"M":M,"F":F,"P":P,"S":S,"T":T,"W":W,"Y":Y,"V":V,"X":X}
aa_str=["A","R","N","D","C","Q","E","G","H","I","L","K","M","F","P","S","T","W","Y","V","X"]

stop_codon=X=["TGA","TAA","TAG"]
start_codon=["ATG","GTG"]

base=["A","T","C","G"]
aa_list=["G","A","V","L","I","P","F","Y","W","S","T","C","M","N","Q","D","E","K","R","H","*","STOP"]

type_base={}


def clustal(aa_seq,sd):
      aa_seq=str(aa_seq).replace("*","X")
      sd_length=len(sd)
      cut_off_pos=sd_length/2
      sd1=str(sd[0:cut_off_pos])
      sd2=str(sd[cut_off_pos:])
      fsd=sd2+sd1
      if len(aa_seq)%2==1:
            aa_seq=aa_seq[1:]
            nuc_seq_fast="ATG"
            nuc_seq_slow="ATG"
      else:
            aa_seq=aa_seq
            nuc_seq_fast=""
            nuc_seq_slow=""
      
      for k in range(len(aa_seq)/2):
            aa_pair=str(aa_seq[2*k:2*k+2])
            aa1=aa_pair[0]
            aa2=aa_pair[1]
            distance_max=0
            distance_min=10
            codonpair_fast=""
            codonpair_slow=""
            for codon1 in aa_dic[aa1]:
                  for codon2 in aa_dic[aa2]:
                        codon_pair=codon1+codon2
                        file_name=sd+"_"+aa_pair+"_"+codon_pair
                        #print file_name
                        file_handle=open(file_name,"w")
                        file_handle.write(">sd"+"\n"+str(sd)+"\n"+">fsd"+"\n"+str(fsd)+"\n"+">"+str(codon_pair)+"\n"+str(codon_pair)+"\n")
                        file_handle.close()
                        cmd=str("clustalw"+" "+file_name+" >"+file_name+".res")
                        os.system(cmd)
                        file_read_open=open(file_name+".dnd","r")
                        file_read=file_read_open.read()
                        #print file_read
                        index1=file_read.find("sd:")+3
                        index2=file_read.find("fsd:")+4
                        index3=file_read.find(str(codon_pair)+":")+6
                        #print file_name
                        distance1=float(file_read[index1:index1+7])
                        distance2=float(file_read[index2:index2+7])
                        distance3=float(file_read[index3+1:index3+7])
                        file_read_open.close()
                        #print distance1,distance2,distance3
                        distance=(distance1+distance3+distance2+distance3)/2
                        #print codon_pair,distance
                        os.remove(file_name)
                        os.remove(file_name+".aln")
                        os.remove(file_name+".dnd")
                        os.remove(file_name+".res")

                        if distance>distance_max:
                              distance_max=distance
                              codonpair_fast=codon_pair

                        elif distance==distance_max and int(codon_count[codonpair_fast])-int(codon_count[codon_pair])<0:
                              distance_max=distance
                              codonpair_fast=codon_pair
                        else:
                              distance_max=distance_max
                              codonpair_fast=codonpair_fast
                              

                        if distance<distance_min:
                              distance_min=distance
                              codonpair_slow=codon_pair
                        elif distance==distance_min and int(codon_count[codonpair_slow])-int(codon_count[codon_pair])>0:
                              distance_min=distance
                              codonpair_slow=codon_pair
                        else:
                              distance_min=distance_min
                              codonpair_slow=codonpair_slow
                              

            nuc_seq_fast=nuc_seq_fast+codonpair_fast
            nuc_seq_slow=nuc_seq_slow+codonpair_slow
            
      return nuc_seq_fast,nuc_seq_slow,1.0*(nuc_seq_fast.count("A")+nuc_seq_fast.count("G"))/len(nuc_seq_fast),1.0*(nuc_seq_slow.count("A")+nuc_seq_slow.count("G"))/len(nuc_seq_slow),1.0*(nuc_seq_fast.count("C")+nuc_seq_fast.count("G"))/len(nuc_seq_fast),1.0*(nuc_seq_slow.count("C")+nuc_seq_slow.count("G"))/len(nuc_seq_slow)

      
      




def orf_find(seq,a_n_type):
      if len(seq)%3==0 and a_n_type=="nt":
            aa=seq.translate()
            if (str(seq[0:3]) in start_codon) and (str(seq[-3:]) in stop_codon) and ("*" not in str(aa)[0:-1]):
                  return clustal(seq.translate(),str(sd_seq))
            elif (str(seq[0:3]) not in start_codon) and (str(seq[-3:]) in stop_codon) and ("*" not in str(aa)[0:-1]):
                  print "The sequence is lack of initiation codon ,a initiation codon has been added to the head of the  sequence.\n"         
                  return clustal(str("M")+seq.translate(),str(sd_seq))
            elif (str(seq[0:3]) in start_codon) and (str(seq[-3:]) not in stop_codon) and ("*" not in str(aa)[0:-1]):
                  print "The sequence is lack of termination codon,a termination codon has been added to the tail of the sequence.\n"         
                  return clustal(seq.translate()+str("*"),str(sd_seq))
            elif (str(seq[0:3]) not in start_codon) and (str(seq[-3:]) not in stop_codon) and ("*" not in str(aa)[0:-1]):
                  print "The sequence is lack of initiation codon and termination codon ,a initiation codon and a termination codon have been added to the head and tail of the sequence respectively.\n"         
                  return clustal(str("M")+seq.translate()+str("*"),str(sd_seq))

            elif (str(seq[0:3]) in start_codon) and (str(seq[-3:]) in stop_codon) and ("*" in str(aa)[0:-1]):
                  print "WARNING:There is(are) a termination codon(s) in the sequence .\n"
                  return clustal(seq.translate(),str(sd_seq))
            elif (str(seq[0:3]) not in start_codon) and (str(seq[-3:]) in stop_codon) and ("*"  in str(aa)[0:-1]):
                  print "The sequence is lack of initiation codon ,a initiation codon has been added to the head of the  sequence.\nWARNING:There is(are) a termination codon(s) in the sequence. \n"         
                  return clustal(str("M")+seq.translate(),str(sd_seq))
            elif (str(seq[0:3]) in start_codon) and (str(seq[-3:]) not in stop_codon) and ("*" in str(aa)[0:-1]):
                  print "The sequence is lack of termination codon,a termination codon has been added to the tail of the sequence.\nWARNING:There is(are) a termination codon(s) in the sequence.\n"         
                  return clustal(seq.translate()+str("*"),str(sd_seq))
            elif (str(seq[0:3]) not in start_codon) and (str(seq[-3:]) not in stop_codon) and ("*" in str(aa)[0:-1]):
                  print "<font color='#0066FF'>The sequence is lack of initiation codon and termination codon ,a initiation codon and a termination codon have been added to the head and tail of the sequence respectively.\nWARNING:There is(are) a termination codon(s) in the sequence.\n"         
                  return clustal(str("M")+seq.translate()+str("*"),str(sd_seq))
      elif len(seq)%3!=0 and a_n_type=="nt":
            return "<font color='#0066FF'>The length of sequence is not 3N,please check your seqence.</font></br>"
      elif a_n_type=="aa":
            aa=seq
            if (str(seq[0])=="M") and (str(seq[-1])=="*") and ("*" not in str(aa)[0:-1]):
                  return clustal(seq,str(sd_seq))
            elif (str(seq[0])!="M") and (str(seq[-1])=="*") and ("*" not in str(aa)[0:-1]):
                  print "The sequence is lack of initiation codon ,a initiation codon has been added to the head of the  sequence.\n"         
                  return clustal(str("M")+seq,str(sd_seq))
            elif (str(seq[0])=="M") and (str(seq[-1])!="*") and ("*" not in str(aa)[0:-1]):
                  print "The sequence is lack of termination codon,a termination codon has been added to the tail of the sequence.\n"         
                  return clustal(seq+str("*"),str(sd_seq))
            elif (str(seq[0])!="M") and (str(seq[-1])!="*") and ("*" not in str(aa)[0:-1]):
                  print "The sequence is lack of initiation codon and termination codon ,a initiation codon and a termination codon have been added to the head and tail of the sequence respectively.\n"         
                  return clustal(str("M")+seq+str("*"),str(sd_seq))

            elif (str(seq[0])=="M") and (str(seq[-1])=="*") and ("*" in str(aa)[0:-1]):
                  print "WARNING:There is(are) a termination codon(s) in the sequence .\n"
                  return clustal(seq,str(sd_seq))
            elif (str(seq[0])!="M") and (str(seq[-1])=="*") and ("*"  in str(aa)[0:-1]):
                  print "The sequence is lack of initiation codon ,a initiation codon has been added to the head of the  sequence.\nWARNING:There is(are) a termination codon(s) in the sequence.\n"         
                  return clustal(str("M")+seq,str(sd_seq))
            elif (str(seq[0])=="M") and (str(seq[-1])!="*") and ("*" in str(aa)[0:-1]):
                  print "The sequence is lack of termination codon,a termination codon has been added to the tail of the sequence.\nWARNING:There is(are) a termination codon(s) in the sequence.\n "         
                  return clustal(seq+str("*"),str(sd_seq))
            elif (str(seq[0])!="M") and (str(seq[-1])!="*") and ("*" in str(aa)[0:-1]):
                  print "The sequence is lack of initiation codon and termination codon ,a initiation codon and a termination codon have been added to the head and tail of the sequence respectively.\nWARNING:There is(are) a termination codon(s) in the sequence.\n "         
                  return clustal(str("M")+seq+str("*"),str(sd_seq))
                  
            
      

def judge_char(seq,AA_or_base):
      seq_str_2_list=list(seq)
      seq_list_2_set=list(set(seq_str_2_list))
      tag_base=0
      for item in seq_list_2_set:
            if item not in AA_or_base:
                  tag_base+=1
            else:
                  None
      return tag_base

for record in SeqIO.parse(file_name_input,"fasta"):
      input_seq=record.seq
      nuc_or_aa=1.0*(input_seq.count("A")+input_seq.count("T")+input_seq.count("C")+input_seq.count("G"))/len(input_seq)
      if nuc_or_aa<0.85:
            tag_base=judge_char(input_seq,aa_list)
            if tag_base>0:
                  print "There are some non-amino acid character in your sequence,maybe you chose an incorrect format, please check your seqence.\n"
            else:
                  out_put=orf_find(str(input_seq),"aa")
                  print "The fast sequence is:(G+C%:",out_put[4],";A+G%:",out_put[2],")","\n"
                  print ">fast_sequence\n"
                  def fasta_output(seq,k):
                        print str(seq[70*k:70+70*k])
                  for k in range((len(str(out_put[0]))/70)+1):
                              fasta_output(str(out_put[0]),k)

                  print "\nThe slow sequence is:(G+C%:",out_put[5],";A+G%:",out_put[3],")","\n"
                  print ">slow_sequence\n"
                  for i in range((len(str(out_put[1]))/70)+1):
                              fasta_output(str(out_put[1]),i)
                  print "\n"
                  
      else:
            tag_base=judge_char(input_seq,base)
            if tag_base>0:
                  print "There are some non-nucleotide character in your sequence,maybe you chose an incorrect format, please check your seqence.\n"
            else:
                  trans_aa=orf_find(input_seq,"nt")
                  if "Length of sequence is not 3N" in str(trans_aa):
                        print "The length of sequence is not 3N,please check your seqence.\n"
                  else:
                        print "The fast sequence is:(G+C%:",trans_aa[4],";A+G%:",trans_aa[2],")","</br>"
                        print ">fast_sequence\n"
                        def fasta_output(seq,k):
                              print str(seq[70*k:70+70*k])
                        for k in range((len(str(trans_aa[0]))/70)+1):
                                    fasta_output(str(trans_aa[0]),k)

                        print "\nThe slow sequence is:(G+C%:",trans_aa[5],";A+G%:",trans_aa[3],")","\n"
                        print ">slow_sequence\n"
                        for i in range((len(str(trans_aa[1]))/70)+1):
                                    fasta_output(str(trans_aa[1]),i)
                        print "\n"

