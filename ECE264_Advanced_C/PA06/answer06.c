#include "answer06.h"
#include <stdio.h>
#include <stdlib.h>


#define SPACE ' '
#define WALL  'X'
#define TRACK '.'
#define MAX_W 100
#define MAX_H 100


void print_directions(char** maze, int w, int h) 
{
	int row = 0;
	int col;
	char direction; //start point
	int distance = 1;
	char ch;
	for(col = 0; col < w; col++)
	{
      ch = maze[row][col];
      if(ch == ' ')
	{
	  row++;
	  break;
	}
	}
    maze[row-1][col] = WALL;
    direction = 'Z';
	printf("%c %d\n", 'S', 1);
	move(row, col, direction, distance, maze, w, h);
	
}

// function reports whether it is possible to move at a direction at the current location
void move(int row, int col, char direction, int distance, char** maze, int w, int h)
{
	char dir;  //direction
	char ch;	
	int dis = 1;   //distance
	int judge = 0;
	int print = 0; // print number
		
		
	if(judge == 0)
	{
		printf("%c %d\n", direction, distance);
	}
	
	
	// dead end and turn arount 
	if((judge == 0 || print == 1)&& (row!=(h-1) && col !=(w-1) && row!=0 && col !=0))
    {
  		if(direction=='W')
		{
			printf("%c %d\n", 'E', distance);
		}
 	    else if(direction=='S')
		{
			printf("%c %d\n", 'N', distance);
		}		
 	    else if(direction=='N')
		{
			printf("%c %d\n", 'S', distance);
		}		
	    else if(direction=='E')
		{
			printf("%c %d\n", 'W', distance);
		}
    }
  	else if(row==(h-1))
    {
        printf("%c %d\n", 'N',1 );
    }
    else if(row==0)
    {
        printf("%c %d\n", 'S',1 );
    }
    else if(col==0)
    {
        printf("%c %d\n", 'W',1 );
    }
    else if(col==(w-1))
    {
        printf("%c %d\n", 'E',1 );
    }
  		
  		
 	if(row != 0 && direction != 'S')
	{
		ch = maze[row - 1][col];
		if(ch == SPACE)
		{
			dir = 'N';
			if(dir == direction)
			{
				move(row-1, col, dir, distance + 1, maze, w, h);
			}
			else
			{
				if(direction != 'Z')
				{
					printf("%c %d\n",direction, distance);
				}
				move(row-1, col, dir, dis, maze, w, h);
				print = 1;
			}
			judge = 1;
		}
	}
	
		
	if(col != 0  && direction != 'E')
	{
		ch = maze[row][col-1];
		if(ch == SPACE)
		{
			dir = 'W';
			if(dir == direction)
			{
				if(print ==1)
				{
					move(row, col-1, dir, 1,maze,w,h);
				}
				else
				{
					move(row, col-1, dir, distance + 1, maze, w, h);
				}
			}
			else
			{
				if(direction != 'Z' && (judge == 0 || print == 0))
				{
					printf("%c %d\n",direction, distance);
				}
				move(row, col-1, dir, dis, maze, w, h);
				print = 1;
			}
			judge = 1;
		}
	}
	
	
	if(row < h-1 && direction != 'N')
	{
		ch = maze[row + 1][col];
		if(ch == SPACE)
		{
			dir = 'S';
			if(dir == direction)
			{
				if(print == 1)
				{
					move(row+1, col, dir, 1,maze,w,h);
				}
				else
				{
					move(row+1, col, dir, distance + 1, maze, w, h);
				}
			}
			else
			{
				if(direction != 'Z' && (judge == 0 || print == 0) )
				{
					printf("%c %d\n",direction, distance);
				}
				move(row+1, col, dir, dis, maze, w, h);
				print = 1;
			}
			judge = 1;
		}
	}
	
		
	if(col < (w-1) && direction != 'W')
	{
		ch = maze[row][col+1];
		if(ch == SPACE)
		{
			dir = 'E';
			if(dir == direction)
			{
				if(print == 1)
				{
					move(row, col+1, dir, 1,maze,w,h);
				}
				else
				{
					move(row, col+1, dir, distance + 1, maze, w, h);
				}
			}
			else
			{
				if((direction != 'Z') && (judge == 0 || print == 0))
				{
					if(row!=(h-2) || (maze[row+1][col] != SPACE))
						printf("%c %d\n",direction, distance);
				}
				move(row, col+1, dir, dis, maze, w, h);
				print = 1;
			}
			judge = 1;
		}
	}
	
 	
	
	return;	
}




