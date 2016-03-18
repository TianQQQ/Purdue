#include <stdlib.h>
#include <stdio.h>

#define TRUE 1
#define FALSE 0
#define ASCII0 48
#define ASCII1 49

typedef struct leaf {
    int value;
    struct leaf * left;  // left sub-tree
    struct leaf * right; // right sub-tree
} HuffNode;

typedef struct StackNode_st
{
    HuffNode * tree;
    struct StackNode_st * next;
} StackNode;

typedef struct Stack_st
{
    StackNode * head; // head node of a linked-list
} Stack;


unsigned char bit_read(unsigned char* first, int* ind, FILE* fp);
unsigned char byte_read(unsigned char* first, int* ind, FILE* fp);
HuffNode * HuffNode_create(int value);
void HuffNode_destroy(HuffNode * tree);
Stack * Stack_create();
void Stack_destroy(Stack * stack);
void Stacknode_destroy(StackNode* stacknode);
int Stack_isEmpty(Stack * stack);
HuffNode * Stack_popFront(Stack * stack);
void Stack_pushFront(Stack * stack, HuffNode * tree);
void Stack_popPopCombinePush(Stack * stack);
HuffNode * HuffTree_readTextHeader(FILE * fp);
HuffNode * HuffTree_readBinaryHeader(FILE * fp);

HuffNode * HuffNode_create(int value){  // create a new HuffNode
	HuffNode* node = malloc(sizeof(HuffNode));    //node size is huffnode
	node -> value = value;
	node -> left = NULL;
	node -> right = NULL;
	return node;
}

void HuffNode_destroy(HuffNode* tree){   //tree is a node and free all memory safely
	if(tree == NULL){ //base case
		return;
	}
	HuffNode_destroy(tree -> left);  // to the end left
	HuffNode_destroy(tree -> right); // to the end right
	free(tree);
}

Stack * Stack_create(){  //  allocate a brand new stack
	Stack* create_stack = malloc(sizeof(Stack));
	create_stack -> head = NULL;
	return create_stack;
}


/**
 * Frees all memory associated with the stack. 
 * Don't forget that you must free the entire contained linked-list.
 * Also, you must safely do nothing if stack == NULL. 
 */
void Stack_destroy(Stack * stack){    //destroy stack first
	if(stack == NULL){  // base case
		return;
	}
	Stacknode_destroy(stack -> head);
	free(stack);
}

void Stacknode_destroy(StackNode* stacknode){
	if(stacknode == NULL){
		return;
	}
	Stacknode_destroy(stacknode -> next);   // to the end of next
	HuffNode_destroy(stacknode -> tree);    //upside down to free
	free(stacknode -> next);                // free last next
}

int Stack_isEmpty(Stack* stack){
	if(stack == NULL){
		return TRUE;
	}
	return FALSE;
}

/**
 * Pop the front (top) 'value' (i.e. Huffman tree) from the stack.
 *
 * More precisely, this function must do three things:
 * (1) Save the value (i.e. Huffman tree) of the head node of the stack's list
 * (2) Remove the head node of the stack's list, freeing it.
 * (3) Return the value (i.e. Huffman tree) saved in (1).
 */
HuffNode * Stack_popFront(Stack * stack){  // pop the front huffman tree from the stack
	if(Stack_isEmpty (stack)){    //stack only is used for head 
		return NULL;
	}
	HuffNode* poptree;    //poptree has value left right
	StackNode* popnode;   //popnode has tree and next
	poptree = stack -> head -> tree; //stack -> head has tree and next (a stacknode)
	popnode = stack -> head -> next;
	free(stack -> head);   
	stack -> head = popnode; //get front huffman tree in the first next
	return poptree;
}

/**
 * Push a 'value' (i.e. Huffman tree) onto the front (top) of the stack.
 *
 * More precisely, this function must do two things:
 * (1) Create a new StackNode with 'tree' for its tree.
 * (2) Push that new StackNode onto the front of the stack's list.
 */
