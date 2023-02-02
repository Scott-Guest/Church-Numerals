# ChurchNumerals

A Haskell implementation of the natural numbers under the Church encoding. 

## Proof of Equivalence
We wish to show that Church and Nat are isomorphic. To do so, it suffice to show that the implemented functions
```
churchToNat :: Church -> Nat
natToChurch :: Nat -> Church
```
satisfy the (extensional) equalities
```
natToChurch . churchToNat == id
churchToNat . natToChurch == id
```
The first equality is trivial, and the second follows from Wadler's "Theorems for Free" applied to the Church type. QED
