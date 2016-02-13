/*
 Created by Tian Qiu on Apr/20/2015
 */


#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#define MAX 0x7FFFFFFF;//The maximum number that int can represent
#define INF 100000000;


typedef struct linknode{
	struct vertex * ver;//Pointer to adjacent vertex
	struct linknode * next;//Pointer to next node in link list
}Linknode;
typedef struct vertex{   //every person
	int id;
	int age;
	int sex;
	int ms;  // material status
	int race;
	int bp;  // birthday place
	int lang; // language
	int opt;  // occupation
	int inc;  // income
	int UL;// distance
	unsigned char visit;//Visited or not

}Vertex;
Vertex * Createvertex(char * buffer, int i);
Vertex * * Loadvertex(FILE * fp, int num_ver, char * buffer);
double * * Loadedges(Vertex * * ver_arr,double delta,int num_ver);
int dijkstra (double * * mat,int n,int s,double alpha, Vertex * * ver_arr);
int * firstneighbor(double * * mat,int n,int s);
int * secondneighbor(double * * mat,int * lv1list, int n, int s, int lv1);
void quicksort(int list[], int n);


int main(int argc, char * * argv)
{
	if(argc != 2){
		fprintf(stderr,"You can only use exactly one file as input.\n");
		return EXIT_FAILURE;
	}
	FILE * input = fopen(argv[1],"r");
	if(!input){
		fprintf(stderr,"Fail to open input file %s.\n",argv[1]);
		return EXIT_FAILURE;
	}
	char * buffer = malloc(200 * sizeof(char));  //buffer for strtok


	//Read inputs
	fgets(buffer, 199, input);                 // get first line of input
	int num_ver = atoi(strtok(buffer, ","));   // split string into tokens ( )
	double delta1 = atof(strtok(NULL, ","));   // split string into tokens ( )
	double delta2 = atof(strtok(NULL, ","));   // second time use strtok, set buffer to NULL
	int query1 = atoi(strtok(NULL, ",")) - 1;  // first id - 1
	double alpha = atof(strtok(NULL, ","));



	//Load inputs
	Vertex * * ver_arr = Loadvertex(input, num_ver, buffer);   // put 8 attribtues in each vertex struct ( struct array)


	//Load edges
	double * * mat1;
	double * * mat2;
	mat1 = Loadedges(ver_arr, delta1, num_ver);
	mat2 = Loadedges(ver_arr, delta2, num_ver);

	//////////////delta1
	int  ct1 = dijkstra (mat1, num_ver, query1, alpha, ver_arr);
	printf("%d\n", ct1);
	int * lv1list;
	int * lv2list;
	int i;
	lv1list = firstneighbor(mat1, num_ver, query1);	
	lv2list = secondneighbor(mat1, lv1list, num_ver, query1, lv1list[0]);

	for(i = 0; i < lv1list[0] + 1; i++){  // printf first neighbor
		printf("%d", lv1list[i]);
		if(i != lv1list[0])	printf(",");
	}
	printf("\n");


	for(i = 0; i < lv2list[0] + 1; i++){  // printf second neighbor
		printf("%d", lv2list[i]);
		if(i != lv2list[0]) printf(",");
	}
	printf("\n");

	double av1 = 0.0;
	double av2 = 0.0;
	for (i = 0; i < num_ver; i++){        // calculate average nodes 
		lv1list = firstneighbor(mat1, num_ver, i);
		lv2list = secondneighbor(mat1, lv1list, num_ver, i, lv1list[0]);
		av1 += lv1list[0];
		av2 += lv2list[0];
	}
	av1 /= num_ver;
	av2 /= num_ver;
	printf("%.2f\n", av1);
	printf("%.2f\n", av2);

	////////////////delta2
	printf("\n");
	int  ct2 = dijkstra (mat2, num_ver, query1, alpha, ver_arr);
	printf("%d\n", ct2);
	lv1list = firstneighbor(mat2, num_ver, query1);
	lv2list = secondneighbor(mat2, lv1list, num_ver, query1, lv1list[0]);

	for(i = 0; i < lv1list[0] + 1; i++){  // printf first neighbor
		printf("%d", lv1list[i]);
		if(i != lv1list[0]) printf(",");
	}
	printf("\n");


	for(i = 0; i < lv2list[0] + 1; i++){  // printf second neighbor
		printf("%d", lv2list[i]);
		if(i != lv2list[0]) printf(",");
	}
	printf("\n");

	av1 = 0.0;
	av2 = 0.0;
	for (i = 0; i < num_ver; i++){        // calculate average nodes 
		lv1list = firstneighbor(mat2, num_ver, i);
		lv2list = secondneighbor(mat2, lv1list, num_ver, i, lv1list[0]);
		av1 += lv1list[0];
		av2 += lv2list[0];
	}
	av1 /= (double) num_ver;
	av2 /= (double) num_ver;
	printf("%.2f\n", av1);
	printf("%.2f\n", av2);
	//Destory maps
	// //   Destroy_vertex(ver_arr, num_ver);
	free(mat1);
	free(mat2);
	free(lv1list);
	free(lv2list);
	free(buffer);
	fclose(input);
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
		fgets(buffer, 199, fp);                // fgets is buffer size - 1
		Vertex * tmp = Createvertex(buffer, i);//Create a new vertex
		ver_arr[tmp->id - 1] = tmp;//Put new vertex to corresponding index of array  (id 1 set to array0)

	}
	return ver_arr;
}

