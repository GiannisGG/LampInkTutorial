//  The Lamp - Version 1

//  This is the beginner's version and
//  it does NOT include the following features:

//  including multiple files
//  Tunnels
//  Functions
//  Threads
//  LISTs

//  ---------------LET'S GO!--------------------------

//  We first declare & initialise our global variables:
VAR hasLamp = false
VAR secretRoomDiscovered = false
VAR pokerItem = "the palm of your hand"

//  Kicking off the flow by diverting to the first knot:
->intro

=== intro ===

    After what feels like a century, you open your eyes. It takes a while for them to get used to the darkness. That was one hell of a fall.
    
    You look around you. <>
    ->Treasury

//  "->Treasury" takes us--by default--
//  to the first stitch of the knot "Treasury."
//  It's the same as writing "->Treasury.firstReaction"

//  The "<>" symbol is the "glue."
//  It forces two sentences to stay in the same line
//  and generally respects the single space character.
//  If Ink sticks two sentences together, without space,
//  you may need to use some glue to fix it.
    
=== Treasury ===

    = firstReaction
    
    //  firstReaction is the first stitch of the knot Treasury.

    This must be the cave's treasury. You see treasures beyond your wildest dreams. -> routineReaction
    
    //  Every time we end up here, we get a slightly different description, just to spice things up a little.

    = routineReaction
    { not goDeeper:{An|The main} opening leads to another room in the cave.|{|The exit is { | |still | |always }blocked by the collapsed roof.}}{ hasLamp: {Before all those shiny riches, you|You} feel a strange urge to rub {this dusty|the} lamp clean.}
    
    //  Check all the { and } in the above paragraph.
    //  Some have conditionals, eg " { not goDeeper:...}
    //  Others have text that varies each time we visit the stitch.
    //  Notice how they nest, one inside the other.


//  All but one of the following options
//  are dependent on variable values:

        +   {hasLamp}[Rub the lamp.] ->ending // Option to rub the lamp if you have it.
        +   [Examine the treasure.] ->examineTreasure
        *   {not goDeeper}[Go deeper into the cave.] ->goDeeper // If you haven't already done so, you can try going deeper into the cave.
        +	{secretRoomDiscovered} [{secretRoom:Enter the vault|Try the secret door}.]You open the secret door and squeeze in. ->secretRoom

//  The only thing you can do in any case
//  is examine the treasure.

//  Note that "goDeeper" is not declared as global variable. Ink stores values for each time we visit a knot or stitch. If we haven't visited the "goDeeper" knot, the value of "goDeeper" is false (more accurately: 0). If we have visited it, the value is true (more accurately: the number of visits).

=== examineTreasure ===

    You marvel at the {amounts of gold|mountains of jewels|rivers of silk|endless riches. Who owns all this, you wonder}.{hasLamp: The lamp twitches inside your pocket, as if it shares the sentiment.}

//  Here's an example of multi-line conditional block:

	{
		-	not secretRoomDiscovered:
				What's this? Behind a small hill of gold coins, you find something that looks like a secret door.
				~ secretRoomDiscovered = true
		-	else:
				There is a secret door behind a pile of gold coins.
	}<> -> Treasury.routineReaction

//  You may have realised that "secretRoomDiscovered"
//  is a redundant variable. Why?
//  Since we assign it to "true" when we visit "examineTreasure,"
//  we can simply do the check using the value of examineTreasure instead:
//  { examineTreasure == 1:What's this... |There is a... }
//  instead.
//  This would spare the need for a multi-line block, as well.


=== goDeeper ===

    As you take the first step towards the opening, a part of the roof collapses before you, blocking the exit.
		->Treasury.routineReaction
		
		//  To divert to a stitch of another knot,
		//  we must use a knotName.stitchName syntax.

=== secretRoom ===

    { secretRoom == 1:It's not actually a room, but a tiny vault|{ hasLamp:The vault looks much emptier without {it|the lamp}|Wow, this vault is tiny}}. In a corner rests a pile of ancient scrolls. Boring.
    { not hasLamp:You also see a dusty oil lamp, here. }

    -   (whatDo)
        +   [Read the scrolls.]I said: bo-ring! ->whatDo
        *   {not hasLamp}[Take the lamp.] It's old and dusty. ->takeLamp
        +   [Exit the vault.]You exit the vault and return to the Treasury. ->Treasury.routineReaction


=== takeLamp ===

    //  This is a silly fight sequence between the PC around
    //  the lamp.
    //  It uses "weaving," which is the writing style including
    //  choices and gathers.
    //  Read the code and check the preview.
    //  Practice following the flow.

    You pick up the lamp, but scream, startled, dropping it again.

    It moved! The thing moved!

		*   (examined)[Examine the lamp.]You take a closer look at the lamp, as it lays on the vault's sandy floor.
		*   [Stay completely still.]You hold your breath and stay still.
		    
		    **  [Approach the thing.]->examined
		    //  Diverts to the (examined) choice, above.
		
		//  After all of the above is done, we proceed to the next gather:
	-   Nothing. The thing looks as inanimate as a lamp is supposed to be. Still, just seconds ago, you felt it twitch between your fingers!

            //  The {examined} condition below is redundant, since there is no way we reach this point without having examined the lamp before the previous gather. Still, it's good practice to rely on such "defensive logic," since not always can we deduct conclusions as to what the player must have done. Better safe than sorry.
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
			
			//  All the above actions lead to the same result/gather:
			
		--	You unleash your anger on the inanimate thing, not helping feeling a little silly in the process. The lamp doesn't fight back, but you think you hear distant laughter; as if from another dimension.
            **  [Oh, just take the thing.]->justTakeIt
        *   (justTakeIt)[Oh, just take it already.]Okay, enough monkeying around. Inanimate or not, you decide not to let your fear rule your actions. You take the lamp and put it in your pockets.
            ~ hasLamp = true
            ->secretRoom

    //  Phew! That was it! Did you manage to follow the flow?

=== ending ===

    You rub the lamp with your sleeve. A Djinn appears. "Finally!" it says. "After three thousand years, I started losing hope." It takes a better look at you. "So, did you review my job application?"
    
        *   "The job what?"
        *   "The what application?"
        *   "What job application?"

    -   <> you whisper, horrified.
    
        The Djinn rolls its eyes with a sigh. "How can I help?" it asks.
    
        *   (endIt)"Get me out of here!"[]{not sucks: you scream in anguish.}
        *   (sucks)"This game sucks[."]," you scream in anguish. -> endIt
    
    -   "Your wish is my command," says the Djinn and magically quits the game.
    
    -> END

    //  Tadah!