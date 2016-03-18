#include <ctype.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>

/* The struct types below are used for returning results.  You will
 * almost certainly need to define other struct types in your
 * answer10.c file.  
 */

struct Review {
	char* text;                /* Text of the review */
	uint8_t stars;             /* Star rating given with this review */
};

struct Location {
	char* address;              /* just the street address */
	char* city;                 /* city name */
	char* state;                /* 2 uppercase letters */
	char* zip_code;             /* 5 digits */
	struct Review* reviews;     /* ARRAY of Review struct objects */
	uint32_t num_reviews;       /* size of the above array */
};

struct Business {
	char* name;                 /* Business name, e.g., "McDonald's" */
	struct Location* locations; /* ARRAY of Location struct objects */
	uint32_t num_locations;     /* size of the above array */
	/* Note that we do not include the average star rating with the Business. */
};

struct YelpDataBST{
	int loc;    
	int rev1;
	int rev2;
	char* name;
	const char* p1;
	const char* p2;
	struct YelpDataBST* left;
	struct YelpDataBST* right;
};
/* You define this struct in your answer10.c file.  There are different ways
 * you might choose to structure it.  The YelpDataBST object is probably NOT
 * the root node of the tree, although the root node might be an attribute of
 * this YelpDataBST object.
 */
char** explode(const char *, const char *, int);
struct YelpDataBST* create_business_bst(const char* businesses_path, const char* reviews_path);
struct Business* get_business_reviews(struct YelpDataBST* bst, char* name, char* state, char* zip_code);                   
struct YelpDataBST * create_leaf(char *, int, int, int, const char* , const char*);
struct YelpDataBST * insert_tree(struct YelpDataBST *, struct YelpDataBST *);
struct YelpDataBST * tree_search_name(char *, struct YelpDataBST *);
void destroy_exp(char * *);
void destroy_business_bst(struct YelpDataBST* bst);
void destroy_business_result(struct Business* b);
int compare_locations(const void *a, const void *b);   // Qsort compare function
int compare_reviews(const void *a, const void *b);     // Qsort compare function



struct YelpDataBST* insert_tree(struct YelpDataBST * root, struct YelpDataBST * node){
	if(root == NULL){
		return node;
	}
	if(node == NULL){
		return root;
	}
	if(strcasecmp(node -> name, root -> name)  <= 0){   // go left
		root -> left = insert_tree(root -> left, node); 
	} else {  // go right
		root -> right = insert_tree(root -> right, node);  
	}
	return root;
}



struct YelpDataBST * tree_search_name(char * name, struct YelpDataBST * root){
	if (root == NULL){
		return NULL;
	}
	if(strcasecmp(name, root -> name) == 0){
	 	return root; 
	}
    if(strcasecmp(name, root -> name) < 0){  // go left
    	return tree_search_name(name, root -> left);
    }
    return tree_search_name(name, root -> right);
}

struct YelpDataBST * create_leaf(char * n, int l, int b, int c, const char * x, const char * y){
	struct YelpDataBST* leaf = malloc(sizeof(struct YelpDataBST));
	leaf -> name = strdup(n);    //name
	leaf -> loc = l;
	leaf -> rev1 = b;
    leaf -> rev2 = c;
    leaf -> p1 = x;
    leaf -> p2 = y;
    leaf -> left = NULL;
    leaf -> right = NULL;   //initialization
    return leaf;
}

void destroy_exp(char * * a){   // free all the array
    int i;
    for(i = 0; i < 7; ++i)
    { 
		free(a[i]);
	}
    free(a);
}

char** explode(const char * str, const char* delims, int ct){
	int ind = 0;
	int Ind = 0;
	int last = 0;
	int l;   //length
	char* * arr = malloc(ct * sizeof(char*));
	
	for(ind = 0; str[ind] != '\0'; ind ++){
		if(strchr(delims, str[ind]) || (str[ind] == '\0')){  // string search gets the str[ind] from delims
			l = 1 + ind - last;
			arr[Ind] = (char*) malloc(l);    //  l length
			memcpy(arr[Ind], str + last, l - 1); // copy str+last to arr[Ind]
			*(arr[Ind] + ind - last) = '\0';   // new string, set the end
			last = ind + 1;
			Ind++;
		}
	}
	
	l = 1 + ind - last;
	arr[Ind] = malloc(l * sizeof(char));    //  l length
	memcpy(arr[Ind], str + last, l - 1); // copy str+last to arr[Ind]
	* (arr[Ind] + l - 1) = '\0';   // new string, set the end
	return arr;
}