Vertex * Createvertex(char * buffer, int i){
	//Create a new vertex
	Vertex * ret = malloc(sizeof(Vertex));
	ret->id =  atoi(strtok(buffer, ","));
	ret->age = atoi(strtok(NULL, ","));   // split string into tokens ( )
	ret->sex = atoi(strtok(NULL, ","));   // second time use strtok, set buffer to NULL
	ret->ms = atoi(strtok(NULL, ","));
	ret->race = atoi(strtok(NULL, ","));
	ret->bp   = atoi(strtok(NULL, ","));
	ret->lang  = atoi(strtok(NULL, ","));
	ret->opt   = atoi(strtok(NULL, ","));
	ret->inc = atoi(strtok(NULL, ","));
	ret->UL = 1;
	return ret;
}


double * * Loadedges(Vertex * * ver_arr,double delta,int num_ver){

	int i, j;
	double * * mat;
	double L = 0;   //the max number of UL  Lmax
	mat = (double * *) malloc(num_ver * sizeof(double *));
	for(i=0;i<num_ver;i++)	mat[i] = (double *) malloc(sizeof(double) * num_ver);
	for(i=0;i<num_ver;i++)
	{
		for(j=0;j<num_ver;j++)
		{
			mat[i][j] = 0.0;     //initializtion
		}
	}


	for(i = 0; i < num_ver; i++){
		for(j = 0 ; j<num_ver; j++){
			mat[i][j] = pow((ver_arr[i]->age - ver_arr[j]->age),2);
			mat[i][j] += pow((ver_arr[i]->bp - ver_arr[j]->bp),2);
			mat[i][j] += pow((ver_arr[i]->inc - ver_arr[j]->inc),2); 
			mat[i][j] += pow((ver_arr[i]->lang - ver_arr[j]->lang),2); 
			mat[i][j] += pow((ver_arr[i]->ms - ver_arr[j]->ms),2) ;
			mat[i][j] += pow((ver_arr[i]->opt - ver_arr[j]->opt),2) ;
			mat[i][j] += pow((ver_arr[i]->race - ver_arr[j]->race),2) ;
			mat[i][j] += pow((ver_arr[i]->sex - ver_arr[j]->sex),2);
			mat[i][j] = sqrt(mat[i][j]);// UL
			if (mat[i][j] > L){
				L = mat[i][j];
			}
		}
	}
	//printf("Lmax = %f\n", L);

	for(i = 0; i < num_ver; i++){
		for(j = 0 ; j<num_ver; j++){
			double Lab = 0;
			int near = 0;
			if(L != 0) {
				Lab = 1 - (mat[i][j] / L); 
				near = (int) (Lab * 100);
				Lab = (double) near / 100;
			}

			if(Lab <= delta || i == j){
				mat[i][j] = 100000000;
			} else{
				mat[i][j] = Lab;
			}
		}   
	}   
	return mat;


}


