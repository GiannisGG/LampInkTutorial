//  The Lamp - Version 2

//  This is the advanced version of The Lamp story.
//  It includes (probably) all of Ink's features.

//  Tunnels


//  INCLUDE
//  We break our code down to multiple files.
//  For example, we keep a file for our functions
//  and another one (or probably more, in most cases)
//  for our story.
INCLUDE m_functions.ink
INCLUDE s_1.ink


//  OUR VARIABLES:

VAR pokerItem = "the palm of your hand"

//  LISTs are Ink's most advanced data structure.
//  We can use them in various ways. See documentation!

//  1.  We can use it to track accumulative knowledge.
//      Works like a state machine, but with a twist:
//      if a state is true, all its previous states are also true.
//      E.g. if you've met the Djinn (i.e. metDjinn is true),
//      then you've also found the lamp (seenLamp true).
LIST lampEvents = (lampNotFound), seenLamp, metDjinn, firstWish, secondWish, thirdWish

//      To be more accurate, we don't check for true or false,
//      but we assign the value to the LIST itself, as in:
//      " lampEvents = metDjinn "
//      And to make sure we don't backtrack ("forget" knowledge),
//      we do this assignment through a function that first
//      checks if the new state is higher.
//      (See function "raiseState" in file m_functions.ink)

//      Note: the parentheses around a LIST value means
//      their initial state includes and/or equals this value.

//      If this "includes and/or equals" confuses you,
//      it's perfectly normal. As said, there are multiple
//      ways to use LISTs. So, keep reading.
//      (And check the documentation.)

//  2.  We can of course use LISTs as a normal state machine:
//      E.g. the Djinn can be in a jolly or grumpy mood:
LIST djinnMood = jolly, grumpy
//      So, a LIST can be used as an enumeration.
//      E.g. to list all the rooms:
LIST rooms = treasury, junk, fountain, hall, vault
//      Then, we can define where the player is at,
//      by declaring a currentRoom variable
//      and assigning it one of the enum's values.
VAR currentRoom = treasury
//      The same with the room the player has just left:
VAR previousRoom = treasury
//      In this case, we don't assign one of the values
//      of the LIST "rooms" to the variable "rooms,"
//      but we use currentRoom and previousRoom instead.

//  3.  We can also use LIST to create an inventory.
//      Instead of assigning a value with '=' and then
//      checking for equality, we can "add" the value
//      to the LIST with "+=" or subtract with "-=" and
//      check for inclusion with "has" and "hasnt"
//      (no apostrophe).
LIST inventory = lamp, gem, coin, (bread), (knife)

//      In this case, we can start with more than
//      one values inside parentheses. These are the items
//      that the player carries from the start.

//  And that's enough with LISTs for now.

//  Variables can take the value of a divert:
VAR currentRoomAddress = ->visitTreasury
VAR previousRoomAddress = ->visitTreasury

//  What follows is a weave. Note the inverted arrows.
<-intro
<-GeographyOptions