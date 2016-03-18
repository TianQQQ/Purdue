#include <stdio.h>
#include <stdlib.h>
#include <time.h>
typedef struct treenode{
	struct treenode* left;
	struct treenode* right;
	int value;
}TreeNode;

static TreeNode * TreeNode_construct(int val){
	TreeNode* tn;
	tn = malloc(sizeof(TreeNode));
	tn -> left  = NULL;
	tn -> right = NULL;
	tn -> value = val;
	return tn;
}


//insert a value v to a binary serach tree starting with root, return the new root
TreeNode* Tree_insert(TreeNode * tn, int val){
	 if(tn == NULL){ //base case empty, create a node
	 	return TreeNode_construct(val);
	 }
	 if(val == (tn -> value)){ // do not need to insert, same value
	 	return tn;
	 }
	 if(val < (tn -> value)){ 
	 	tn ->  left = Tree_insert(tn -> left, val);
	 }else{
	 	tn -> right = Tree_insert(tn -> right, val);
	 }
}

//search a value in a binary serach tree starting with root, return the node whose value is v
TreeNode* Tree_search(TreeNode* tn, int val){
	if(tn == NULL){ //  base case cannot find
		return NULL;	
	}
	if(val == (tn -> value)){ //found, return local treenode
		return tn;
	}
	if(val < (tn -> value)){ //search the left side
		return Tree_search(tn -> left, val);
	}
	return Tree_search(tn -> right, val);  //otherwise search the right side
}

// print the values stored in the binary search tree

static void TreeNode_print(TreeNode* tn){
	printf("%d ", tn -> value);
}

static void Tree_printInorder(TreeNode* tn){  // left print then return node and right
	if (tn =NULL){
		return;
	}
	Tree_printInorder(tn -> left);
	TreeNode_print(tn);
	Tree_printInorder(tn -> right);
}



// delete the node whose value is v, return the root of remaining tree
TreeNode* Tree_delete(TreeNode* tn, int val){
	if (tn == NULL){    // base case return
		return (NULL);
	}
	if (val < (tn -> value)){
		tn -> left = Tree_delete(tn -> left, val);
	}
	if (val > (tn -> value)){
		tn -> right = Tree_delete(tn -> right, val);
	}
	
	// now val = tn -> value 
	if (((tn -> left) == NULL) && ((tn -> right) == NULL)){  // tn has no child
		free (tn);
		return NULL;
	} 
	if ((tn -> left) == NULL){   // right child
		TreeNode* rc = tn -> right;
		free (tn);
		return (rc); //  return right copy to previous parent
	}
	if (tn -> right == NULL){  // left child
		TreeNode* lc = tn -> left;
		free (tn);
		return (lc); //  return left copy to previous parent
	}
	// tn has two children, find the immediate successor
	TreeNode* su = tn -> right; // right successor must not be null
	while (su -> left != NULL){
		su = su -> left;
	}
	// successor is tn's immediate successor

	tn -> value = su -> value;	// swap their values , the immediate successor value swap to tn
	su -> value = val;
	tn -> right = Tree_delete(tn -> right, val);  // delete the successor
	return tn;
}

// destroy every node
void Tree_destroy (TreeNode* n){
	if(n == NULL){
		return;
	}
	Tree_destroy(n-> left); // to the end of left  child
	Tree_destroy(n->right); // to the end of right child
	free(n);
}

int main(int argc, char* argv[]){
	TreeNode* root = NULL;
	int num = 0;
	int iter;   //iteration
	unsigned int seed = time(NULL);
	seed = 0;
	srand (seed);
	if (argc >= 2){
		num = (int) strtol(argv[1], NULL,10);
		// strtol(const char* nptr, char **endptr, int base)
		// nptr  argv[1]
		// endptr NULL not return illegal value
		// base denary notation                
	}
	if(num < 8){
		num = 8;
	}
	
	int* array = malloc(sizeof(int) * num);
	for(iter = 0; iter < num; iter++){
		array[iter] = rand() % 10000;
	}
	for(iter = 0; iter < num; iter++){
		int val = array[iter];
		printf("insert %d\n", val);
		root = Tree_insert(root, val);
		Tree_printInorder(root);
	}
	for (iter = 0; iter < num; iter ++){
		int index = rand() % (2 * num);
		if(index < num){
			int val = array[index];
			printf("delete %d\n", val);
			root = Tree_delete(root, val);
			Tree_printInorder(root);
		}
	}
	Tree_destroy(root);
	free (array);
	return EXIT_SUCCESS;
}

































