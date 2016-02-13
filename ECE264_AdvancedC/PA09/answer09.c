#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "answer09.h"


/* A BusinessNode contains the name, address, and average rating of a Business.
 * It also contains pointers to the left and right children of the node.
 */


//#define test
#ifdef test

int main(int argc, char * * argv)
{
   BusinessNode * root = create_node("5.0", "random name", "random address");
   root->left = create_node("3.5", "another name", "another address");
   root->right = create_node("4.0", "yet another name", "some address");
   root->left->right = create_node("1.5", "name 3", "address 3");
   print_tree(root);
   return 0;
}

#endif
/*
 * Construct one BusinessNode. You need to allocate memory for this node first.
 *
 * The caller needs to make sure to use strdup(...) for the arguments, do not
 * use strdup(...) inside of this function.
 *
 * stars: the stars of this business
 * name: name of this business
 * address: address of this business
 */
BusinessNode* create_node(char * stars, char * name, char * address){
	BusinessNode* bn;
	bn = malloc(sizeof(BusinessNode));
	bn -> left = NULL;
	bn -> right = NULL;
	bn -> stars = stars; // remeber to free the stars
	bn -> name = name;
	bn -> address = address;
	return (bn);
}


/* Insert a node into a BST. Primarily used in load_tree_from_file(). Return a
 * pointer to the root of the BST.
 */
BusinessNode *
tree_insert(BusinessNode * node, BusinessNode * root){
	if(root == NULL){ //base case empty, create a node
		return node;
	}
	if(strcmp(node -> name, root -> name) > 0){  //node's name > root name
		root -> right = tree_insert(node ,root -> right);  // node has been already a pointer
	}else{
		root -> left = tree_insert(node, root -> left);
	}
	return root;
}

/* Parse a .tsv file line by line, create a BusinessNode for each entry, and
 * enter that node into a new BST. Return a pointer to the root of the BST.
 *
 * The explode(...) function from PA03 may be useful for breaking up a lines 
 * into seperate fields. 
 */
BusinessNode *
load_tree_from_file(char * filename){
	FILE *fptr;
	fptr = fopen(filename, "r");
	printf("File name is %s\n", filename);
	if(!fptr){
		return NULL;
	}
	BusinessNode* root = NULL;
	BusinessNode* node = NULL;
	char* buffer = malloc(sizeof(char) * 2000); // buffer to contain 
	int i = 0;
	int d = 0;
	int f = 0;
	while( fgets(buffer, 300, fptr) != NULL){
		i = 0;
		d = 0;
		while(buffer[d] != '\t'){ // '\t' tab distance
			d++;
		}
		
		char* stars = malloc(sizeof(char) * (d+1));
		d = 0;
		while (buffer[d] != '\t'){
			stars[i] = buffer[d];  //stars from buffer[d]
			i++;
			d++;
		}
		stars[i] = '\0'; //the end of stars set to "\0'
		d++;
		while(buffer[d] != '\t'){  // plus until next 
			d++;
		}
		
		
		char* name = malloc(sizeof(char) * (d - i + 1));
		d = i + 1;
		i = 0;
		while(buffer [d] != '\t'){
			name[i] = buffer[d];
			i++;
			d++;
		}
		name[i] = '\0';
		d++;
		f = d;
		while (buffer[d] != '\n'){
			d++;
		}
		
		char* address = malloc(sizeof(char) * (d - f + 1));
		d = f;
		i = 0;
		while(buffer[d] != '\n'){
			address[i] = buffer[d];
			i ++;
			d ++;
		}
		address[i] = '\0';
		node = create_node(stars, name, address);
		root = tree_insert(node, root);
	}
	free(buffer);
	fclose(fptr);
	return root;
	
}



/* Search a BusinessNode BST for the node with the name 'name'. Returns
 * pointer to the node with a match.
 *
 * If there is no match, return NULL.
 */
BusinessNode *
tree_search_name(char * name, BusinessNode * root){
	if(root == NULL){ //base case cannot find
		return NULL;
	}
	if(strcmp(name, root -> name) == 0){ //found , return local treenode
		return root;
	}
	if(strcmp(name, root -> name) > 0){
		return tree_search_name(name, root -> right);
	}
	return tree_search_name(name, root -> left); // otherwise search the left side

}

/* Print out a single node: name, address, and stars
 * The format can be similar to this:
 *
 * Country Cafe
 * ============
 * Stars:
 *    3.5
 * Address:
 *    1030 Emerald Ter, Sun Prairie, WI 53590
 *
 * This function is not graded, but it could come in very handful while
 * debugging this assignment.
 */
void
print_node(BusinessNode * node){
	printf("%s \n", node -> name);
	printf("============\n");
	printf("stars:\n");
	printf("   %s", node -> stars);
	printf("Address:\n");
	printf("   %s", node -> address);
}

/* Print the entire tree, starting from the root. Like the print_node(...)
 * function, this is not graded.
 */
void
print_tree(BusinessNode * tree){
	if (tree == NULL){ //base case
		return;
	}
	print_tree(tree -> left);
	print_node(tree);
	print_tree(tree -> right);
}

/* Deallocate all of the memory used by a BusinessNode BST, without memory
 * leaks.
 */
void destroy_tree(BusinessNode * root){
	if(root == NULL){
		return;
	}
	destroy_tree(root -> left);
	destroy_tree(root -> right);
	free(root -> stars);
	free(root -> name);
	free(root -> address);
	free(root);
}

















