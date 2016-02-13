//
//  main.h
//  Zork
//
//  Created by Tian Qiu on 12/12/15.
//  Copyright © 2015 Tian Qiu. All rights reserved.
//

#ifndef main_h
#define main_h

#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <iterator>
#include "rapidxml/rapidxml.hpp"
#include "rapidxml/rapidxml_utils.hpp"
#include "rapidxml/rapidxml_print.hpp"
#include "ZorkObjects/player.hpp"

using namespace rapidxml;
using namespace std;



vector<Item> master_items;
vector<Creature> master_creatures;

#endif /* main_h */
