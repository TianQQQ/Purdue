"""
`julia_check` is a subroutine useful for working with the Julia
set fract. The function
returns the number of steps that we can iterate the sequence
    z = zinput (from input)
    znext = z*z + c
until the maginitude of the value z becomes larger than two or
until we hit 256 steps.
"""


function julia_check(z,c)

  k = 0;
	while k < 256 && abs(z) < 2
		k = k + 1;
		z = z * z + c
	end
	print(z)
end
