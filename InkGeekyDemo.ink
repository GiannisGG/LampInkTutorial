<h1>Course on Ink</h1)

    With Giannis G. Georgiou



        *   [So, what is Ink?] Ink is a <b>scripting language</b> for writing interactive narrative.
    
            **  [Like... <i>games?</i>] Yes, as in games! 
            **  [Do you mean interactive fiction?] Yep, that, too.
        
        --  <> With Ink, you can create choice-based interactive fiction, but you can also use it to write the narrative parts for any kind of game.
        
        --  (gameOrIF)
            **  [{What|By the way, what} is "choice-based... em...?"]Choice based interactive fiction is a kind of story where you decide its flow, by making choices. Just like you've been doing in this demo.
            
                *** (gamebook)["Story," as in a book?]{gameOrIF == 1: Well, c|C}hoice-based interactive fiction actually comes from printed game-books like <i>Fighting Fantasy</i> or <i>Choose Your Own Adventure.</i> Those had numbered paragraphs, to which you would turn, according to the choices you made.
                
                    **** [Example, please?]For example, "If you decide to enter the tavern, turn to page 32. If you'd rather visit the docks, turn to 254."
                        {not getLamp: ->getLamp }
                *** (getLamp)[I thought IF was "EXAMINE DRAWER, GET LAMP."] Τhere are two main kinds of IF; the one where you type "EXAMINE DRAWER, GET LAMP" is the parser-based IF. The other type is the choice-based IF, where you proceed by clicking on choices.
                    {not gamebook: ->gamebook}
                --- ->gameOrIF
            **  [{Wait.|Let's go back a little: } <i>Any</i> kind of game?] {gameOrIF == 1: Indeed,|With Ink, you can write the narrative for} any kind of game! Ink exports a JSON file that you can import to a game engine, like Unity or Godot. You can then use the story flow created in Ink in any way you like, further down your workflow.->gameOrIF
            ** {gameOrIF == 3}[Please show me, then!]
    -   Let's begin!
    
    