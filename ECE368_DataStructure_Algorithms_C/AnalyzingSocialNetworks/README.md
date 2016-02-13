# Analyzing-Social-Networks

1. Generation of a social network:


Social Network is a graph, where V is the set of vertices representing
users. Each vertex contains one profile. Accordingly, the graph contains number of vertices equal to the number of users/profiles.
￼A user profile has a unique User ID, followed by a set of eight attributes, representing: Age, Gender, Marital status, Race, Birth-place, Language, Occupation, and Income. Assume, all the eight attributes are represented as integers. In essence, a profile is a vector of eight attributes, plus a User ID field.
The attribute dataset for users will be provided in the text file called input.txt. More detail about this file is given on the last page.
In graph , E is the set of links/edges between vertices. An edge defines a friendship relationship between the vertices. The strength of friendship between
￼any two vertices/users (for example with IDs, a and b) is computed based on the friendship distance ( ) between the profiles of the two users. is computed
￼￼
based on the eight attributes of the profile vectors, say a ={a(1), a(2), ..., a(8)} and b
={b(1), b(2), ..., b(8)}, as described in the following three steps:
i. First compute the pair-wise un-normalized Euclidean Distance
between nodes a and b as: 8
ULab
￼∑ i=1
UL = (a(i)−b(i))2
L
max
many such values are there?).
Lab =1−(ULab /Lmax)
ULab
which is the maximum over ALL the pair-wise un-
ii. Then find
normalized Euclidean distance values, i.e. , (can you guess how
ab
iii. Subsequently, compute the Friendship Distance ￼ between a and b as follows:
Note, 0 ≤ Lab ≤ 1. Also, the value of Lab should be truncated (not rounded up or
Next, you create an edge between nodes a and b if is greater than a given
down) to two decimal positions.
threshold δ. For your project, at the run time, we will provide two values for
￼threshold, ￼ and ￼ , with small and large values, representing a highly active social
group (dense graph with many edges) and less socially active group (sparse graph with less edges), respectively.
Once, an edge is created, you must keep its value attached to the edge. In this way you will have a weighted graph, needed for the second part of the project.
￼Note: Do not include any self-edges in your graph.
An example, of a weighted social network (graph G) for six users with their profile dataset is given below. NOTE, the first value in each line is the USER ID. It is NOT
Example:
an attribute used for computing the value .
￼1, 39, 1, 6, 1, 1, 1, 3, 0
2, 33, 1, 6, 2, 1, 1, 10,144
3, 40, 2, 4, 1, 1, 1, 6, 830
4, 10, 1, 6, 1, 1, 1, 1, 0
5, 21, 2, 6, 1, 1, 1, 3, 992
6, 39, 1, 4, 1, 1, 1, 6, 67
￼The above graph is created using a similarity threshold value of ‘δ = 0.3’ among the 6 profile vectors of attributes given above. In this example, for clarity, each edge has
been labeled with two values: UL / L . You can verify that for this example, L = ab ab max
992.16. In this example as we have selected the value of δ = 0.3, therefore, if > δ
= 0.3, between any two nodes, we create an edge between those nodes and assign it the corresponding weight.
For part 2 of this project you only need to work with this weight.
Lab


￼
2. Analysis of the social networks:

Using the two weighted graphs (Dense and Sparse social networks) generated in Step 1, for the given value of thresholds, ￼ and ￼ , you are required to implement
the following six queries to determine various social networking parameters for both the Dense and the Sparse Network.
**************************************************************************** 
Query 1: For a given user ID, called the source node, (provided in the
input.txt file), find the ID(s) of those nodes which has(have) the minimum path
length among all the Shortest Source-Destination paths, computed based on using Dijkstra’s algorithm. Also, print the value of this path.
Lab
Value of the shortest path length, Sorted Node ID(s)
Expected Output of Query 1:
****************************************************************************
Query 2: For the user ID (source node) given in Query 1, and another threshold parameter alpha, ￼ , (also provided in the input.txt file), find the number of nodes such that their shortest distance from the source node is less than
(Do not print their IDs).
￼Number of nodes
****************************************************************************

Query3: For the same user ID (given in Query 1), find the total number and the ID(s) of user(s) who are directly connected to that user (that is, the immediate neighbors)
Number of immediate neighbors, Sorted ID(s) of immediate nodes
Expected Output of Query 3:
****************************************************************************

Query 4: For the same user ID (given in Query 1), find the total number and the ID(s) of user(s) who are exactly 2-hops away from that user (i.e. neighbors of the immediate neighbors). These can be called second-level friends.
Number of exactly 2-hops away numbers, Sorted ID(s) of these 2-hop nodes
Expected Output of Query 4:
**************************************************************************** 

Query 5: Find the average degree of a node (average number of immediate neighboring friends per user/node).
Average of number of immediate nodes
**************************************************************************** 

Query 6: Determine the average number of second-level friends (exactly 2-hops away neighbors) per user/node.
Expected Output of Query 5:
Average of number of 2-hops away nodes
Note: Also, the value of averages in Queries 5 and 6 should be truncated (not rounded up or down) to two decimal positions.
Expected Output of Query 2:
￼Input File Format (input.txt):
• Number of users, Value of , Value of , Node/user ID for Query 1, value of
￼￼￼•
Profile records for all the users (note, the first parameter of each record represents the user ID)
For both Dense and Sparse networks, the output of Queries 1 -6 must be directed to an output file (output.txt) with each answer printed on one line.

￼￼
