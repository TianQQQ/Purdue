using Plots
plotly(size=(500,500)) # use plotly for zooming and 500-by-500 for equal size
theta = linspace(0, 2*pi, 10000)
r = sqrt(2)
x = 2. + r*cos(theta)
y = 1 + r*sin(theta)
plot(x,y)

using Plots
plotly(size=(500,500)) # use plotly for zooming and 500-by-500 for equal size
theta = linspace(0, 2*pi, 10000)
r = sqrt(3.5)
x = 2.5 + r*cos(theta)
y = r*sin(theta)
plot!(x,y)
