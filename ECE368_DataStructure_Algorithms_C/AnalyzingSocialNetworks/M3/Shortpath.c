#include "Shortpath.h"

int main(int argc, char * * argv)
{
  if(argc != 3){
    fprintf(stderr,"You can only use exactly two file as input.\n");
    return EXIT_FAILURE;
  }
  FILE * map = fopen(argv[1],"r");
  if(!map){
    fprintf(stderr,"Fail to open map file %s.\n",argv[1]);
    return EXIT_FAILURE;
  }
  FILE * query = fopen(argv[2],"r");
  if(!query){
    fprintf(stderr, "Fail to open query file %s.\n", argv[2]);
    fclose(map);
    return EXIT_FAILURE;
  }
  char * buffer = malloc(200 * sizeof(char));  //buffer for strtok 
  //Read no. of vertices and edges
  fgets(buffer, 199, map);                   // get file map data
  int num_ver = atoi(strtok(buffer, " "));   // split string into tokens ( )
  int num_edges = atoi(strtok(NULL, " "));   // second time use strtok, set buffer to NULL
  //Load maps
  Vertex * * ver_arr = Loadvertex(map, num_ver, buffer);
  //Load edges
  Loadedges(ver_arr, num_edges, buffer, map);
  //Read no. of queries
  fgets(buffer, 199, query);
  int num_query = atoi(buffer);
  //Load query
  int * query_ind = Loadquery(query, buffer, num_query);
  
  Findpath(ver_arr, num_ver, num_query, query_ind);

  //Destory maps
  Destroy_vertex(ver_arr, num_ver);
  free(buffer);
  free(query_ind);
  fclose(map);
  fclose(query);
  return EXIT_SUCCESS;
}

