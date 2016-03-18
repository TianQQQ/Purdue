__author__ = 'ee364d08'


import sys,os

def main():
    try:
        f = open(sys.argv[1])
        lines = f.readlines()
        rows = []
        for line in lines:
            rows.append(line.split())
        #print(rows)
        for row in rows:
            string = ''
            tot = 0
            count = 0
            for num in row:
                try:
                    tot = tot + int(num)
                    count += 1
                except ValueError:
                        string = string + num + ' '
            if(tot):
                print(str('%.3f' %(tot / count) + ' ' + string ))
            else:
                print(string)
    except IOError as e:
        print(sys.argv[1], "is not a readable file.")
    except IndexError:
        print("Usage: Pparse.py [filename];")
    else:
        pass
    finally:
        pass

if __name__ == "__main__":
    main()