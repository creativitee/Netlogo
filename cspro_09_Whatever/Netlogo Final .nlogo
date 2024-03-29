globals [old-gun-heading was-mouse-down?]
breed [players player]
breed [spiders spider]
breed [bosses boss]
breed [soldiers soldier]
breed [guns gun]
breed [bullets bullet]
breed [powerups powerup]
breed [hearts heart]
breed [ladders ladder]
players-own [Tears-Speed Tears-Damage HP]
spiders-own [HP]
soldiers-own [HP]
patches-own [OrigMap]

;SETUP
to setup
  resize-world -24 24 -16 16
  ca
  reset-ticks
  import-pcolors "Final_edit.png"
  user-message "The Binding Of Isaac! (Abridged)"
  user-message "Hello!"
  user-message "This is our Comp Sci. Final Project, Binding of Isaac(Abridged)!"
  user-message "What Binding of Isaac is essentially, is a RPG game that is based in a dungeon"
  create-players 1 [player-setup]
  create-spiders 0[fighters-setup]
  create-soldiers 0 [soldiers-setup]
  ask patches [set OrigMap [pcolor] of patches]
  Next-Map
  tick
end

;player setup
to player-setup
  ask players [set shape Choose_a_Character]
  ask players 
  [
    set HP 3
    set size 5 
  ]
  hp-labeling
end

;fighters setup
to fighters-setup
  ask spiders [set shape "person"]
  set HP 2
end

to soldiers-setup
  ask soldiers [set shape "person"]
end

to ladder-setup
  set size 2
end



to W
  ask players [set heading 0
    wait 0.01
    fd 1]
end

to A
  ask players [set heading 270
    wait 0.01
    fd .5]
end

to S
  ask players [set heading 180
    wait 0.01
    fd 1]
end

to D
  ask players [set heading 90
    wait 0.01
    fd 1]
end


to Easy-Difficulty
  if breed = players [set HP 100]
  if breed = bosses [set HP 500]
  if breed = spiders [set HP random 100]
  if breed = soldiers [set HP random 100]
end

to Medium-Difficulty
end


;HP Labels
to hp-labeling
  ifelse showHP? 
  [set label HP]
  [set label ""]
end

;Fighting
to attack
  if breed = spiders or breed = soldiers [if any? bullets-here [set HP HP - 1]]
end


;NEXT MAP TRANSITIONS
to Next-Map
  if count spiders = 0 [ask patches [if pcolor = 1.3 [set pcolor white]]]
  if count soldiers = 0 [ask patches [if pcolor = 1.3 [set pcolor white]]]
  ifelse count bosses = 0 
  []
  [ if [HP] of boss 0 = 0 [user-message "Level 2" 
    create-ladders 1]]
  if [pcolor] of player 0 = white [random-map
    ask players [setxy 0 0]]
end

to random-map
  let x random 5
  if x = 0
  [import-pcolors "Final_edit.png"]
  if x = 1
  [import-pcolors "Boss_right_room.png"]
  if x = 2
  [import-pcolors "Boss_left_room.png"]
  if x = 3 
  [import-pcolors "Secret_room_right.png"]
end

;PROJECTILE CONTROL CREDS TO MR. BROOKS


to button-rotate [which-way]
  ask guns [
    ifelse which-way = "left"
    [  set heading heading - 10 ]
    [  set heading heading + 10 ]
  ]
  tick
end

to Fire
  create-bullets 1 [
    set xcor [xcor] of player 0
    set ycor [ycor] of player 0
    set shape "Tears"
    set heading [heading] of player 0
    set color red
    set size 1.3
  ]
  reset-ticks
  tick
end

To Go
  ask powerups [set label ""]
  ask hearts [set label ""]
  ask players [hp-labeling]
  ask bosses [hp-labeling]
  ask spiders [hp-labeling]
  ask soldiers [hp-labeling]
  ask players [if HP = 0 [die]]
  if HP of players = 0 [user-message "Game Over"]
  Next-Map
  if count bullets > 0 [
    ask bullets [ 
      fd 0.3
      if xcor > 22 or xcor < -22 or ycor > 16 or ycor < -16 [die]
      set size 3
    ]
    wait .01
  ]
  reset-ticks
  tick  
