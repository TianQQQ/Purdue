//
//  parseFunctions.h
//  Zork
//
//  Created by Tian Qiu on 12/12/15.
//  Copyright © 2015 Tian Qiu. All rights reserved.
//

#ifndef parseFunctions_h
#define parseFunctions_h

#include "ZorkObjects/triggers.h"



/////////////////////////////////// Main //////////////////////////////////////
void parseXML(string filename, vector<Creature>* creatures, vector<Room>* rooms, vector<Item>* items, vector<Container>* containers){
    
    file<> Fdoc(filename.c_str());
    xml_document<> doc;
    doc.parse<0>(Fdoc.data());
    xml_node<> *node = doc.first_node("map");
    for(xml_node<> *i = node->first_node(); i; i = i->next_sibling()){
        if(!strcmp(i->name(),"creature")){
            Creature new_creature = parseCreature(i);
            creatures->push_back(new_creature);
        }
        if(!strcmp(i->name(),"room")){
            Room new_room = parseRoom(i);
            rooms->push_back(new_room);
        }
        if(!strcmp(i->name(),"item")){
            Item currentItem = parseItem(i);
            items->push_back(currentItem);
        }
        if(!strcmp(i->name(),"container")){
            Container new_container = parseContainer(i);
            containers->push_back(new_container);
        }
    }
}



#endif /* parseFunctions_h */
