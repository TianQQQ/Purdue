import matplotlib.pyplot as pyplot

def plotBarGraph(applicationlist):
    n = len(applicationlist)
    for i in range(1,n):
        data = applicationlist[i]     
        pos = [4+(i-1)*1.5, 10+(i-1)*1.5, 16+(i-1)*1.5, 22+(i-1)*1.5]
        if i==1:
            bar1 = pyplot.bar(pos, data, width=1.5, color='blue', align='center')
        if i==2:
            bar2 = pyplot.bar(pos, data, width=1.5, color='pink', align='center')
        if i==3:
            bar3 = pyplot.bar(pos, data, width=1.5, color='red', align='center')

    posi = [5.5, 11.5, 17.5, 23.5]
    names = applicationlist[0]

    pyplot.xticks(posi, names)
    pyplot.setp(pyplot.xticks()[1], rotation=15)
    pyplot.legend((bar1, bar2, bar3), ('1990', '2000', '2010'), loc=2)
    pyplot.ylabel('Number of Student Applications')

    pyplot.axis([0, 30, 0, 4500])
    pyplot.show()


def scatterPlot(x,y,z):
    
    pyplot.plot(x, y, color='blue', label = 'Pizza')
    pyplot.plot(x, z, color='red',linestyle = '--', marker='o',label = 'Chips and Fish')
    pyplot.xlabel('Year')
    pyplot.ylabel('Number of items eaten per year')
    pyplot.title('Consumption of fast food by Australian teenagers')
    pyplot.legend()
    pyplot.show()

def Piechart(x):
    labels = 'Germany', 'France', 'United Kingdom', 'Italy', 'Spain', 'Poland', 'All other countries'
    sizes = x
    colors = ['yellowgreen', 'gold', 'lightskyblue', 'lightcoral', 'red', 'darkred', 'yellow']
    pyplot.pie(sizes, labels=labels, colors=colors,autopct='%1.1f%%', shadow=True, startangle=90)
    pyplot.axis('equal')
    pyplot.legend(loc=2)
    pyplot.show()
    
def main():
    applicationlist = [['Biology','Engineering','Business','Social Work'],[3000, 4000, 2000, 1000], [1500, 2500, 3000, 1400], [800, 600, 4000, 1800]]
    year = [1975, 1980, 1985, 1990, 1995, 2000]
    pizza = [5, 18, 38, 60, 83, 83]
    fish = [100, 85, 93, 65, 50, 38]
    sizes = [16.6, 12.8, 12.3, 11.9, 9, 7.7, 29.7]
    plotBarGraph(applicationlist)
    scatterPlot(year,pizza,fish)   
    Piechart(sizes)
    
main()