end

;HEALTH, DAMAGE, AND DAMAGE SPEED REPORTERS



to-report health
  report [HP] of players
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
857
470
24
16
13.0
1
15
1
1
1
0
1
1
1
-24
24
-16
16
0
0
1
ticks
30.0

SLIDER
11
256
183
289
num_fighters
num_fighters
0
100
0
1
1
NIL
HORIZONTAL

SLIDER
17
190
189
223
num_soldiers
num_soldiers
0
100
0
1
1
NIL
HORIZONTAL

BUTTON
131
17
195
50
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
74
65
137
98
W
W
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

BUTTON
7
103
70
136
A
A
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

BUTTON
73
102
136
135
S
S
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
138
102
201
135
D
D
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

BUTTON
21
150
84
183
Fire
Fire
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
118
151
181
184
Go
Go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
16
297
165
342
Choose_a_Character
Choose_a_Character
"Isaac" "Cain" "Judas" "Magdalene"
0

SWITCH
13
18
118
51
showHP?
showHP?
0
1
-1000

MONITOR
26
349
83
394
Health
Health
17
1
11

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## CREDITS AND REFERENCES

David Liang and Jackie Liu
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

boss 1
false
0
Rectangle -2674135 true false 135 75 150 90
Rectangle -2674135 true false 120 90 135 105
Rectangle -2674135 true false 135 90 150 105
Rectangle -2674135 true false 150 90 165 105
Rectangle -2674135 true false 90 105 165 120

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

cain
false
9
Rectangle -16777216 true false 90 165 210 180
Rectangle -16777216 true false 90 180 105 285
Rectangle -16777216 true false 195 180 210 285
Rectangle -16777216 true false 105 270 120 285
Rectangle -16777216 true false 120 255 180 270
Rectangle -16777216 true false 180 270 195 285
Rectangle -16777216 true false 60 180 90 195
Rectangle -16777216 true false 60 165 75 180
Rectangle -16777216 true false 210 180 240 195
Rectangle -16777216 true false 225 165 240 180
Rectangle -16777216 true false 75 150 90 165
Rectangle -16777216 true false 60 135 75 150
Rectangle -16777216 true false 45 60 60 135
Rectangle -16777216 true false 225 135 240 150
Rectangle -16777216 true false 240 60 255 135
Rectangle -16777216 true false 60 45 75 60
Rectangle -16777216 true false 75 30 90 45
Rectangle -16777216 true false 210 30 225 45
Rectangle -16777216 true false 210 150 225 165
Rectangle -16777216 true false 225 45 240 60
Rectangle -16777216 true false 90 15 210 30
Rectangle -16777216 true false 195 75 225 105
Rectangle -16777216 true false 75 75 105 105
Rectangle -16777216 true false 105 105 195 150
Rectangle -2064490 true false 75 165 90 180
Rectangle -2064490 true false 105 180 195 255
Rectangle -2064490 true false 105 255 120 270
Rectangle -2064490 true false 180 255 195 270
Rectangle -2064490 true false 60 60 75 135
Rectangle -2064490 true false 225 60 240 135
Rectangle -2064490 true false 90 150 210 165
Rectangle -2064490 true false 90 30 90 45
Rectangle -1 true false 75 75 90 90
Rectangle -11221820 true false 75 105 90 150
Rectangle -11221820 true false 210 105 225 150
Rectangle -11221820 true false 90 105 105 120
Rectangle -11221820 true false 195 105 210 120
Rectangle -2064490 true false 90 120 105 150
Rectangle -2064490 true false 195 120 210 150
Rectangle -2064490 true false 210 45 225 75
Rectangle -2064490 true false 195 30 210 75
Rectangle -2064490 true false 195 45 195 60
Rectangle -2064490 true false 195 45 195 60
Rectangle -2064490 true false 165 45 195 60
Rectangle -16777216 true false 150 45 165 60
Rectangle -2064490 true false 120 30 135 45
Rectangle -2064490 true false 135 30 195 45
Rectangle -16777216 true false 120 30 135 45
Rectangle -16777216 true false 165 60 180 75
Rectangle -16777216 true false 195 75 195 90
Rectangle -16777216 true false 180 60 195 75
Rectangle -2064490 true false 180 75 195 90
Rectangle -16777216 true false 135 45 150 60
Rectangle -2064490 true false 135 60 165 75
Rectangle -2064490 true false 90 45 105 75
Rectangle -2064490 true false 105 75 195 105
Rectangle -2064490 true false 90 45 135 75
Rectangle -2064490 true false 90 30 120 45
Rectangle -2064490 true false 75 45 90 75

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

