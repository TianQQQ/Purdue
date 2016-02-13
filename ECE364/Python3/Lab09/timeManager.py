__author__ = 'ee364d08'

try:
    from timeDuration import *
except ImportError:
    print("Unable to import 'timeDuration'. Create an Empty Python file with that name.")


def getTotalDuration(ex):
    f = open('Experiments.txt', 'r')
    lines = f.readlines()
    seconds = 0
    minutes = 0
    hours = 0
    for line in lines:
        if  line[4:16] == ex:
            minutes += int(line[23:25]) * (int(line[34]))
            seconds += int(line[26:28]) * (int(line[34]))
    minutes += int(seconds / 60)
    hours += int(minutes / 60)
    minutes %= 60
    seconds %= 60
    return Duration(hours,minutes,seconds)


def rankExperiments(*args):
    a = []
    for ex in args:
        totalDuration = getTotalDuration(ex)
        a.append((totalDuration.hours, totalDuration.minutes, totalDuration.seconds))
    a.sort()
    b = []

    for x in range(0, len(a)):
        for i in range(0,len(args)):
            totalDuration = getTotalDuration(args[i])
            if (totalDuration.hours, totalDuration.minutes, totalDuration.seconds) == a[-(x+1)]:
                b.append(args[i])
    return b