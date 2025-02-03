100 print "{clr}"
110 print "please type something"
120 input q$
130 v$=""
140 w$=""
150 for i=1 to len(q$)
160     if mid$(q$,i,1)=" " and v$="" then v$=left$(q$,i-1)
170     if mid$(q$,i+1,1)<>" " and v$<>"" then w$=mid$(q$,i+1,len(q$)-1): i=len(q$)
180 next i
190 if w$="" then v$=q$
200 m$="these are your 2 words"
210 print "first word=";v$
220 print"second word=";w$
230 if w$="" then m$="you only typed one word"
240 if w$="" and v$="" then m$="you didn't type anything"
250 print m$
260 stop
    