void Stack_pushFront(Stack * stack, HuffNode * tree){
	StackNode* pushnode = malloc(sizeof(StackNode)); //pushnode has tree and next
	pushnode -> tree = tree;
	pushnode -> next = stack -> head;
	stack -> head = pushnode;   //get the head into pushnode
}

/**
 * This function helps simplify building a Huffman Coding Tree from the header
 * information. It takes a stack as input. As a precondition, you can assume 
 * that the stack has at least two nodes. This function pops the front (top) 
 * two nodes, combines them into a single node, and pushes the new node back 
 * onto the stack. See Huffman_Coding.pdf to understand conceptually how this
 * should be done.
 */
void Stack_popPopCombinePush(Stack * stack){  //stack as input and has two nodes
	HuffNode* popnode1 = Stack_popFront(stack); 
	HuffNode* popnode2 = Stack_popFront(stack);
	HuffNode* node_combine = HuffNode_create (0);
	node_combine -> left = popnode2;
	node_combine -> right = popnode1;
	Stack_pushFront(stack, node_combine);
}

// ---------------------------------------------------- Reading HuffTree headers

/**
 * Read a Huffman Coding Tree (in text format) from 'fp'.
 */
HuffNode * HuffTree_readTextHeader(FILE * fp){
	if( fp == NULL){
		fprintf(stderr, "Failed");
		return NULL;
	}
	Stack* stack = Stack_create();
	int ind = fgetc(fp);
	while(!feof(fp)){   // not get the EOF
		if(ind == ASCII0){   // 48 ascii is 0
			if(stack -> head -> next == NULL) {
				break;
			}
			Stack_popPopCombinePush(stack);
		}
		if(ind == ASCII1){   // the start of fp is 1
			ind = fgetc(fp); // fp has moved to next number
			HuffNode* node = HuffNode_create(ind);
			Stack_pushFront(stack, node); //push the first Stack to front
		}
		ind = fgetc(fp);
	}
	HuffNode* final = Stack_popFront(stack);
	Stack_destroy(stack);
	return final;  // final is the start of linked list
}

/**
 * Read a Huffman Coding Tree (in binary format) from 'fp'.
 * You will need to (conceptually) read a file a bit at a time. See the README
 * for hints on how to do this.
 */
HuffNode * HuffTree_readBinaryHeader(FILE * fp){
	if(fp == NULL){
		fprintf(stderr, "failed");
		return NULL;
	}
	Stack* stack = Stack_create();
	unsigned char* first = malloc(sizeof(unsigned char));
	*first = fgetc(fp);   // pointer first get the first ch of fp
	int* ind = malloc(sizeof(int));
	unsigned char bit;
	*ind = 7;  // every byte has 7 valid bits
	bit = bit_read(first, ind, fp);
	while(!feof(fp)){
		if(bit == 1){
			unsigned char real = byte_read(first, ind, fp);
			HuffNode* node = HuffNode_create(real);
			Stack_pushFront(stack, node);
		}
		if(bit == 0){
			if(stack -> head -> next == NULL){
				break;
			}
			Stack_popPopCombinePush(stack);
		}
		bit = bit_read(first, ind, fp);
	}
	free(ind);
	free(first);
	HuffNode* final = Stack_popFront(stack);
	Stack_destroy(stack);
	return final;
}

unsigned char bit_read(unsigned char* first, int* ind, FILE* fp){
	//              first character, 7 bits, fp file
	if(*ind == -1){  //malloc fail
		*first = fgetc(fp);
		*ind = 7;
	}
	unsigned char bit = (*first >> *ind) & 0x01;   // the bit move to right 7 bits
	*ind = *ind - 1;  //???
	return bit;
}

unsigned char byte_read(unsigned char* first, int* ind, FILE* fp){
	unsigned char byteread = 0;
	int byteInd;
	for(byteInd = 7; byteInd >= 0; byteInd--){
		byteread = byteread + (bit_read(first, ind, fp) << byteInd);// the bit move to left
	}
	return byteread;
}

	
		
		






















































