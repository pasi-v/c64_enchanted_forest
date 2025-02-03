10 gosub 9000: rem initialize
   
20 rem description and feedback messages
30 print "Your location:": print d$(rm)
40 rem exits
50 print "Exits: ";
60 for i=1 to len(r$(rm))
70     print mid$(r$(rm),i,1);", ";
80 next i
   
200 rem input analysis
    
300 rem error messages and override conditions
    
400 rem branch to subroutines
    
500 rem set up other messages
    
   
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


      

   