int dijkstra (double * * mat,int n,int s,double alpha, Vertex * * ver_arr)
{
	double dis[n];
	double shortnode = INF;//设置最短的距离
	double min = INF;
	int mark[n];//记录被选中的结点
	int i,j,k,ct = 0;
	int shortnodeid[n];


	//////////1
	for(i = 0 ; i < n ; i++){//初始化所有结点，每个结点都没有被选中
		mark[i] = 0;
		dis[i] = INF;
		shortnodeid[i] = 0;
	}
	i = 0;
	for(j = 0; j < n ; j++){//将每个结点到start结点weight记录为当前distance
		if(dis[j] > mat[s][j]){    // shortest neighbor found
			dis[j] = mat[s][j];
		}
		if(shortnode > mat[s][j]){
			shortnode = mat[s][j];
			i = 0;
			shortnodeid[i] = j;
		}
		else if(shortnode == mat[s][j]){
			shortnodeid[++i] = j;
		}
	}
	printf("%.2f",  shortnode);
	for(j = 0; j < i + 1; j++){
		printf(",%d", shortnodeid[j] + 1);
	}
	printf("\n");


	///////////2 
	mark[s] = 1;
	for(i = 0 ; i < n; i++){   //n terms
		if( s != i){
			for(j = 0; j < n; j++){  // shortest in the neighbor 
				if(mark[j] == 0 && dis[j] < min){
					k = j;
				}
			}
			mark[k] = 1;
			for(j = 0; j < n; j++){
				if( s != j && mark[j] == 0 && (dis[j] > dis[k] + mat[k][j])){ //借道k 修改剩余节点
					dis[j] = dis[k] + mat[k][j];
				}
			}
		}
	}	
	for(i = 0; i < n; i++){ //find min path
		if (dis[i] * 100 < alpha * 100) ct++;
	}

	return ct;
}

int * firstneighbor(double * * mat,int n,int s){
	int i,j;
	int lv1 = 0;
	int a = 0;

	for(j = 0; j < n ; j++){//将每个结点到start结点weight记录为当前distance	
		if(mat[s][j] < 100000000) lv1++;
	}
	int * lv1list = malloc(sizeof(int) * (lv1 + 1));
	lv1list[0] = lv1;
	for(i = 0; i < n; i++){ //find first neighbor
		if(mat[s][i]  < 100000000){
			a++;
			lv1list[a] = i + 1;
		}
	}

	return lv1list;
}



int *secondneighbor(double * * mat,int * lv1list, int n, int s, int lv1){
	int i,j,k = 0;
	int mark1[n];
	int lv2 = 0;
	int a = 0;
	for(i = 0 ; i < n ; i++){//初始化所有结点，每个结点都没有被选中
		mark1[i] = 0;
	}   
	mark1[s] = 1;
	for(i = 0; i < lv1; i++){
		k = lv1list[1 + i] - 1;
		for (j = 0; j < n; j++){
			if(mark1[j] == 0 && mat[k][j] < 100000000) {
				++lv2;
				mark1[j] = 1;
			}
		}
	}

	for(i = 0 ; i < n ; i++){//初始化所有结点，每个结点都没有被选中
		mark1[i] = 0;
	}
	mark1[s] = 1;
	k = 0;

	int * lv2list = malloc(sizeof(int) * (lv2 + 1));
	lv2list[0] = 0;
	for(i = 0; i < lv1; i++){
		k = lv1list[1 + i] - 1;
		for (j = 0; j < n; j++){
			if(mark1[j] == 0 && mat[k][j] < 100000000) {
				++a;
				lv2list[a] = j + 1;
				mark1[j] = 1;
			}   
		}   
	}

	quicksort(lv2list, lv2 + 1);
	lv2list[0] = lv2;

	return lv2list;
}


void quicksort(int list[], int n){ 
	int i = 0;
	int j = n - 1;
	int val = list[0];  // reference num
	if (n > 1){   
		while(i < j){ 
			for (; i<j;j--){ // from end to start, find < val number, place into a[i]
				if(list[j] < val){
					list[i++] = list[j];
					break;
				}   
			}   
			for (; i<j;i++){// from start to end, find > val, place into a[j]
				if(list[i] > val){
					list[j--] = list[i];
					break;
				}   
			}   
		}   
		list[i] = val;
		quicksort(list,i);
		quicksort(list+i+1, n - i - 1); 
	}   
}
