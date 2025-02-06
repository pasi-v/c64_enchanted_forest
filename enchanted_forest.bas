10 gosub 9000: rem initialize
   
20 rem description and feedback messages
30 print "Your location:": print d$(rm)
40 rem exits
50 print "Exits: ";
60 for i=1 to len(r$(rm))
70     print mid$(r$(rm),i,1);", ";
80 next i
90 rem visible objects (flag=0)
100 for i=1 to g
110     if l(i)=rm and f(i)=0 then print "I see ";o$(i);" here"
120 next i
130 rem message, if any
140 print m$
150 m$="What?": rem to be overwritten by subroutine
   
200 rem input
220 input q$
230 v$=""
240 w$=""
250 for i=1 to len(q$)
260     if mid$(q$,i,1)=" " and v$="" then v$=left$(q$,i-1)
270     if mid$(q$,i+1,1)<>" " and v$<>"" then w$=mid$(q$,i+1,len(q$)-1): i=len(q$)
280 next i
290 if w$="" then v$=q$
 
300 rem input analysis
310 vb=0: rem index of matching verb
320 for i=1 to v
330     if v$=v$(i) then vb=i
340 next i
    
350 ob=0: rem index of matching object
360 for i=1 to w
370     if w$=o$(i) then ob=i
380 next i
	
390 rem error messages
400 if w$>"" and ob=0 then m$="That's silly": rem change to something sensible
410 if vb=0 then vb=v+1
420 if w$="" then m$="I need two words"
430 if vb>v and ob>0 then m$="You can't '"+q$+"'"
440 if vb>v and ob=0 then m$="I did not understand a word of that."
450 if vb<v and ob>0 and c(ob)<>1 then m$="You don't have "o$(ob)
    
500 rem override conditions
    
600 rem branch to subroutines
610 on vb gosub 1000,1100,1200,1200,1200,1200,1200,1200,1200
620 rem ...the rest after writing go subroutine
    
699 goto 20: rem end of main loop
    
1000 rem help
1010 print "Words I know:"
1020 for i=1 to v
1030     print v$(i);", ";
1040 next i
1050 m$="":print
1090 return
     
1100 rem inventory
1110 print "You are carrying:"
1120 for i=1 to g
1130     if c(i)=1 then print o$(i);", ";
1140 next i
1150 m$="":print
1190 return
     
1200 rem go and directions
1300 return
   
8998 end   
8999 rem initialize 
9000 rem reserve arrays
9001 print chr$(14): rem character set
9002 print "{clr}Enchanted Forest": print "Loading data..."
9005 rm=5: rem starting location
9010 nr=49: rem number of rooms
9020 dim d$(nr): rem room descriptions
9030 dim r$(nr): rem routes
9040 w=29: rem number of object words
9050 dim o$(w): rem object words
9060 v=17: rem number of verbs
9070 dim v$(v): rem verbs
9080 g=8: rem number of gettable objects
9090 dim l(g): rem locations of gettable objects
9100 dim c(g): rem which objects player is carrying
9110 dim f(w): rem state of each object: 0=normal/inactive, 1=activated
    
10005 rem room descriptions
10010 for i=0 to nr-1
10020     read d$(i)
10030 next i
10040 rem routes
10050 for i=0 to nr-1
10060     read r$(i)
10070 next i
10080 rem object words
10090 for i=1 to w
10100     read o$(i)
10110 next i
10120 rem verbs
10130 for i=1 to v
10140     read v$(i)
10150 next i
10160 rem locations of objects
10170 for i=1 to g
10180     read l(i)
10190 next i
10200 rem flags for invisible objects
10210 f(1)=1: f(2)=1: f(3)=1: f(4)=1: f(5)=1: f(6)=1: f(7)=1: f(8)=1
10220 rem f(9): Crystal veins restored
10230 rem f(10): Mirror pool restored
10240 rem f(11): Singing crystals restored
10250 rem f(12-14): Sounds 1-3 heard
10260 rem f(15): Echo petal loaded
19999 return
      
20000 rem data
20010 rem room descriptions, d$()
20020 data Whispering branches, "Elder's Nook", Crystal veins, Crystal obelisk, Shattered entrance, Enchanted ring, Twinkling Pond
20030 data Great trunk, Rooted path, Mirror pool, Singing crystals, Faery statues, Whispering breeze, Hidden pathway
20040 data Echoing glade, Memory trees, Standing stones, Moonlit pond, Celestial path, Silver altar, Faery lanterns
20050 data Whispering winds, Echoing pool, Echo chambers, Twisted roots, Gnarled tree, Luminescent grove, Luminous stones
20060 data Whispering ferns, Foggy grove, Thorny barrier, Enchanted clearing, Bramble maze, Shadowy path, Echoing clearing
20070 data Enchanted mists, Misty pond, Ancient observatory, Glimmering falls, Reflected grove, Swaying reeds, Whispering willows
20080 data "Lost traveler's camp", Crumbling temple, Timeworn library, Echoing hall, Forgotten garden, Wishing stones, Forgotten altar
      
20100 rem routes, r$()
20110 data d,s,se,wse,wse,wse,ws
20120 data use,nwse,nwe,nw,ne,nwe,nws
20130 data ns,nwse,ws,e,we,wse,nw
20140 data nes,nesw,nw,se,sw,ne,ws
20150 data nes,nesw,ew,nesw,new,ew,nsw
20160 data nes,nw,d,ne,we,sw,ns
20170 data n,e,uew,we,we,nw,n
      
20200 rem object words, o$()
20210 data essence, echoing petal, heartstone fragment, celestial tear, misty dewdrop, whispering berry, vessel of reflection
20220 data beard lichen, north, south, west, east, up, down, crystal obelisk, crystal veins, mirror pool, singing crystals, branches
20230 data wall, star chart, star, moon, comet, sun, planet, fern, bush, altar
      
20300 rem verbs, v$()
20310 data help, inventory, go, n, s, w, e, u, d, "get", take, examine, use, touch, listen, speak, score

20400 rem locations of gettable objects, l()
20410 data 17,34,1,37,21,27,48,0


      

   
