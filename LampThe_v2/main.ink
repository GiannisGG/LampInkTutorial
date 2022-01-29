//  The Lamp - Version 2B (Advanced w/Previous Rooms)

//  Tunnels


INCLUDE m_functions.ink
INCLUDE s_1.ink


//  Our variables
VAR pokerItem = "the palm of your hand"

LIST lampEvents = (lampNotFound), seenLamp, gotLamp, metDjinn, firstWish, secondWish, thirdWish

LIST djinnMood = jolly, grumpy

LIST rooms = treasury, junk, fountain, hall, vault

VAR currentRoom = treasury
VAR previousRoom = treasury

// Variables can take the value of a divert:
VAR currentRoomAddress = ->visitTreasury
VAR previousRoomAddress = ->visitTreasury




<-intro
<-GeographyOptions