Vertex * * Loadvertex(FILE * fp, int num_ver, char * buffer)
{
  if(num_ver <= 0){
    fprintf(stderr, "The number of vertices is incorrect\n");
    return NULL;
  }
  Vertex * * ver_arr = malloc(num_ver * sizeof(Vertex *));
  int i;
  for(i = 0; i < num_ver; ++i){
    fgets(buffer, 199, fp);
    Vertex * tmp = Createvertex(buffer, i);//Create a new vertex
    ver_arr[tmp->ind] = tmp;//Put new vertex to corresponding index of array
  }
  return ver_arr;
}
Vertex * Createvertex(char * buffer, int i){
  //Create a new vertex
  Vertex * ret = malloc(sizeof(Vertex));
  ret->ind = atoi(strtok(buffer, " "));//Assign the index of vertex
  ret->x = atoi(strtok(NULL, " "));//Assign x coordinate
  ret->y = atoi(strtok(NULL, " "));//Assign y coordinate
  ret->predecessor = NULL;
  ret->visit = 0;
  ret->distance = MAX;
  ret->list = NULL;
  return ret;
}
void Destroy_vertex(Vertex * * ver_arr, int num_ver)
{
  int i;
  for(i = 0;i < num_ver; ++i){//Iterate through all vertex
    Destroy_list(ver_arr[i]->list);//Destroy cooresponding linked list
    free(ver_arr[i]);//Free each vertex
  }
  free(ver_arr);//Free vertices array
}
void Destroy_list(Linknode * node)
{
  if(node == NULL)
    return;
  Destroy_list(node->next);
  free(node);//Free node of linked list
}
void Loadedges(Vertex * * ver_arr, int num_edges, char * buffer, FILE * fp)
{
  int i;
  int left;//The index of left vertex of edge
  int right;//The index of right vertex of edge
  for(i = 0; i < num_edges; ++i){
    fgets(buffer, 199, fp);
    left = atoi(strtok(buffer, " "));
    right = atoi(strtok(NULL, " "));
    //Add right vertex to left vertex's neighbor
    Add_listnode(ver_arr[left], ver_arr[right]);
    //Add left vertex to right vertex's neighbor
    Add_listnode(ver_arr[right], ver_arr[left]);
  }
}
void Add_listnode(Vertex * ver, Vertex * neighbor)
{
  int insert = 0;
  Linknode * current = ver->list;
  Linknode * previous = NULL;
  Linknode * newnode = Createnode(neighbor);//Create a new node
  while(!insert){
    if(current == NULL || neighbor->ind < current->ver->ind){//If reach right pos
      if(previous == NULL){//If list is empty
	ver->list = newnode;
      }
      else{//If list is not empty
	previous->next = newnode;
      }
      newnode->next = current;
      insert = 1;
    }
    else{//Move to next node
      previous = current;
      current = current->next;
    }
  }
}   
Linknode * Createnode(Vertex * ver)
{
  Linknode * newnode = malloc(sizeof(Linknode));
  newnode->ver = ver;
  newnode->next = NULL;
  return newnode;
}
void Initialize(Vertex * * ver_arr, Vertex * * unvisit, int num_ver)
{
  int i;
  for(i = 0; i < num_ver; i++){
    ver_arr[i]->predecessor = NULL;
    ver_arr[i]->distance = MAX;
    ver_arr[i]->visit = 0;
    unvisit[i] = ver_arr[i];
  }

}
void Traverse(Vertex * * unvisit, Vertex * cur, int * last_ind, int min_ind)
{
  Linknode * list = cur->list;
  cur->visit = 1;
  while(list != NULL){
    //Skip visited vertex
    while(list->ver->visit == 1){
      list = list->next;
      if(list == NULL){
	unvisit[min_ind] = unvisit[*last_ind];
	unvisit[*last_ind] = NULL;
	*last_ind -= 1;
	return;
      }
    }
    //

    int dis = Cal_dis(cur, list->ver);
    if(dis + cur->distance < list->ver->distance){
      list->ver->distance = dis + cur->distance;
      list->ver->predecessor = cur;

    }
    list = list->next;
  }
  //Remove vertex from unvisit set
  unvisit[min_ind] = unvisit[*last_ind];
  unvisit[*last_ind] = NULL;
  *last_ind -= 1;
}
int Cal_dis(Vertex * ver1, Vertex * ver2)
{//Calculate the distance between two vertex
  return (int)sqrt(pow(ver1->x - ver2->x, 2) + pow(ver1->y - ver2->y, 2));
}
int * Loadquery(FILE * query, char * buffer, int num_query)
{
  int * ret = malloc(2 * num_query * sizeof(int));
  int i;
  for(i = 0; i < num_query; i++){
    fgets(buffer, 199, query);
    ret[2 * i] = atoi(strtok(buffer, " "));
    ret[2 * i + 1] = atoi(strtok(NULL, " "));
  }
  return ret;
}
void Findpath(Vertex * * ver_arr, int num_ver, int num_query, int * query_ind)
{
  Vertex * * unvisit = malloc(num_ver * sizeof(Vertex *));
  int i;
  int last_ind;
  int min_ind;
  for(i = 0; i < num_query; i++){
    Initialize(ver_arr, unvisit, num_ver);
    last_ind = num_ver - 1;
    ver_arr[query_ind[2 * i]]->distance = 0;
    min_ind = query_ind[2 * i];
    Traverse(unvisit, ver_arr[query_ind[2 * i]], &last_ind, min_ind);
    while(ver_arr[query_ind[2 * i + 1]]->visit != 1 && last_ind >= 0){
      Vertex * ver = GetVertex(unvisit, last_ind, &min_ind);
      Traverse(unvisit, ver, &last_ind, min_ind);
    }
    PrintRoute(ver_arr[query_ind[2 * i]], ver_arr[query_ind[2 * i + 1]], num_ver);
  }
  free(unvisit);
}
Vertex * GetVertex(Vertex * * unvisit, int last_ind, int * min_ind)
{
  int min_dis = unvisit[0]->distance;
  Vertex * ret = unvisit[0];
  int i;
  *min_ind = 0;
  for(i = 1; i <= last_ind; i++){
    if(unvisit[i]->distance < min_dis){
      min_dis = unvisit[i]->distance;
      ret = unvisit[i];
      *min_ind = i;
    }
  }
  return ret;
}
void PrintRoute(Vertex * start, Vertex * des, int num_ver)
{
  if(des->visit == 0){
    printf("There's no route from %d to %d\n", start->ind, des->ind);
    return;
  }
  printf("%d\n", des->distance);
  int * route = malloc(num_ver * sizeof(int));
  int i = 0;
  while(des != NULL){
    route[i] = des->ind;
    i += 1;
    des = des->predecessor;
  }
  i -= 1;
  while(i >= 0){
    printf("%d ", route[i]);
    i -= 1;
  }
  printf("\n");
  free(route);
}

