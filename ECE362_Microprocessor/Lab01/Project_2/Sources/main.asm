bcdb   org  $800  ; BCD to Binary Conversion Program
       ldaa bcdin ; (A) ? packed BCD input data
       anda #$f0 ; mask off lower nibble
       lsra
       tfr  a,b ; (B) = 8 * (upper nibble)
       lsra
       lsra ; (A) = 2 * (upper nibble)
       psha ; store temporarily on stack
       addb 1,sp+ ; (B) = (2 + 8) * (upper nibble)
       ldaa bcdin ; reload initial BCD data
       anda #$0f ; mask off upper nibble
       psha ; store temporarily on stack
       addb 1,sp+ ; (B) = 10 * (un) + (ln)
       stab binout ; store converted binary value
       stop
bcdin  fcb  $EA ; BCD input data
binout rmb  1 ; location to store converted binary
       end