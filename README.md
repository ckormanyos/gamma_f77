gamma_f77
==================

<p align="center">
    <a href="https://github.com/ckormanyos/gamma_f77/actions">
        <img src="https://github.com/ckormanyos/gamma_f77/actions/workflows/gamma_f77.yml/badge.svg" alt="Build Status"></a>
    <a href="https://codecov.io/gh/ckormanyos/gamma_f77" > 
        <img src="https://codecov.io/gh/ckormanyos/gamma_f77/graph/badge.svg?token=rn9o8UoMRm"/></a>
    <a href="https://github.com/ckormanyos/gamma_f77/blob/master/LICENSE">
        <img src="https://img.shields.io/badge/license-BSL%201.0-blue.svg" alt="Boost Software License 1.0"></a>
    <a href="https://godbolt.org/z/xPWhqab9z" alt="godbolt">
        <img src="https://img.shields.io/badge/try%20it%20on-godbolt-green" /></a>
</p>

`ckormanyos/gamma_f77` implements the real-valued Gamma function
in quadruple-precision using the classic `Fortran77` language.

## Mathematical Background

The gamma function $\Gamma\left(z\right)$ is the complex-valued extension
of the well-known integer factorial function.

For $\mathbb{Re}\left(z\right) > 0$, $\Gamma\left(z\right)$ is defined by

$$\Gamma\left(z\right)=\int_{0}^{\infty}t^{z-1} e^{t} dt\text{,}$$

$\Gamma\left(z\right)$ has a value of complex-infinity at the origin and also
has poles at integer values along the negative real axis.

Reflection is given by

$$ \Gamma(-z)= \frac{\pi}{z\Gamma\left(z\right)\sin\left(\pi z\right)}\text{.}$$

Reccurence is given by

$$ \Gamma\left(z+1\right)= z\Gamma\left(z\right)\text{.}$$

## Calculation Method

Let's look at some background information regarding
computations of the real-valued gamma function.

The real-valued gamma function, $\Gamma\left(x\right)$
can be readily calculated using a series expansion
for its reciprocal near the origin.
Large arguments valued greater than one use recurrence.
For negative argument, the function value for the corresponding
positive-valued argument is first calculated and the value
for negative argument is obtaind via reflection.

Consider the series expansion of the reciprocal of the gamma function
near the origin

$$ \frac{1}{\Gamma\left(z\right)}\approx \sum_{k=1}^{n} a^{k} z^{k}\text{.}$$

In the subroutine `GAMMA` in Sect. 3.1.5 on pages 49-50 of [1],
the coefficients $a_{k}$ are given to $26$ terms. These are used
in a series calculation of $\Gamma\left(x\right)$ for real-valued $x$
using `Fortran77`'s double-precision data type `REAL*8`.
Further information on this coefficient expansion can be found
in Sect. 6.1.34 of [2], in Sect. 5.7.1 of [3]
and in additional references therein.

See also
[Wolfram Alpha(R)](https://www.wolframalpha.com/input?i=Series%5B1%2FGamma%5Bz%5D%2C+%7Bz%2C+0%2C+3%7D%5D)
for brief mathematical insight into the fascinating
series expansion of the reciprocal of the gamma function near the origin.

## Expanded Quadruple-Precision Implementation

In this repository, the series calculation mentioned above has been
extended to quadruple-precision.

The coefficients $a_{k}$ have been expanded (via computer algebra)
to $48$ terms having $51$ decimal digits of precision. With this coefficient list,
it is possible to reach the quadruple-precision of `Fortran77`'s data type `REAL*16`.
These higher-precision coefficients can be found in the table `G` in the
[source code](https://github.com/ckormanyos/gamma_f77/blob/main/gamma.f).

The implementation uses the `gfortran` dialect that is available in `g++`.

## Test-Run and CI

### Continuous Integration

Continuous integration (CI) runs with gfortran using GHA ubuntu-latest
and macos-latest runners. CI exercises both building `gamma` as well as running
several straightforward `gamma` test cases.

A (growing) test suite is present in both the build workflows
as well as in [`cover.sh`](./.gcov/make/cover.sh).
These tests are used in CI to verify the expected functionality and also
to obtain [code coverage results](https://app.codecov.io/gh/ckormanyos/gamma_f77).

### Testing

The test-run computes $9$ gamma values $\Gamma\left(x\right)$
for positive, real-valued arguments at

$$x = 1.11, 2.21, 3.31, {\ldots} 9.91\text{.}$$

Negative reflection is tested at

$$x=-4.56\text{.}$$

Integral-valued argument is checked for

$$x=31\text{,}$$

which is used to compute $\Gamma\left(31\right)$, the result of which
is expected to be equal to the integral factorial

$$30 ! = 265,252,859,812,191,058,636,308,480,000,000 \text{.}$$

CI runs on Ubuntu and MacOS using `g++`.
Correct numerical results are verified on the OS-level
up to the $33$ decimal digit precision using the built-in
program `grep`.

The program can also be compiled and executed at this
[short link](https://godbolt.org/z/xPWhqab9z)
to [godbolt](https://godbolt.org).

## Long Standards-Conforming Time-Span

The program compiles with language standards `legacy` (i.e., `Fortran77`)
as well as all the way up to modern `f2023`.

This is a remarkably long standards-conforming time-span.
It exceeds 40 years - with hopefully more to come!

Proving this longevity in this repository was achieved in part
through contributions from [@Beliavsky](https://github.com/Beliavsky).
These were initially proposed in [gamma_f77/issues/13](https://github.com/ckormanyos/gamma_f77/issues/13).
Thank you for these contributions.

## References

[1] Shanjie Zhang and Jianming Jin, _Computation_ _of_ _Special_ _Functions_,
Wiley, 1996, ISBN: 0-471-11963-6, LC: QA351.C45

[2] M. Abramowitz and I.A. Stegun, _Handbook_ _of_ _Mathematical_ _Functions_,
9th Printing, Dover Publications, 1970.

[3] F.W.J. Olver, D.W. Lozier, R.F. Boisvert and C.W. Clark,
_NIST_ _Handbook_ _of_ _Mathematical_ _Functions_,
Cambridge University Press, 2010.
