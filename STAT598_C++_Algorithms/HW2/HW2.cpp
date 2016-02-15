//For HW2, Complete the following functions.
//You can write additional functions, but please do not modify the given functions.

void selection_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
	for (int i = 0; i < (n - 1); i++) {
		for (int j = (i + 1); j < n; j++) {
			int n = 0;
			int m = 0;
			if (p[i] < p[j]) {
				n = p[i];
				m = p[j];
				p[i] = m;
				p[j] = n;
			}
		}
	}
	cout << p[] << endl;
	return 0;
}
void insertion_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
	int i, j, temp;
	for (i = 1; i < n; i++) {
		j = i;
		while (j > 0 && p[j - 1] < arr[j]) {
			temp = p[j];
			p[j] = p[j - 1];
			p[j - 1] = temp;
			j--;
		}//end of while loop
		//print_array(arr, 5);
	}//end of for loop
}
void bubble_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}
void quick_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}
void merge_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}
void heap_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}
void radix_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}
void counting_sort(int p[], int n) {
	//Sort the array p[0], ..., p[n - 1] to descending order.
}
void Print_nRooks(int n) {
	//Print all solutions of nRooks problem to the screen.
}
void Queens_Rooks(int n) {
	//Print all solutions of Queens and Rooks problem to the screen.
}
void Max_Consecutive_Numbers(int p[], int n) {

}
void Max_Draw_Down(int p[], int n) {

}
void compare(const char *a, const char *b) {

}
void add(const char *a, const char *b, char * dist) {

}
void subtract(const char *a, const char *b, char * dist) {

}
void multiply(const char *a, const char *b, char * dist) {

}
void divide(const char *a, const char *b, char * dist) {

}
void print_factorial(int n) {
	//In this problem, print n! to the screen.
	//You should expect n to be as large as 100.
}
void print_exponential(int N) {
	//In this problem, print the first N digits of e to the screen.
}
void print_pi(int N) {
	//In this problem, print the first N digits of pi to the screen.
}

void main() {
	int p[] = { 4,1,3,6,2 };
	int n = 5;
	selection_sort(p[], n);
	insertion_sort(p[], n);
	system("Pause");
	return 0;
}