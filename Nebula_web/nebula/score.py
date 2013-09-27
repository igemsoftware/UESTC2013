import math
import sys,os
data=sys.argv[1:]
#print data
s_open=open("score")
igem_id=[]
score=[]
id_score={}
for item in s_open:
      item=item.strip().split()
      igem_id.append(item[0])
      score.append(float(item[1]))
      id_score=dict(zip(igem_id,score))

#print id_score["BBa_K082003"]
s_open.close()
def get_socre(list_igem):
      score=0
      for item in list_igem:
            if math.log(id_score[item],10)!=0:
                  score=score-math.log(id_score[item],10)
            else:
                  score=score+0
      return 1.0/score
print get_socre(data)

      
