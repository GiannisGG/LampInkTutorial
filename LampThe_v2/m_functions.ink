
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


=== exitTo(->targetRoom) ===

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
//  3. the inventoryOptions knot.

    <-targetRoom
    // <i>(Current Room is: {currentRoom})</i>
    <-GeographyOptions
    <-inventoryOptions
    //  To avoid an Inky warning, we add a ->DONE
    //  divert, to show that we haven't just forgotten
    //  an eventual divert.
    -> DONE
    //  In fact, all the diverts we need will be
    //  provided by the previous threads.


=== inventoryOptions ===

//  This knot is used in the beIn knot,
//  called every time we enter a room.

        +   [Take inventory.]->takeInventory->beIn(currentRoomAddress)

/*
TUNNELS
The "->takeInventory-> syntax is for calling a tunnel.
Tunnels are knots that run and then return us
to where we were before the diversion.
They have the stack logic, like functions: if we don't
divert the flow again, they will return us
to the point we called them.

So, here, we call takeInventory, it runs, returns,
and we then continue with ->beIn(currentRoomAddress).
*/



=== takeInventory ===
/*
This is a very basic inventory implementation.
We can get to see what we are carrying and
perhaps have an extra option or two, to interact
with those items.
*/

/*
To show what we are carrying, we get the value of
the inventory LIST.
Check Ink's documentation for a good example of
"nicer list printing," which takes into consideration
whether there are 3 or more, 2, 1, or no items in the list.
*/
    = checkItems
You are carrying: {inventory}.

    *   { inventory has bread and breadState == dry and currentRoom == fountain}[Wet your bread.]You wet the bread in the fountain. It's now much softer and edible.
        ~ breadState = wet
        ->checkItems
    
    +   { inventory has bread }[Eat the bread.]
        {breadState == wet:
            You wolf down the wet, softened bread. Nourishing.
            ~ inventory -= bread
        - else:
            You {|could }attempt taking a bite off the bread, but it's too dry. You {almost broke a tooth|don't want to risk breaking your teeth}.
        }
        ->checkItems
        
    //  You can rub the lamp, but not while in the vault:
    +   { inventory has lamp and lampEvents < metDjinn }[Rub the lamp.]
        {currentRoom == vault: Not in here.|->ending}
        
    +   { inventory has coin }[{currentRoom == fountain:Toss the coin and make a wish|Admire the tin coin}.]
        
        {currentRoom == fountain:
        
            You toss the coin into the fountain, wishing for this nightmare to end and for you to be free again...
            
            No. No miracle happened. You're still here.
            
            ~ inventory -= coin
        
        - else:
        
            You take the coin out of your pocket and give it an affectionate rub. Ah... Look at that worthless little thing...
        }
        ->checkItems
        
    +   [Return to your quest.]
    
-
    //  Tunnels end with the "->->" return statement:
    ->->


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
        +   { currentRoom == treasury && visitTreasury.examineTreasure && not visitVault}[Try the secret door.]You open the secret door and squeeze in. ->exitTo(->visitVault)
        
        //  If you are in the hall and the previous room
        //  is not the fountain:
        +   { currentRoom == hall and previousRoom != fountain}[Enter the { visitFountain:fountain room|room with the sound of water}.]->exitTo(->visitFountain)
        +   { currentRoom == hall and previousRoom != junk}[Enter the { visitJunkRoom:junk room|silent room}.]->exitTo(->visitJunkRoom)
        +   { currentRoom == hall and previousRoom != treasury }[Enter the treasury.]->exitTo(->visitTreasury)
        +   { currentRoom != previousRoom}[Return to the {previousRoom}{previousRoom == junk or previousRoom == fountain: room}.]->returnToPreviousRoom
        +   { currentRoom == treasury && not visitHall }[Exit the treasury.]You pat the dust off your clothes and clumsily find your way out of the treasury.
            ->exitTo(->visitHall)


=== returnToPreviousRoom ===

    You return to the {previousRoom}{previousRoom == junk or previousRoom == fountain: room}.
    <> ->exitTo(previousRoomAddress)
