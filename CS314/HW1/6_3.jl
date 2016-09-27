using Images

re = linspace(-1.75,1.75,20)
imag = linspace(-1.75,1.75,20)


nxpts = 20
nypts = 20
max = 0
Z = zeros(nypts, nxpts)
for jj=1:nypts
    for ii=1:nxpts
        Z[jj,ii] = sqrt(re[ii] ^ 2 + imag[jj] ^ 2)
    end
end

grayim(Z/maximum(Z))

#using FileIO
#using ImageMagick
#save("juliaset.png", Z/maximum(Z))