isaac
false
0
Rectangle -7500403 true true 90 75 90 135
Rectangle -16777216 true false 45 60 60 135
Rectangle -16777216 true false 240 60 255 135
Rectangle -16777216 true false 60 135 75 150
Rectangle -16777216 true false 225 135 240 150
Rectangle -16777216 true false 60 45 75 60
Rectangle -16777216 true false 75 30 90 45
Rectangle -16777216 true false 90 15 210 30
Rectangle -16777216 true false 210 30 225 45
Rectangle -16777216 true false 225 45 240 60
Rectangle -16777216 true false 75 150 90 165
Rectangle -16777216 true false 210 150 225 165
Rectangle -16777216 true false 90 165 210 180
Rectangle -16777216 true false 90 180 105 285
Rectangle -16777216 true false 195 180 210 285
Rectangle -16777216 true false 60 180 90 195
Rectangle -16777216 true false 210 180 240 195
Rectangle -16777216 true false 60 165 75 180
Rectangle -16777216 true false 225 165 240 180
Rectangle -16777216 true false 120 255 180 270
Rectangle -16777216 true false 105 270 120 285
Rectangle -16777216 true false 180 270 195 285
Rectangle -16777216 true false 195 75 225 105
Rectangle -16777216 true false 105 105 195 150
Rectangle -11221820 true false 75 105 90 150
Rectangle -11221820 true false 90 105 105 120
Rectangle -11221820 true false 210 105 225 150
Rectangle -16777216 true false 75 75 105 105
Rectangle -1 true false 75 75 90 90
Rectangle -1 true false 195 75 210 90
Rectangle -2064490 true false 75 165 90 180
Rectangle -2064490 true false 105 180 195 240
Rectangle -2064490 true false 105 240 120 270
Rectangle -2064490 true false 180 240 195 270
Rectangle -2064490 true false 75 120 90 120
Rectangle -2064490 true false 210 165 225 180
Rectangle -2064490 true false 90 150 210 165
Rectangle -2064490 true false 90 120 105 150
Rectangle -2064490 true false 195 105 210 150
Rectangle -2064490 true false 120 240 180 255
Rectangle -2064490 true false 60 75 75 135
Rectangle -2064490 true false 60 60 240 75
Rectangle -2064490 true false 105 75 195 105
Rectangle -2064490 true false 225 75 240 135
Rectangle -2064490 true false 75 45 225 60
Rectangle -2064490 true false 90 30 210 45
Rectangle -11221820 true false 195 105 210 120

