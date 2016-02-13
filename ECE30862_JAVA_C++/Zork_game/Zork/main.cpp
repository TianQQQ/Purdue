//
//  main.cpp
//  Zork
//
//  Created by Tian Qiu on 12/12/15.
//  Copyright © 2015 Tian Qiu. All rights reserved.
//

#include "main.h"
#include "parseFunctions.h"
#include "CommandInput.h"

int main(int argc, const char * argv[]) {
    vector<Item> items;
    vector<Room> rooms;
    vector<Creature> creatures;
    vector<Container> containers;
    int trig;
    
    parseXML(argv[1], &creatures, &rooms, &items, &containers);
    
    rooms = wholeMapBuilder(rooms, items, containers, creatures);
    roomRelationshipSetHelper(&rooms);
    
    Player player(&rooms.at(0));
    
    cout<<player.getCurrentRoom()->getDescription()<<"\n";
    
    while(player.getExitFlag() == 0){
        getPlayerAction(&player);
        
        Trigger temp_trigger = player.getCurrentRoom()->getTrigger();
        trig = checkTriggers(&player, &temp_trigger, "");
        player.getCurrentRoom()->setTrigger(temp_trigger);
        
        for(unsigned i = 0; i < player.getCurrentRoom()->getCreature().size(); i++){
            temp_trigger = player.getCurrentRoom()->getCreature().at(i).getTrigger();
            trig = checkTriggers(&player, &temp_trigger, "");
            player.getCurrentRoom()->getCreature().at(i).setTrigger(temp_trigger);
            
        }
        
        
        for(unsigned i = 0; i < player.getCurrentRoom()->getContainer().size(); i++){
            temp_trigger = player.getCurrentRoom()->getContainer().at(i).getTrigger();
            trig = checkTriggers(&player, &temp_trigger, "");
            player.getCurrentRoom()->getContainer().at(i).setTrigger(temp_trigger);
            
        }
    }
    
    cout<<"Game Over\n";
    
    return EXIT_SUCCESS;
}
