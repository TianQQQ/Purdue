#include "answer07.h"
#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>

#define bmp_magic_number 0x21343632
#define ECE264_IMAGE_MAGIC_NUMBER 0x21343632
#define ArraySize(ARR) (sizeof(ARR) / sizeof(ARR[0]))
#define FALSE 0
#define TRUE 1

static int checkValid(ImageHeader * header);
//#define TEST
#ifdef TEST

int main (int argc, char ** argv)
{
	int ret = EXIT_SUCCESS; // unless otherwise noted
    const char * in_filename = argv[1];
    const char * out_filename = argv[2];

    // Read the file
    Image * im = Image_load(in_filename);
    if(im == NULL) {
	fprintf(stderr, "Error: failed to read '%s'\n", in_filename);
	return EXIT_FAILURE;
    }

    // Invert pixel intensity
    int n_pixels = im->width * im->height;
    int ind;
    for(ind = 0; ind < n_pixels; ++ind)
	im->data[ind] = 255 - im->data[ind];

    // Write out a new file
    if(!Image_save(out_filename, im)) {
	fprintf(stderr, "Error attempting to write '%s'\n", out_filename);
	ret = EXIT_FAILURE;
    }

    Image_free(im); // a memory leak until you write this function

    return ret;
}
#endif

//static int BMP_checkValid(BMP_Header * header);
//static void BMP_printHeader(BMP_Header * header);

/**
 * Loads an ECE264 image file, returning an Image structure.
 * Will return NULL if there is any error.
 *
 * Hint: Please see the README for extensive hints
 */
Image * Image_load(const char * filename)  //为什么是直接  Image? 
{
	FILE * fp = NULL;
	size_t read;      // size_t is used to count the number 
	ImageHeader header;
    Image * tmp_im = NULL, * im = NULL;
	int err = FALSE;
	
 	if(!err) { // Open filename
		fp = fopen(filename, "rb");
		if(!fp) {
	  		fprintf(stderr, "Failed to open file '%s'\n", filename);
	 		err = TRUE;
		}
    }

    if(!err) { // Read the header
		read = fread(&header, sizeof(ImageHeader), 1, fp);
		if(read != 1) {
	    	fprintf(stderr, "Failed to read header from '%s'\n", filename);
	    	err = TRUE;
		}
    }

  	if(!err){
   		 if(!checkValid(&header)) {
  			    fprintf(stderr, "Invalid header in '%s'\n", filename);
		      	err = TRUE;
 		   }
	  }

	if(!err) { // Allocate Image struct
		tmp_im = malloc(sizeof(Image));	
		tmp_im->comment = NULL;
		tmp_im->data = NULL;		
		if(tmp_im == NULL) {
	 		fprintf(stderr, "Failed to allocate im structure\n");
			err = TRUE;
		} 
    }
    
    if(!err) { // Init the Image struct
		tmp_im->width = header.width;
		tmp_im->height = header.height;
		tmp_im->comment = malloc(sizeof(char*) *header.comment_len);
		if(tmp_im->comment == NULL) {
	    	fprintf(stderr, "Failed to allocate comment\n");
	   		err = TRUE;
	   	}
	}

	if(!err){  //make sure read the whole comment
		read = fread(tmp_im->comment, sizeof(char), header.comment_len, fp);
		if( read != header.comment_len || tmp_im->comment[header.comment_len-1] != '\0'){ //comment does not end with null byte
			fprintf(stderr, "comment does not end with null byte\n");
			err = TRUE;
		}
	}

  	if(!err){  //initial the tmp_im data(array)
    	tmp_im-> data = malloc(sizeof(uint8_t) * header.width * header.height);
    	if(tmp_im-> data == NULL){
      		fprintf(stderr, "Fail to allocate memory to data\n");
     		err = TRUE;
   		}
	}

	if(!err){  // make sure read entire data(array)
		read = fread(tmp_im->data, sizeof(uint8_t), header.width * header.height, fp);
		if(read != header.width * header.height){
			fprintf(stderr, "Could not read all image data\n");
			err = TRUE;
		}
	}

    if(!err) { // We should be at the end of the file now
 		if(fgetc(fp) != EOF){
   			fprintf(stderr, "Have not reach the end of file\n");
   			err = TRUE;
   		}
    }


    if(!err) { // We're winners... 
	im = tmp_im;  // bmp will be returned
	tmp_im = NULL; // and not cleaned up
    }

	
    Image_free(tmp_im);
    
    if(fp){
   		 fclose(fp);
    }

	
	if(err){
		return NULL;
	}else{
		return im;
	}
 	  


}
	
/**
 * Save an image to the passed filename, in ECE264 format.
 * Return TRUE if this succeeds, or FALSE if there is any error.
 *
 * Hint: Please see the README for extensive hints
 */
	

int Image_save(const char * filename, Image * image)
{
  FILE * fp = NULL;
  
  int len = strlen(image->comment) +1;


  fp = fopen(filename, "wb");
  ImageHeader header;
  if(fp == NULL){
      fprintf(stderr, "Failed to open file '%s'\n",filename);
      return 0;
  }
  else{
      header.magic_number = 0x21343632;
      header.width = image-> width;
      header.height = image-> height;
      header.comment_len = len;
	
      fwrite(&header, sizeof(ImageHeader),1, fp);
      fwrite(image->comment, len * sizeof(char), 1,fp);
      fwrite(image->data, sizeof(uint8_t), header.width * header.height, fp);
  }
	
  fclose(fp);
  return 1;
}

/**
 * Free memory for an image structure
 *
 * Image_load(...) (above) allocates memory for an image structure. 
 * This function must clean up any allocated resources. If image is 
 * NULL, then it does nothing. (There should be no error message.) If 
 * you do not write this function correctly, then valgrind will 
 * report an error. 
 */
void Image_free(Image * image){
    // Cleanup
    if(image != NULL) {
	free(image->comment); // Remember, you can always free(NULL)
	free(image->data);
	free(image);
    }
}
/**
 * Performs linear normalization, see README
 */
void linearNormalization(int width, int height, uint8_t * intensity){
	int max = 0;
	int min = 255;
	int ind;
	
	for(ind = 0; ind < width * height; ind ++){
		if(intensity[ind] > max) {
			max = intensity[ind];
		}
		if(intensity[ind] < min){
			min = intensity[ind];
		}
	}
	
	for(ind = 0; ind < width * height; ind++){
		intensity[ind] = (intensity[ind] - min) * 255.0 /(max - min);
	}
}

static int checkValid(ImageHeader * header)
{
  if (header->magic_number != ECE264_IMAGE_MAGIC_NUMBER) return 0;

  if (header->width == 0) return 0;  //function 外调用 

  if (header->height == 0) return 0;
	
  if (header->comment_len == 0) return 0;

  return 1;
}




















