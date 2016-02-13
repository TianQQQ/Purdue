
#os.access(Path, Attribute) (string file path, os.R_OK os.W_OK os.X_OK)
#   if os.access(file, os.R_OK | os.X_OK):
#       print ("{} is both readable and executable!".format(file))

# os.path.exists(path) os.path.isfile(path) os.path.isdir(path)

# FileObject = open(FileName, Mode)
#                                "r" "w" "a" open file and append to end for writing
# fileobj.close()

# with open('txtfile.txt', 'r') as myFile:
#     all_lines = myFile.readlines()
# for line in all_lines:
#     do something

from pprint import pprint as pp
# Create a large dictionary:
days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']
occurrences = [32, 12, 67, 21, 9, 45, 83]
dict_example = {day: occurrence for day, occurrence in zip(days, occurrences)}
# Regular Printing
print(dict_example)
# Pretty Printing
pp(dict_example) # print in maps way
#{'Thursday': 21, 'Wednesday': 67, 'Friday': 9, 'Tuesday': 12, 'Saturday': 45, 'Monday': 32, 'Sunday': 83}
#{'Friday': 9,
# 'Monday': 32,
# 'Saturday': 45,
# 'Sunday': 83,
# 'Thursday': 21,
# 'Tuesday': 12,
# 'Wednesday': 67}
