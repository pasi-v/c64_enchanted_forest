200 print "{clr}"
210 print "please type something"
220 input q$
230 v$=""
240 w$=""
250 for i=1 to len(q$)
260     if mid$(q$,i,1)=" " and v$="" then v$=left$(q$,i-1)
270     if mid$(q$,i+1,1)<>" " and v$<>"" then w$=mid$(q$,i+1,len(q$)-1): i=len(q$)
280 next i
290 if w$="" then v$=q$
300 m$="these are your 2 words"
310 print "first word=";v$
320 print"second word=";w$
330 if w$="" then m$="you only typed one word"
340 if w$="" and v$="" then m$="you didn't type anything"
350 print m$
360 stop
    
