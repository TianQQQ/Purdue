#ifndef SHORTPATH
#define SHORTPATH
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAX 0x7FFFFFFF//The maximum number that int can represent

typedef struct linknode{
  struct vertex * ver;//Pointer to adjacent vertex
  struct linknode * next;//Pointer to next node in link list
}Linknode;
typedef struct vertex{
  int x, y;//x,y coordinate of vertex
  int ind;//The index of vertex
  Linknode* list;//The linked list stores adjacent vertices
  struct vertex * predecessor;//Points to its predecessor
  unsigned char visit;//Visited or not
  int distance;//Temperary distance
}Vertex;

Vertex * * Loadvertex(FILE * fp, int num_ver, char * buffer);
Vertex * Createvertex(char * buffer, int i);
void Destroy_list(Linknode * node);
void Destroy_vertex(Vertex * * ver_arr, int num_ver);
Linknode * Createnode(Vertex * ver);
void Add_listnode(Vertex * ver, Vertex * neighbor);
void Loadedges(Vertex * * ver_arr, int num_edges, char * buffer, FILE * fp);
void Initialize(Vertex * * ver_arr, Vertex * * unvisit, int num_ver);
void Traverse(Vertex * * unvisit, Vertex * cur, int * last_ind, int min_ind);
int Cal_dis(Vertex * ver1, Vertex * ver2);
int * Loadquery(FILE * query, char * buffer, int num_query);
void Findpath(Vertex * * ver_arr, int num_ver, int num_query, int * query_ind);
Vertex * GetVertex(Vertex * * unvisit, int last_ind, int * min_ind);
void PrintRoute(Vertex * start, Vertex * des, int num_ver);
#endif
