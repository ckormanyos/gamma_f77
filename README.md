gamma_f77
==================

gamma_f77 implements the real-valued Gamma function in quadruple-precision using
the classic Fortran77 language.

## Mathematical Background

The Gamma function is the real-valued (and complex-valued) extension
to the well-known integer factorial function.

The Gamma function of complex argument $\Gamma(z)$ is defined by

$$ $$

In the complex plane the value of $\Gamma(z)$ is complex-infinity at the origin.
It also and has poles at negative integer values along the negative real axis.

## Licensing and Original Implementation

The original FORTRAN77 version of this routine is copyrighted by 
Shanjie Zhang and Jianming Jin.  However, they give permission to 
incorporate this routine into a user program provided that the
copyright is acknowledged.

See also the subroutine `GAMMA` in Section 3.1.5 pages 49-50 of [1].

The program has been modified for this repository.
  - Use the `gfortran` dialect.
  - Adapt argument/result to quadruple-precision using the `REAL*16` data type.
  - Coefficients to $51$ decimal digits precision acquired from computer algebra system.

## References

[1] Shanjie Zhang and Jianming Jin, _Computation_ _of_ _Special_ _Functions_,
Wiley, 1996, ISBN: 0-471-11963-6, LC: QA351.C45
