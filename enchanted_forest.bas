10 gosub 9000: rem initialize
20 gosub 700: rem first location description
   
30 rem message, if any
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
440 if vb>v and ob=0 then m$="I did not understand that."
450 if vb<v and ob>0 and c(ob)=0 then m$="You don't have "+w$
    
500 rem override conditions
    
600 rem branch to subroutines
610 on vb gosub 1000,1100,1200,1200,1200,1200,1200,1200,1200,1500,1500,1600,1700,1800,1900,2000,2100,2200,2400,2400, 2500
    
699 goto 30: rem end of main loop
    
700 rem print location description
710 print "You are at ";d$(rm)
720 rem exits
730 print "Exits: ";
740 for i=1 to len(r$(rm))
750     print mid$(r$(rm),i,1);", ";
760 next i
770 print
780 rem visible objects (flag=0)
790 for i=1 to g
800     if l(i)=rm and f(i)=0 then print "I see ";o$(i);" here"
810 next i
820 return
    
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
1130     if c(i)=1 then print o$(i)
1140 next i
1150 m$=""
1190 return
     
1200 rem go and directions
1210 d=0
1220 if ob=0 then d=vb-3: rem what?
1230 if ob=9 then d=1
1240 if ob=10 then d=2
1250 if ob=11 then d=3
1260 if ob=12 then d=4
1270 if ob=13 then d=5
1280 if ob=14 then d=6
1330 f(16)=0: rl=len(r$(rm))
1340 for i=1 to rl
1350     u$=mid$(r$(rm),i,1)
1360     if u$="n" and d=1 and f(16)=0 then rm=rm-7: f(16)=1
1370     if u$="s" and d=2 and f(16)=0 then rm=rm+7: f(16)=1
1380     if u$="w" and d=3 and f(16)=0 then rm=rm-1: f(16)=1
1390     if u$="e" and d=4 and f(16)=0 then rm=rm+1: f(16)=1
1391     if u$="u" and d=5 and f(16)=0 then rm=rm-7: f(16)=1
1392     if u$="d" and d=6 and f(16)=0 then rm=rm+7: f(16)=1
1400 next i
1410 m$="": rem no need to print message if ok
1420 if f(16)=0 then m$="Can't go that way": return
1430 if d<1 then m$="Go where?": return
1440 gosub 700: rem print location description
1450 if rm=10 and f(11)=0 then gosub 3000: rem handle singing crystals
1460 if rm=23 and c(2)=1 then gosub 3100: rem handle echo chamber
1490 return
     
1500 rem get and take
1505 if (ob=4 or ob=5 or ob=1) and c(7)<>1 then m$="You need a vessel to carry it": return
1510 if ob>g then m$="I can't get "+w$: return
1520 if l(ob) <> rm then m$="It isn't here"
1530 if f(ob) <> 0 then m$="What "+w$+"?"
1540 if c(ob)=1 then m$="You already have it"
1550 if ob>0 and l(ob)=rm and f(ob)=0 then c(ob)=1: l(ob)=65: m$="You have the "+w$
1590 return
     
1600 rem examine
1605 rem examine branches (19) at 0 to reveal lichen (8)
1610 if rm=0 and ob=19 then f(8)=0: m$="You found beard lichen": return
1615 rem examine wall (20) at 43 to reveal star chart (21)
1620 if rm=43 and ob=20 then f(21)=0: m$="You found a star chart": return
1625 rem examine star chart (21) at 43
1630 if rm=43 and ob=21 then m$="You see star, moon and comet": return
1635 rem examine fern (27) at 21 to reveal dewdrop (5)
1640 if rm=28 and ob=27 then f(5)=0: m$="You found a misty dewdrop": return
1645 rem examine bush (28) at 27 to reveal berry (6)
1650 if rm=27 and ob=28 then f(6)=0: m$="You found a whispering berry": return
1685 m$="You see nothing special about "+w$
1690 return
     
1700 rem use
1710 rem use lichen (8) at 1 to reveal fragment (3)
1720 if rm=1 and ob=8 then f(3)=0: m$="The Heartstone Fragment is released": return
1730 m$="It does not seem to do anything"
1790 return
     