int compare_locations(const void *a, const void *b){
	struct Location * loc1 = (struct Location *)a;
    struct Location * loc2 = (struct Location *)b;
    // compare the loctaions step by step
    int compare_result = strcasecmp(loc1 -> state, loc2 -> state);
    if (compare_result != 0){
    	return compare_result;
    }
    compare_result = strcasecmp(loc1 -> city, loc2 -> city);
    if (compare_result != 0){
    	return compare_result;
    }
    compare_result = strcasecmp(loc1 -> address, loc2 -> address);
    if (compare_result != 0){
    	return compare_result;
    }
    compare_result = strcasecmp(loc1 -> zip_code, loc2 -> zip_code);
    if (compare_result != 0){
    	return compare_result;
    }
    compare_result = loc1 -> num_reviews - loc2 -> num_reviews;
    return compare_result;
}

int compare_reviews(const void *a, const void *b){
    struct Review * rev1 = (struct Review *)a;
    struct Review * rev2 = (struct Review *)b;
    int compare_result = rev1 -> stars - rev2 -> stars;
    if(compare_result != 0){ 
		return -compare_result;
	}
    compare_result = strcasecmp(rev1 -> text, rev2 -> text);
    return compare_result;
}



struct YelpDataBST* create_business_bst(const char* businesses_path, const char* reviews_path){
	FILE* fpr = fopen(reviews_path,"r");
	FILE* fpb = fopen(businesses_path,"r");
	
	if(fpb == NULL){
		if(!fpb){
			fprintf(stderr, "Failed to open file '%s'\n", businesses_path);
			return NULL;
		}
	}
	if(fpr == NULL){
		if(!fpr){
			fprintf(stderr, "Failed to open file '%s'\n", reviews_path);
			return NULL;
		}
	}

	struct YelpDataBST* tree = NULL;
	char str[2048];
	char str_r[10240];
	char** exstr = NULL;
	char** exstr_r = NULL;

	char* b_id = NULL;  // business id
	char* b_name = NULL; // business name
	char* id = NULL;
	int loc = 0;
	int rev2 = 0;
	int rev1 = 0;
	
	while(fgets(str, 2048, fpb) != NULL){  // save strings in fpb into str   
		exstr = explode(str, "\t", 7);    // explode tab out, get business id and name
		b_id = exstr[0];
		b_name = exstr[1];     //  1
		
		fseek(fpr, rev2, SEEK_SET);   //seek the start of file
		rev1 = ftell(fpr);            // 2 return the start of file  2
		fgets(str_r, 10240, fpr);
		exstr_r = explode(str_r, "\t\n", 7); // explode tab and LF
		id = exstr_r[0];
		fseek(fpr, rev1, SEEK_SET);
		while(strcmp(id, b_id) == 0 && !feof(fpr)){
            destroy_exp(exstr_r);
            fgets(str_r, 10240, fpr);
            exstr_r = explode(str_r, "\t\n", 7);
            id = exstr_r[0];
            if(strcmp(id, b_id) == 0){
                rev2 = ftell(fpr); //Input4
            }
        }
		tree = insert_tree(tree, create_leaf(b_name, loc, rev1, rev2, businesses_path, reviews_path));
		loc = ftell(fpb); // 3
		destroy_exp(exstr);
        destroy_exp(exstr_r);
	}
	fclose(fpb);
	fclose(fpr);
	return tree;
}
/* This function reads the two files and creates an index that can be used
 * to search the data and quickly retrieve the reviews.  You must *not* store
 * all of the review text in memory.  Your structure should store the file
 * offsets where the review text can be found.
 *
 * businesses_path - path to the businesses.tsv file provided for this assignment.
 * reviews_path - path to the businesses.tsv file provided for this assignment.
 *     When running on ecegrid, you can pass the following:
 *        /home/shay/a/ece264p0/share/yelp_data/businesses.tsv
 *        /home/shay/a/ece264p0/share/yelp_data/reviews.tsv
 *
 * DO NOT COPY THOSE FILES TO YOUR HOME DIRECTORY.  PLEASE ACCESS THEM USING
 * THOSE PATHS.  THESE ARE LARGE FILES AND WE DO NOT WANT TO FILL THE DISK
 * WITH MULTIPLE COPIES OF THEM.
 */

