
=== function raiseState(ref stateMachine, newState) ===

    //  This function checks the stateMachine's current state.
    //  If it is lower that the newState,
    //  it assigns the newState to the stateMachine.
    //  Else, it does nothing.
    
    //  Note that the stateMachine argument is passed by reference,
    //  so the function can actually alter it
    //  (instead of using a copy of it).

    //  Uncomment the following lines for debugging:

    //  Current state: {stateMachine}.<br>Checked against new state: {newState}.
  
    {stateMachine < newState:
                // <><br>Current state is lower and will be raised.
                ~ stateMachine = newState
    }
    
    // <><br>Current state is now: {stateMachine}.


=== updatePreviousRoomWhileGoingTo(->targetRoom) ===

//  Since functions can't contain diverts,
//  this isn't a function, but a divert with arguments.
//  No biggie.
//  As you see, it ends with a divert to ->beIn.

    //  Before changing rooms, we first assign the current
    //  room to the variable previousRoom:
    ~ previousRoom = currentRoom
    //  ... and the same with its knot address:
    ~ previousRoomAddress = currentRoomAddress
    //  Remember: we declared the variable previousRoomAddress
    //  as one that holds the value of a divert (the -> thingy).
    
    //  Finally, 
    ->beIn(targetRoom)


=== beIn(->targetRoom) ===

//  This knot is called in every room and creates
//  a thread by combining:
//  1. the room's knot (passed as argument)
//  2. the GeographyOptions knot and
//  3. the lampOptions knot.

    <-targetRoom
    // <i>(Current Room is: {currentRoom})</i>
    <-GeographyOptions
    <-lampOptions
    //  To avoid an Inky warning, we add a ->DONE
    //  divert, to show that we haven't just forgotten
    //  an eventual divert.
    -> DONE
    //  In fact, all the diverts we need will be
    //  provided by the previous threads.


=== lampOptions ===

//  This knot is used in the beIn knot,
//  called every time we enter a room.
//  It basically says: if we carry the lamp,
//  we get the option to rub it.
//  (No text--just one option with a conditional.)
        + { inventory has lamp and lampEvents < metDjinn and currentRoom != vault }[Rub the lamp.]->updatePreviousRoomWhileGoingTo(->ending)


=== GeographyOptions ===

//  Instead of assigning diverts in each room,
//  I thought I would be clever and create one knot
//  to be called in every room as a thread.
//  It doesn't have any text--only options.
//  Its options appear according to conditions,
//  offering ways to adjacent locations.

//  To make the text look smart, there are
//  slight variations. For example, in the treasury,
//  you get the option to "Exit the treasury," if you
//  haven't already done so. If you have, then you know
//  there is a hall there, so you get the option "Return
//  to the hall," instead.
//  Similarly, you don't get the name of a room in the options
//  unless you've visited it at least once.

//  So, here are the options, one by one:

        //  If you are in the treasury and you have
        //  examined the treasure (thus finding the secret
        //  door), but you haven't visited the Vault yet:
        //  you get:
        +   { currentRoom == treasury && visitTreasury.examineTreasure && not visitVault}[Try the secret door.]You open the secret door and squeeze in. ->updatePreviousRoomWhileGoingTo(->visitVault)
        
        //  If you are in the hall and the previous room
        //  is not the fountain:
        +   { currentRoom == hall and previousRoom != fountain}[Enter the { visitFountain:fountain room|room with the sound of water}.]->updatePreviousRoomWhileGoingTo(->visitFountain)
        +   { currentRoom == hall and previousRoom != junk}[Enter the { visitJunkRoom:junk room|silent room}.]->updatePreviousRoomWhileGoingTo(->visitJunkRoom)
        +   { currentRoom == hall and previousRoom != treasury }[Enter the treasury.]->updatePreviousRoomWhileGoingTo(->visitTreasury)
        +   { currentRoom != previousRoom}[Return to the {previousRoom}{previousRoom == junk or previousRoom == fountain: room}.]->returnToPreviousRoom
        +   { currentRoom == treasury && not visitHall }[Exit the treasury.]You pat the dust off your clothes and clumsily find your way out of the treasury.
            ->updatePreviousRoomWhileGoingTo(->visitHall)


=== returnToPreviousRoom ===

    You return to the {previousRoom}{previousRoom == junk or previousRoom == fountain: room}.
    <> ->updatePreviousRoomWhileGoingTo(previousRoomAddress)
