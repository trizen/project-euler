
// Author: Daniel "Trizen" Șuteu
// License: GPLv3
// Website: https://github.com/trizen

// https://projecteuler.net/problem=78

// Runtime: 0.161s

package main

import "fmt"

func main() {
    n := 1
    P := []int{1}

    for {
        i := 0
        q := 1
        P = append(P, 0)

        for q <= n {

            if i%4 > 1 {
                P[n] += -P[n-q]
            } else {
                P[n] += P[n-q]
            }

            P[n] %= 1000000
            i += 1

            j := i/2 + 1
            if i%2 != 0 {
                j *= -1
            }

            q = j * (3*j - 1) / 2
        }

        if P[n] == 0 {
            break
        }
        n += 1
    }

    fmt.Println(n)
}
