
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
  
    {
        -   stateMachine < newState:
                // <><br>Current state is lower and will be raised.
                ~ stateMachine = newState
    }
    
    // <><br>Current state is now: {stateMachine}.


=== moveTo(->targetRoom) ===

    ~ previousRoom = currentRoom
    ~ previousRoomAddress = currentRoomAddress
    // <i>(Previous Room was: {previousRoom})</i>
    ->stayAt(targetRoom)


=== stayAt(->targetRoom) ===

    <-targetRoom
    // <i>(Current Room is: {currentRoom})</i>
    <-GeographyOptions
    <-lampOptions
    -> DONE


=== lampOptions ===

        + { lampEvents >= gotLamp and currentRoom != vault }[Rub the lamp.]->moveTo(->ending)


=== GeographyOptions ===

        +   { currentRoom == treasury && visitTreasury.examineTreasure && not visitVault}[{Enter the vault|Try the secret door}.]You open the secret door and squeeze in. ->moveTo(->visitVault)
        +   { currentRoom == hall and previousRoom != fountain}[Enter the { visitFountain:fountain room|room with the sound of water}.]->moveTo(->visitFountain)
        +   { currentRoom == hall and previousRoom != junk}[Enter the { visitJunkRoom:junk room|silent room}.]->moveTo(->visitJunkRoom)
        +   { currentRoom == hall and previousRoom != treasury }[Enter the treasury.]->moveTo(->visitTreasury)
        +   { currentRoom != previousRoom}[Return to the {previousRoom}{previousRoom == junk or previousRoom == fountain: room}.]->returnToPreviousRoom
        +   { currentRoom == treasury && not visitHall }[Exit the treasury.]You pat the dust off your clothes and clumsily find your way out of the treasury.
            ->moveTo(->visitHall)


=== returnToPreviousRoom ===

    You return to the {previousRoom}{previousRoom == junk or previousRoom == fountain: room}.
    <> ->moveTo(previousRoomAddress)