struct Business* get_business_reviews(struct YelpDataBST* bst, char* name, char* state, char* zip_code){
    FILE * fpb = fopen(bst -> p1, "r");
    FILE * fpr = fopen(bst -> p2, "r");
	if(fpb == NULL){
		if(!fpb){
			fprintf(stderr, "Failed to open file '%s'\n", bst -> p1);
			return NULL;
		}
	}
	if(fpr == NULL){
		if(!fpr){
			fprintf(stderr, "Failed to open file '%s'\n", bst -> p2);
			return NULL;
		}
	}
    
    struct Business * result = NULL;
    struct YelpDataBST * possible_node = tree_search_name(name, bst);
    if(possible_node == NULL){ // NULL node
		fclose(fpb); 
		fclose(fpr);
		return NULL; 
	}
    char * * exstr1 ;  
    char str[2048];
    int i = 0;
    int num_i = i;
    uint32_t arr_j[1024];
    uint32_t j = 0;
    
    while(possible_node != NULL){  //Get how many blocks needed for locs and revs
   	 	fseek(fpb, possible_node -> loc, SEEK_SET);   // find the loc number
   		fgets(str, 2048, fpb);                        // get loc string
   		exstr1 = explode(str, "\t", 7);      // use string to get (explode tab)
        char * b1_state = exstr1[4];         // the array[4] is state
        char * b1_zip = exstr1[5];           //array [5] is zip
        int ct = 0;
        int cd = 0;
        
        if(state == NULL && zip_code == NULL) {cd = 1;}
        else if(state == NULL && (strcasecmp(zip_code, b1_zip) == 0)) {cd = 1;}
        else if(zip_code == NULL && (strcasecmp(state, b1_state) == 0)){cd = 1;}
        else if(state != NULL && zip_code != NULL && (strcasecmp(state, b1_state) == 0) && (strcasecmp(zip_code, b1_zip) == 0)) {cd = 1;}
        
        if(cd){
            ct = 1;
            int bytes = possible_node -> rev1;
            while(bytes < possible_node -> rev2){
                fseek(fpr, bytes, SEEK_SET);
                char storer[10240];
                fgets(storer, 10240, fpr);
                bytes = ftell(fpr);
                j++;
            }
        }
        possible_node = possible_node -> left;
        possible_node = tree_search_name(name, possible_node);
        if(ct){
            arr_j[i] = j;
            i++;
            num_i = i;
        } 
        destroy_exp(exstr1);   // destroy extra array
        j = 0;
    }
    
    if(i == 0)
    { fclose(fpb); fclose(fpr); return NULL;}
    
