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
710 print d$(rm)
715 x1$=ld$(rm): gosub 830: rem print long string
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

830 rem display x1$ without splitting words
840 xx$=x1$
850 pp=len(xx$)
860 if pp<=40 then rr=pp: gosub 910: return
870 for qq=41 to 1 step -1
880     if mid$(xx$,qq,1) = " " then rr=qq-1: gosub 910: xx$=right$(xx$,pp-qq): goto 850
890 next qq
900 rr=40:gosub 910:xx$=right$(xx$,pp-40): goto 850
910 rem internal subroutine
920 print left$(xx$, rr);: if rr<40 then print
930 return
    
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
9020 dim d$(nr): rem room names
9025 dim ld$(nr): rem room long descriptions
9030 dim r$(nr): rem routes
9040 w=29: rem number of object words
9050 dim o$(w): rem object words
9060 v=21: rem number of verbs
9070 dim v$(v): rem verbs
9080 g=8: rem number of gettable objects
9090 dim l(g): rem locations of gettable objects
9100 dim c(w): rem which objects player is carrying
9110 dim f(w): rem state of each object: 0=normal/inactive, 1=activated
    
10005 rem room names
10010 for i=0 to nr-1
10020     read d$(i)
10030 next i
10035 for i=0 to nr-1
10037     read ld$(i)
10038 next i
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
      
11000 print"{clr}You'd seen the ring of mushrooms"
11001 print"before - half-hidden beneath leaves on"
11002 print"the edge of the old trail. Something"
11003 print"about it always made you pause. This"
11004 print"morning, you stepped across it.":print
11005 print"The air changed. The forest around you"
11006 print"deepened into twilight. Colours"
11007 print"shimmered. Silence thickened. You"
11008 print"weren't sure if you were dreaming, but"
11009 print"it felt familiar - as if you'd been"
11010 print"here before, long ago, or in sleep.":print
11011 print"Now you're surrounded by strange"
11012 print"beauty... and quiet sorrow. Something"
11013 print"in this place is wrong. The trees"
11014 print"whisper it. The stones remember it.":print
11015 print"There's a wound here. You can feel it.":print
11016 print"And you know, somehow, that you are"
11017 print"meant to set it right.":print:print
11027 print"Press a key to start your adventure.";
11037 get zz$:if zz$="" then 11037
11047 print:print

19999 return
      
20000 rem data
20010 rem room names, d$()
20020 data Whispering branches, "Elder's Nook", Crystal veins, Crystal obelisk, Shattered entrance, Enchanted ring, Twinkling Pond
20030 data Great trunk, Rooted path, Mirror pool, Singing crystals, Faery statues, Whispering breeze, Hidden pathway
20040 data Echoing glade, Memory trees, Sounding stones, Moonlit pond, Celestial path, Silver altar, Faery lanterns
20050 data Whispering winds, Echoing pool, Echo chambers, Twisted roots, Gnarled tree, Luminescent grove, Luminous stones
20060 data Whispering ferns, Foggy grove, Thorny barrier, Enchanted clearing, Bramble maze, Shadowy path, Echoing clearing
20070 data Enchanted mists, Misty pond, Ancient observatory, Glimmering falls, Reflected grove, Swaying reeds, Whispering willows
20080 data "Lost traveler's camp", Crumbling temple, Timeworn library, Echoing hall, Forgotten garden, Wishing stones, Forgotten altar
      
