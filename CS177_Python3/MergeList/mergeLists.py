def mergeLists(list1,list2):
    newlist = []
    for i in range(len(list1)):
        newlist.append(list1[i])
    for i in range(len(list2)):
        newlist.append(list2[i])
    newlist.sort()
    return newlist

def main():
    print("\nOutput after merging: ",mergeLists([1, 5, 10, 27],[3, 4, 6, 12]))
main()