1800 rem touch
1810 rem touch fragment (3) at 2 to recharge veins f(9)=1
1820 if rm=2 and ob=3 then f(9)=1: m$="You recharge the Crystal Veins": return
1830 if rm=37 then gosub 2300: return: rem touch celestials
1840 if rm=3 and f(9)=1 and f(10)=1 and f(11)=1 then gosub 3200: rem win
1850 if rm=3 then m$="The obelisk is still corrupted": return
1880 m$="It does not work"
1890 return
     
1900 rem listen
1910 if rm=27 then f(12)=1: m$="The stones whisper about stars": return
1920 if rm=34 then f(13)=1: m$="The stars above whisper about comets": return
1930 if rm=41 then f(14)=1: m$="The willows whisper about moon": return
1940 m$="Trees whisper incomprehensible things"
1990 return
     
2000 rem speak
2010 rem if at altar (48) and have listened to all whispers reveal vessel
2020 if rm=48 and f(12)=1 and f(13)=1 and f(14)=1 then f(7)=0: m$="The altar opens": return
2080 m$="You speak of things but no one listens"
2090 return
     
2100 rem score
2190 return
     
2200 rem look
2210 gosub 700: rem print location description
2220 m$=""
2230 return
     
2300 rem touch celestials in correct order
2310 if f(17)=0 and ob=22 then f(17)=1: m$="The star starts glowing": return
2320 if f(17)=1 and ob=23 then f(17)=2: m$="The moon starts glowing": return
2330 if f(17)=2 and ob=24 then f(4)=0: m$="The Celestial Tear forms in the air": return
2340 f(17)=0: m$="All celestial symbols stop glowing"
2350 return
     
2400 rem mix and brew
2410 if rm=17 and c(4)=1 and c(5)=1 and c(6)=1 then f(1)=0: m$="You mix an essence": return
2420 if rm=17 then m$="You are missing ingredients": return
2480 m$="This is not the place to mix ingredients"
2490 return

2500 rem pour
2510 if rm=9 and c(1)=1 then f(10)=1: m$="You purify the Mirror Pool": return
2520 m$="This is not the place to pour anything"
2590 return

3000 rem location 10
3010 rem if carrying unloaded (f(15)) echoing petal (2)
3020 if c(2)=1 and f(15)=0 then m$="The petal echoes with the song of the   crystals, but something is missing.": return
3030 if c(2)=1 and f(15)=1 then f(11)=1: m$="The petal sings to crystals and they    respond": return
3040 m$="It is very silent"
3090 return

3100 rem echo chamber
3110 if c(2)=1 then f(15)=1: m$="The petal collects the echoes of the    chamber": return
3120 return

3200 rem win
3210 print"A small stream of silvery water flows   from the Mirror Pool to the obelisk.":print
3220 print"A spark of lighting from the Crystal    Veins hits the obelisk.":print
3230 print"The Crystals' song shatters the         corruption from the obelisk.":print
3240 print"The Obelisk has been restored, and with it the magic to the forest.":print
3250 print"You have succeeded in your quest!"
3260 end

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
9060 v=21: rem number of verbs
9070 dim v$(v): rem verbs
9080 g=8: rem number of gettable objects
9090 dim l(g): rem locations of gettable objects
9100 dim c(w): rem which objects player is carrying
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
10210 f(1)=1: f(2)=0: f(3)=1: f(4)=1: f(5)=1: f(6)=1: f(7)=1: f(8)=1
10220 rem f(9): Crystal veins restored
10230 rem f(10): Mirror pool restored
10240 rem f(11): Singing crystals restored
10250 rem f(12-14): Sounds 1-3 heard
10260 rem f(15): Echo petal loaded
10270 rem f(16): Has found an exit
10280 rem f(17): Correctly touched celestials in order star, moon, comet
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
20310 data help, inventory, go, n, s, w, e, u, d, "get", take, examine, use, touch, listen, speak, score, look, mix, brew, pour

20400 rem locations of gettable objects, l()
20410 data 17,42,1,37,28,27,48,0


      

   
