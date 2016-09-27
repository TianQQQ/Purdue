



N = 80
fib = zeros(N)
roots1 = zeros(Complex{Float64}, N)
roots2 = zeros(Complex{Float64}, N)
fib[1] = 1;
roots1[1] = 1 # avoid reporting these equal
fib[2] = 1;
roots1[2] = 1 # because we don't compute them
for i=3:N
    fib[i] = fib[i-2] + fib[i-1]
    r = myroots([fib[i]; -2*fib[i-1]; fib[i-2]])
    roots1[i] = r[1]
    roots2[i] = r[2]
end
bign = findfirst(roots1.==roots2) # finds the first zero