judas
false
0
Rectangle -7500403 true true 90 75 90 135
Rectangle -16777216 true false 45 75 60 150
Rectangle -16777216 true false 240 75 255 150
Rectangle -16777216 true false 60 150 75 165
Rectangle -16777216 true false 225 150 240 165
Rectangle -16777216 true false 60 60 75 75
Rectangle -16777216 true false 75 45 90 60
Rectangle -16777216 true false 90 30 210 45
Rectangle -16777216 true false 210 45 225 60
Rectangle -16777216 true false 225 60 240 75
Rectangle -16777216 true false 75 165 90 180
Rectangle -16777216 true false 210 165 225 180
Rectangle -16777216 true false 90 180 210 195
Rectangle -16777216 true false 90 195 105 300
Rectangle -16777216 true false 195 195 210 300
Rectangle -16777216 true false 60 195 90 210
Rectangle -16777216 true false 210 195 240 210
Rectangle -16777216 true false 60 180 75 195
Rectangle -16777216 true false 225 180 240 195
Rectangle -16777216 true false 120 270 180 285
Rectangle -16777216 true false 105 285 120 300
Rectangle -16777216 true false 180 285 195 300
Rectangle -16777216 true false 195 90 225 120
Rectangle -16777216 true false 105 120 195 165
Rectangle -11221820 true false 75 120 90 165
Rectangle -11221820 true false 90 120 105 135
Rectangle -11221820 true false 210 120 225 165
Rectangle -16777216 true false 75 90 105 120
Rectangle -1 true false 75 90 90 105
Rectangle -1 true false 195 105 210 105
Rectangle -2064490 true false 75 180 90 195
Rectangle -2064490 true false 105 195 195 255
Rectangle -2064490 true false 105 255 120 285
Rectangle -2064490 true false 180 255 195 285
Rectangle -2064490 true false 75 120 90 120
Rectangle -2064490 true false 210 180 225 195
Rectangle -2064490 true false 90 165 210 180
Rectangle -2064490 true false 90 135 105 165
Rectangle -2064490 true false 195 135 210 180
Rectangle -2064490 true false 120 255 180 270
Rectangle -2064490 true false 60 90 75 150
Rectangle -2064490 true false 60 75 240 90
Rectangle -2064490 true false 105 90 195 120
Rectangle -2064490 true false 225 90 240 150
Rectangle -2064490 true false 75 60 225 75
Rectangle -2064490 true false 90 45 210 60
Rectangle -11221820 true false 195 120 210 135
Rectangle -2674135 true false 165 45 195 60
Rectangle -2674135 true false 165 30 195 45
Rectangle -1 true false 195 90 210 105
Rectangle -2674135 true false 210 15 210 45
Rectangle -2674135 true false 150 30 165 45
Rectangle -16777216 true false 240 30 255 45
Rectangle -16777216 true false 225 15 240 30
Rectangle -1184463 true false 255 45 270 60
Rectangle -2674135 true false 195 60 195 75
Rectangle -2674135 true false 180 60 195 75
Rectangle -2674135 true false 165 15 195 30
Rectangle -2674135 true false 195 15 210 30
Rectangle -2674135 true false 150 15 180 15
Rectangle -2674135 true false 165 0 210 15
Rectangle -2674135 true false 165 15 165 30
Rectangle -2674135 true false 150 15 165 30
Rectangle -2674135 true false 135 30 150 45
Rectangle -2674135 true false 150 45 165 60
Rectangle -2674135 true false 195 30 210 45
Rectangle -2674135 true false 195 45 210 60
Rectangle -2674135 true false 210 30 225 45
Rectangle -2674135 true false 210 15 225 30
Rectangle -2674135 true false 210 0 225 15

ladder
false
0
Circle -16777216 false false 30 45 240
Rectangle -6459832 true false 90 60 105 255
Rectangle -6459832 true false 195 60 210 255
Rectangle -6459832 true false 105 210 195 225
Rectangle -6459832 true false 105 165 195 180
Rectangle -7500403 true true 105 150 195 150
Rectangle -6459832 true false 105 120 195 135
Rectangle -6459832 true false 105 75 195 90

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