20090 rem long descriptions, ld$()
20100 data "The lower branches of the Ancient Oak are thick and sprawling, creating a canopy that filters sunlight into beautiful patterns on the ground."
20110 data "A small clearing at the base of the tree, surrounded by fallen leaves and littered with curious stones and artifacts from previous visitors."
20120 data "Narrow corridors lined with glittering veins of crystals, pulsating with faint magical energy. These veins seem to be connected to the forest's magic, but their glow is dim, as if something is draining their power."
20130 data "A towering obelisk made of dark, corrupted crystal stands in the heart of the cave. It crackles with sinister energy, contrasting with the rest of the cave's dim glow. This is the source of the forest's corruption."
20140 data "The entrance to the cave is a large, jagged opening surrounded by shimmering crystal shards embedded in the ground and walls. The light reflects off the crystals, casting faint rainbows along the cavern floor."
20150 data "A ring of vibrant mushrooms glowing softly in various colors. The air feels charged with magic."
20160 data "A small, crystal-clear pond at the center of the circle, reflecting the stars above, even during the day. Tiny lights flit above the water's surface, resembling faeries."
20170 data "The colossal trunk of the Ancient Oak. Its bark is adorned with intricate carvings and symbols representing the history and magic of the forest. The air around the trunk feels charged with energy."
20180 data "A winding pathway formed by the exposed roots of the Ancient Oak, leading away from the tree and toward the Crystal Cave and the Grove of Echoes. The roots seem to pulse gently, as if alive."
20190 data "A small underground pool surrounded by crystal formations. The water is still, almost unnaturally so, reflecting the surrounding crystals perfectly."
20200 data "A chamber filled with hanging crystals that chime faintly when touched. The sound they produce is melodic and soothing, but also feels incomplete, as if part of the harmony is missing."
20210 data "A collection of ancient stone statues depicting faeries in various poses, overgrown with vines and flowers. Some statues seem to shimmer as if they are alive."
20220 data "A clearing within the circle where the wind carries soft, melodious whispers. The breeze seems to speak."
20230 data "A narrow, winding path that is lined with luminous flowers that glow brighter with each step."
20240 data "A small open area near the base of the Ancient Oak, where the sounds of the grove blend harmoniously with the whispers of the tree. The ground is carpeted with soft moss, and the atmosphere feels tranquil yet alive."
20250 data "A group of ancient trees with twisted trunks and gnarled branches. Each tree seems to pulse with a faint glow and resonates with the echoes of past conversations and events."
20260 data "A circle of large, flat stones that emit different tones when struck. Each stone resonates with its unique sound, and when played together, they create a haunting melody."
20270 data "A tranquil pond that perfectly mirrors the moon above, making it look like a piece of the sky has fallen to the earth. The water shimmers and ripples gently, with occasional fish gliding beneath the surface."
20280 data "A winding trail that glows faintly underfoot, resembling a starry sky. This path leads to various other locations within the Moonlit Glade and connects to hidden areas throughout the forest."
20290 data "A flat stone altar surrounded by a circle of white pebbles that reflects the moonlight beautifully. The altar is engraved with ancient symbols that hint at the magic of the forest."
20300 data "A cluster of floating lanterns that drift gently through the air, illuminating the glade with soft, colorful light. Each lantern holds a different memory or story related to the forest."
20310 data "A section of the grove where the wind carries whispers and sounds from different parts of the forest. The rustling leaves create a harmonious backdrop, enhancing the mystical atmosphere."
20320 data "A small, still pond at the center of the grove. The surface reflects the sky, but ripples and echoes distort the reflections, showing fleeting glimpses of past events."
20330 data "A large, open space surrounded by high, curved walls of stone and dense trees that create a natural amphitheater. Sounds reverberate here, making whispers and footsteps echo dramatically."
20340 data "A network of exposed roots that protrude from the ground, forming an intricate pattern. Some roots glow faintly, suggesting a connection to the forest's magic."
20350 data "An ancient tree with twisted roots and branches that seem to form a natural archway. The tree is home to various insects and small creatures, adding to the vibrant ecosystem of the thicket."
20360 data "A serene area filled with tall, shimmering trees that seem to glow softly in the moonlight. Bioluminescent flowers carpet the ground, illuminating the paths with a gentle, ethereal light."
20370 data "A circle of smooth, glowing stones, each radiating a different color. The stones pulse rhythmically, and the whispers seem to crescendo as you approach."
20380 data "A cluster of large ferns that sway gently, even when there's no wind. The ferns emit soft, whispering sounds, which seem to echo the conversations of past travelers."
20390 data "A secluded area filled with dense fog that makes visibility low. Shadows dance in the mist, creating an eerie yet magical atmosphere. The ground is soft and covered with dew-kissed grass."
20400 data "A thick wall of intertwined thorns that separates the thicket from the other areas. It glimmers slightly, hinting at some magical protection."
20410 data "A small clearing within the thicket that seems oddly peaceful despite the surrounding thorns. Here, the ground is soft, and a few wildflowers bloom brightly, illuminated by a shaft of moonlight filtering through the branches."
20420 data "A dense labyrinth of thorny vines and bushes that shift and change, making it difficult to find a way through. The air is thick with the scent of wildflowers and the sound of rustling leaves."
20430 data "A narrow, winding trail that appears darker than the surrounding area. The whispers here grow louder and more intense, creating a sense of urgency."
20440 data "A wide, open space surrounded by towering trees. The sound of whispers reverberates through the glade, creating an almost hypnotic effect. The ground is covered in soft moss, making it feel like a natural amphitheater."
20450 data "An area where the fog thickens and glows faintly. Magical creatures can be seen flitting about, though they remain elusive. The mist seems to change colour."
20460 data "A serene pond shrouded in mist, with the water reflecting the ghostly outlines of the trees around it. Occasionally, shimmering shapes can be seen moving just beneath the surface."
20470 data "A circular stone structure with an open roof, surrounded by faded star maps and celestial carvings. It feels alive with the magic of the stars and is an excellent place to stargaze."
20480 data "A picturesque waterfall where the stream cascades down a series of smooth stones, creating a dazzling display of shimmering water that sparkles in the sunlight. Mist rises from the base, creating a magical atmosphere."
20490 data "A serene area where the stream widens, creating a mirrored surface that perfectly reflects the trees and sky above. The tranquility is occasionally disturbed by the sounds of nature."
20500 data "Tall reeds line the banks of the stream, swaying gently in the breeze. The rustling sounds create a soothing backdrop."
20510 data "A cluster of ancient willow trees, their long, draping branches swaying gently despite the absence of wind. The willows seem to murmur softly, sharing stories of the forest's past."
20520 data "An abandoned campsite with remnants of a fire, scattered belongings, and signs of a previous traveler who got lost in the mist. Old maps and notes lie around, hinting at forgotten paths and treasures."
20530 data "The remnants of a once-grand temple, with broken pillars and an ornate entrance partially concealed by vines and moss. Mysterious carvings adorn the walls, hinting at the history of Eldoria."
20540 data "A large room filled with dusty shelves that hold ancient books and scrolls, some of which are partially disintegrated. A few tomes still radiate magical energy, hinting at their importance."
20550 data "A vast hall with a high ceiling and shattered stained-glass windows, allowing beams of sunlight to filter in. The acoustics here amplify sounds, creating a haunting atmosphere as echoes of the past can be heard."
20560 data "A once-beautiful garden now overtaken by weeds and wildflowers. Crumbling stone paths lead to a central fountain, which is dry but still holds remnants of enchantment."
20570 data "A series of flat stones arranged in a line across the stream, each engraved with symbols that represent different wishes or desires. The stones are partially submerged and appear to glow faintly."
20580 data "An ancient stone altar overgrown with vines and moss. The surface is etched with faded runes that seem to come alive when whispered to."

20600 rem routes, r$()
20610 data d,s,se,wse,wse,wse,ws
20620 data use,nwse,nwe,nw,ne,nwe,nws
20630 data ns,nwse,ws,e,we,wse,nw
20640 data nes,nesw,nw,se,sw,ne,ws
20650 data nes,nesw,ew,nesw,new,ew,nsw
20660 data nes,nw,d,ne,we,sw,ns
20670 data n,e,uew,we,we,nw,n
      
20680 rem object words, o$()
20690 data essence, echoing petal, heartstone fragment, celestial tear, misty dewdrop, whispering berry, vessel of reflection
20700 data beard lichen, north, south, west, east, up, down, crystal obelisk, crystal veins, mirror pool, singing crystals, branches
20710 data wall, star chart, star, moon, comet, sun, planet, fern, bush, altar
      
20720 rem verbs, v$()
20730 data help, inventory, go, n, s, w, e, u, d, "get", take, examine, use, touch, listen, speak, score, look, mix, brew, pour

20740 rem locations of gettable objects, l()
20750 data 17,42,1,37,28,27,48,0


      

   