    //Malloc for locs and revs
    struct Location * locs = malloc(i * sizeof(struct Location)); //2
    struct Review * revs = NULL;
    i = 0;
    possible_node = tree_search_name(name, bst);
    while(possible_node != NULL){
        fseek(fpb, possible_node -> loc, SEEK_SET);
        fgets(str, 2048, fpb);
        exstr1 = explode(str, "\t", 7);
        char * b_ad = exstr1[2]; //Locs 1
        char * b_city = exstr1[3];//Locs 2
        char * b_state = exstr1[4];//Locs 3
        char * b_zip = exstr1[5];//Locs 4
        int ct2 = 0;
        int ind = 0;
        
        int cd1 = 0;
        if(state == NULL && zip_code == NULL){cd1 = 1;}
        else if(state == NULL && strcasecmp(zip_code, b_zip) == 0){cd1 = 1;}
        else if(zip_code == NULL && strcasecmp(state, b_state) == 0){cd1 = 1;}
        else if(state != NULL && zip_code != NULL && strcasecmp(state, b_state) == 0 && strcasecmp(zip_code, b_zip) == 0){cd1 = 1;}
        if(cd1){
            ct2 = 1;
            //Locs input (revs)
            revs = malloc(arr_j[i] * sizeof(struct Review));
            int bytes = possible_node -> rev1;
            while(bytes < possible_node -> rev2){
                fseek(fpr, bytes, SEEK_SET);
                char str_rev[10240];
                fgets(str_rev, 10240, fpr);
                char * * exp_revs = explode(str_rev, "\t\n", 7);
                //Create revs
                revs[ind].text = strdup(exp_revs[5]);
                revs[ind++].stars = (uint8_t)(exp_revs[1][0] - '0');
                bytes = ftell(fpr);
                destroy_exp(exp_revs);
            }
        }
        possible_node = possible_node -> left;
        possible_node = tree_search_name(name, possible_node);
        if(ct2){
            //Create locs
            qsort(revs, arr_j[i], sizeof(struct Review), compare_reviews);
            locs[i].address = strdup(b_ad);
            locs[i].city = strdup(b_city);
            locs[i].state = strdup(b_state);
            locs[i].zip_code = strdup(b_zip);
            locs[i].reviews = revs;
            locs[i].num_reviews = arr_j[i];
            i++;
        }
        destroy_exp(exstr1);
    }
    
    result = malloc(sizeof(struct Business));
    result -> name = strdup(name);
    qsort(locs, num_i, sizeof(struct Location), compare_locations);    // sort by name
    result -> locations = locs;
    result -> num_locations = num_i;
    fclose(fpb);
    fclose(fpr);
    return result;                                 	
}
/* get_business_reviews(...) should return a pointer to a Business struct object
 * on the heap.  That object will include links to the individual locations.
 * For example, if "McDonald's" is the business, then there would be thousands
 * of locations.  Each Location struct object in turn contains links to
 * reviews of that location.
 *
 * bst - the object returned by create_business_bst(..)
 * name - name of the business to search for (e.g., "McDonald's"); search is
 *     case insensitive.
 * state - two-letter (uppercase) state code to filter locations by, or NULL
 *     to include all states.
 * zip_code - five digit ZIP code to filter locations by, or NULL to include
 *     all ZIP codes.
 *
 * Locations must be sorted by state >> city >> address.
 *
 * Reviews must be sorted by star rating (descending) >> text of review.
 *
 * Matching and sorting of names, cities, and states must be case-insensitive.
 * You may use functions from strings.h for that, if you wish.
 *
 * Note: This function should not result in a scan of the entire reviews.tsv.
 * It should use the offsets stored in your structure to go right to the
 * address data and reviews for the given business name, without looking at any
 * data in the file about other businesses.
 */


void destroy_business_bst(struct YelpDataBST* bst){
	if(bst == NULL){
		return;
	}
	destroy_business_bst(bst -> left);   // to the end of left
	destroy_business_bst(bst ->right);   // the end right
    free(bst -> name);
    free(bst);
}
/* Deallocate all memory allocated for the object returned by
 * create_business_bst(..) and close the files. */

void destroy_business_result(struct Business* b){
	free(b -> name);
	int ind, ind2;
	for(ind = 0; ind < b -> num_locations; ind++){   // inside business tree
		free(b -> locations[ind].address);
		free(b -> locations[ind].city);
        free(b -> locations[ind].state);
        free(b -> locations[ind].zip_code);
        for(ind2 = 0; ind2 < b -> locations[ind].num_reviews; ind2++){   // inside review
            free(b -> locations[ind].reviews[ind2].text);
        }
        free(b -> locations[ind].reviews);
	}
	free(b -> locations);
    free(b);
}
/* Deallocate all heap memory tied to an object returned by
 * get_business_reviews(..). */
 
 
 
 
 
 
 
 
 
 
 
 
 
