//  s_1, s_2, ..., s_n files contain the story flow.

=== intro ===

    After what feels like a century, you open your eyes. It takes a while for them to get used to the darkness. That was one hell of a fall.
    
    You look around you. <>
    ->DONE


=== visitTreasury ===

    ~ currentRoom = treasury
    ~ currentRoomAddress = ->visitTreasury
    
    {!This must be the cave's treasury, since it's filled with treasures beyond your wildest dreams. And from all these riches, the old fool wanted a plain oil lamp.|}
    
    {An|The main} opening leads to another room in the cave.{ inventory has lamp: {Before all those shiny riches, you|You} feel a strange urge to rub {this dusty|the} lamp clean.}

//  The above sentence makes sure it offers variations
//  everytime we revisit it.

//  All but one of the following options
//  are dependent on variable values:

        +   [Examine the treasure.] ->examineTreasure

//  The only thing you can do in any case
//  is examine the treasure.

    = examineTreasure

    You marvel at the {amounts of gold|mountains of jewels|rivers of silk|endless riches. Who owns all this, you wonder}.
    
    {
        -   inventory has lamp:<> The lamp twitches inside your pocket, as if it shares the sentiment.
        //  Do I need to check for has lamp in following too?
        -   lampEvents == seenLamp:<> How can that dirty bronze lamp be of more value than any item in this room?
        -   lampEvents == lampNotFound:<> And in this mythical place, are you supposed to look for a stupid old lamp?
    }
    
    { examineTreasure == 1:Hey, what's this? Behind a small hill of gold coins, you find something that looks like a secret door.|There is a secret door behind a pile of gold coins. <>}
    
    ->beIn(->visitTreasury)


=== visitHall ===

    ~ currentRoom = hall
    ~ currentRoomAddress = ->visitHall

    You enter {a|the} small hall. Its openings lead to {(not visitJunkRoom) and (not visitFountain):two other rooms in the cave|{visitJunkRoom:the junk room|one other room}, {visitFountain:the fountain|one other room where you can hear the sound of water}}, as well as back to the treasury.{! From one of the rooms, you can hear the gentle sound of water.|}
    ->DONE

=== visitJunkRoom ===

    ~ currentRoom = junk
    ~ currentRoomAddress = ->visitJunkRoom
    
    {!This room is full of junk. |}Piles of rags. Broken crates. Mouldy cheese.
    
    +   {inventory hasnt coin}[Search the junk.]You have all the time in the world, so why not invest some in searching through the junk?
    
        After what seemed like days, you find a worthless coin made of tin. For some reason, you decide to take it. (It IS useless, though, be warned.)
        
        ~ inventory += coin
        ->beIn(currentRoomAddress)

-   -> DONE

=== visitFountain ===

    ~ currentRoom = fountain
    ~ currentRoomAddress = ->visitFountain

    A small fountain is here.->choices
    
    = choices
        
    *   [Drink some water.]You gulp down huge quantities of water. Refreshing.
    
        ->beIn(currentRoomAddress)


=== visitVault ===

    ~ currentRoom = vault
    ~ currentRoomAddress = ->visitVault
    
    ~ raiseState(lampEvents, seenLamp)

    { visitVault == 1:It's not actually a room, but a tiny vault|{ inventory has lamp:The vault looks much emptier without {it|the lamp}|Wow, this vault is tiny}}. In a corner rests a pile of ancient scrolls. Boring.
    { inventory hasnt lamp:You also see a dusty oil lamp, here. }
    
    //  The "Wow, this vault is tiny." will probably never fire, but this is defensive logic--better safe than sorry.

    -   (whatDo)
        +   [Read the scrolls.]I said: bo-ring! ->beIn(->whatDo)
        *   { inventory hasnt lamp }[Take the lamp.] It's old and dusty. ->takeLamp


    = takeLamp

    You pick up the lamp, but scream, startled, dropping it again.

    It moved! The thing moved!

		*   (examined)[Examine the lamp.]You take a closer look at the lamp, as it lays on the vault's sandy floor.
		*   [Stay completely still.]You hold your breath and stay still.
		    
		    **  [Approach the thing.]->examined
		
	-   Nothing. The thing looks as inanimate as a lamp is supposed to be. Still, just seconds ago, you felt it twitch between your fingers!

        *   {examined}[Look inside it.]You approach your face to the lamp,
		*   [Poke it with something.]You look around the treasury for something long enough to use as a poker and close enough to reach without taking your eyes off the lamp. You grab...
		        
            **  ... a silver sceptre[.]
                ~ pokerItem = "the sceptre"
            **  ... a golden statue of a cat[.]
                ~ pokerItem = "the cat statue"
            **  ... a platinum ceremonial mace[.]
                ~ pokerItem = "the platinum mace"
            
        --  <> and cautiously poke the lamp with it. You only remember squeezing {pokerItem} tight
        
        *   "He-hello?"[] you whisper...

	-   <> before letting out a wail of horror.
	
	    The lamp has just twitched again!
	
		*   [Hit the thing!]You approach the lamp with cruel intentions.
			**	[Kick it.]
			**  [Head-butt it.]
			**	[Stamp on it.]
			**	[Throw it against a wall.]
			**  [Whack it with {pokerItem}.]
		--	You unleash your anger on the inanimate thing, not helping feeling a little silly in the process. The lamp doesn't fight back, but you think you hear distant laughter; as if from another dimension.
            **  [Oh, just take the thing.]->justTakeIt
        *   (justTakeIt)[Oh, just take it already.]Okay, enough monkeying around. Inanimate or not, you decide not to let your fear rule your actions. You take the lamp and put it in your pockets.
            ~ inventory += lamp
            ->beIn(->visitVault)


=== ending ===

/*
Let's close this demo tutorial here.
You can certainly expand it, by adding knots for the
3-wish granting, more rooms, or anything else you want.
*/

    ~ raiseState(lampEvents, metDjinn)

    You give the lamp a good rub with your sleeve and it starts twitching again. But you are used to it, by now, so you tightly hold onto it.
    
TODO:    Implement jolly/grumpy djinnMood
    
    A puff of smokes comes out its mouth and—ALAKAZAM!—a Djinn appears. "There's the rub!" it says. "After three thousand years, I started losing hope." Then, after taking a better look at you: "So, did you review my job application?"
    
        *   "The job what?"
        *   "The what application?"
        *   "What job application?"

    -   <> you whisper, horrified.
    
        The Djinn rolls its eyes with a sigh. "How can I help?" it asks.
    
        *   (endIt)"Get me out of here!"[]{not sucks: you scream in anguish.}
        *   (sucks)"This game sucks[."]," you scream in anguish. -> endIt
    
    -   "Your wish is my command," says the Djinn.
    
    -> END