magdalene
false
0
Rectangle -7500403 true true 90 75 90 135
Rectangle -16777216 true false 45 60 60 135
Rectangle -16777216 true false 240 60 255 135
Rectangle -16777216 true false 60 135 75 150
Rectangle -16777216 true false 225 135 240 150
Rectangle -16777216 true false 60 45 75 60
Rectangle -16777216 true false 75 30 90 45
Rectangle -16777216 true false 90 15 210 30
Rectangle -16777216 true false 210 30 225 45
Rectangle -16777216 true false 225 45 240 60
Rectangle -16777216 true false 75 150 90 165
Rectangle -16777216 true false 210 150 225 165
Rectangle -16777216 true false 90 165 210 180
Rectangle -16777216 true false 90 180 105 285
Rectangle -16777216 true false 195 180 210 285
Rectangle -16777216 true false 60 180 90 195
Rectangle -16777216 true false 210 180 240 195
Rectangle -16777216 true false 60 165 75 180
Rectangle -16777216 true false 225 165 240 180
Rectangle -16777216 true false 120 255 180 270
Rectangle -16777216 true false 105 270 120 285
Rectangle -16777216 true false 180 270 195 285
Rectangle -16777216 true false 195 75 225 105
Rectangle -16777216 true false 105 105 195 150
Rectangle -11221820 true false 75 105 90 150
Rectangle -11221820 true false 90 105 105 120
Rectangle -11221820 true false 210 105 225 150
Rectangle -16777216 true false 75 75 105 105
Rectangle -1 true false 75 75 90 90
Rectangle -1 true false 195 75 210 90
Rectangle -2064490 true false 75 165 90 180
Rectangle -2064490 true false 105 180 195 240
Rectangle -2064490 true false 105 240 120 270
Rectangle -2064490 true false 180 240 195 270
Rectangle -2064490 true false 75 120 90 120
Rectangle -2064490 true false 210 165 225 180
Rectangle -2064490 true false 90 150 210 165
Rectangle -2064490 true false 90 120 105 150
Rectangle -2064490 true false 195 105 210 150
Rectangle -2064490 true false 120 240 180 255
Rectangle -2064490 true false 60 75 75 135
Rectangle -2064490 true false 60 60 240 75
Rectangle -2064490 true false 105 75 195 105
Rectangle -2064490 true false 225 75 240 135
Rectangle -2064490 true false 75 45 225 60
Rectangle -2064490 true false 90 30 210 45
Rectangle -11221820 true false 195 105 210 120
Rectangle -1184463 true false 15 60 45 135
Rectangle -1184463 true false 30 30 60 60
Rectangle -1184463 true false 60 15 75 60
Rectangle -1184463 true false 75 0 90 45
Rectangle -1184463 true false 90 0 210 30
Rectangle -1184463 true false 45 60 60 90
Rectangle -1184463 true false 210 0 225 45
Rectangle -1184463 true false 240 30 270 60
Rectangle -1184463 true false 255 135 285 135
Rectangle -1184463 true false 255 135 285 135
Rectangle -1184463 true false 240 60 255 90
Rectangle -1184463 true false 255 60 285 135
Rectangle -1184463 true false 225 15 240 60
Rectangle -1184463 true false 45 135 60 165
Rectangle -1184463 true false 240 135 255 165
Rectangle -1184463 true false 30 135 45 150
Rectangle -1184463 true false 255 135 270 150
Rectangle -1184463 true false 60 150 75 165
Rectangle -1184463 true false 225 150 240 165
Rectangle -1184463 true false 45 165 60 180
Rectangle -2674135 true false 225 30 255 60
Rectangle -2674135 true false 240 15 270 45
Rectangle -2674135 true false 255 0 285 30

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

spiders
false
0
Circle -2674135 true false 118 118 62
Line -16777216 false 105 135 120 150
Line -16777216 false 105 135 75 195
Line -16777216 false 120 165 105 165
Line -16777216 false 105 165 90 195
Line -16777216 false 180 165 195 165
Line -16777216 false 195 165 210 195
Line -16777216 false 180 150 195 135
Line -16777216 false 195 135 225 180
Line -16777216 false 140 189 140 180
Line -16777216 false 156 180 154 188
Circle -955883 true false 131 137 14

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tears
false
0
Circle -13791810 true false 45 45 210
Circle -11221820 false false 84 99 42
Circle -1 true false 72 88 66

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.0.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
