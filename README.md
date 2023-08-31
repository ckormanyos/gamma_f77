gamma_f77
==================

<p align="center">
    <a href="https://github.com/ckormanyos/gamma_f77/actions">
        <img src="https://github.com/ckormanyos/gamma_f77/actions/workflows/gamma_f77.yml/badge.svg" alt="Build Status"></a>
    <a href="https://godbolt.org/z/Y3zdd6zd6" alt="godbolt">
        <img src="https://img.shields.io/badge/try%20it%20on-godbolt-green" /></a>
</p>

gamma_f77 implements the real-valued Gamma function in quadruple-precision using
the classic `Fortran77` language.

## Mathematical Background

The gamma function $\Gamma\left(z\right)$ is the complex-valued extension
of the well-known integer factorial function.

For $\mathbb{Re}\left(z\right) > 0$, $\Gamma(z)$ is defined by

$$\Gamma(z)=\int_{0}^{\infty}t^{z-1} e^{t} dt\text{,}$$

$\Gamma(z)$ has a value of complex-infinity at the origin and also
has poles at integer values along the negative real axis.

Reflection is given by

$$ \Gamma(-z)= \frac{\pi}{z\Gamma(z)\sin(\pi z)}\text{.}$$

Reccurence is given by

$$ \Gamma(z+1)= z\Gamma(z)\text{.}$$

## Calculation Method

The real-valued gamma function, $\Gamma\left(x\right)$
can be readily calculated using a series expansion
for its reciprocal near the origin.
Large arguments valued greater than one use recurrence.
For negative argument, the function value for the corresponding
positive-valued argument is first calculated and the value
for negative argument is obtaind via reflection.

Consider the series expansion of the reciprocal of the gamma function
near the origin

$$ \frac{1}{\Gamma(z)}\approx \sum_{k=1}^{n} a^{k} z^{k}\text{.}$$

In the subroutine `GAMMA` in Sect. 3.1.5 on pages 49-50 of [1],
this series expansion is given to $26$ terms. These are used
in a series calculation of $\Gamma\left(x\right)$ for double-precision,
real-valued $x$ using the `Fortran77` data type `REAL*8`.
Further information on this coefficient expansion can be found
in Sect. 6.1.34 of [2], in Sect. 5.7.1 of [3]
and in additional references therein.

## Quadruple-Precision Implementation

In this repository, the series calculation mentioned above has been
expanded (via computer algebra) to $48$ terms having precision
of $51$ decimal digits. With this coefficient list,
it is possible to reach the quadruple-precision of `Fortran77`'s `REAL*16`.
These higher-precision coefficients are listed in the table `G` in the
[source code](https://github.com/ckormanyos/gamma_f77/blob/main/gamma.f).

See also
[Wolfram Alpha(R)](https://www.wolframalpha.com/input?i=Series%5B1%2FGamma%5Bz%5D%2C+%7Bz%2C+0%2C+3%7D%5D)
for brief mathematical insight into the fascinating
series expansion of the reciprocal of the gamma function near the origin.

The implementation uses the `gfortran` dialect that is available in `g++`.

## Test-Run and CI

The test-run computes $9$ gamma values
for positive arguments at

$$x = 1.11, 2.21, 3.31, {\ldots} 9.91\text{.}$$

Negative reflection is tested at

$$x=-4.56\text{.}$$

Integral-valued argument is checked for

$$x=18\text{,}$$

which is used to compute $\Gamma[18]$, the result of which
is expected to be equal to the integral factorial

$$17 ! = 355,687,428,096,000 \text{.}$$

CI runs on Ubuntu and MacOS using `g++`.
Correct numerical results are verified on the OS-level
up to the full $33$ decimal digit precision using `grep`.

The program can also be compiled and executed at this
[short link](https://godbolt.org/z/Y3zdd6zd6)
to [godbolt](https://godbolt.org).

## References

[1] Shanjie Zhang and Jianming Jin, _Computation_ _of_ _Special_ _Functions_,
Wiley, 1996, ISBN: 0-471-11963-6, LC: QA351.C45

[2] M. Abramowitz and I.A. Stegun, _Handbook_ _of_ _Mathematical_ _Functions_,
9th Printing, Dover Publications, 1970.

[3] F.W.J. Olver, D.W. Lozier, R.F. Boisvert and C.W. Clark,
_NIST_ _Handbook_ _of_ _Mathematical_ _Functions_,
Cambridge University Press, 2010.
