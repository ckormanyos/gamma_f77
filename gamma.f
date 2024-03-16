CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC80
C     cd /mnt/c/Users/User/Documents/Ks/PC_Software/Fortran/gamma
C     Compile with legacy (FORTRAN77).
C     g++ -x f77 -std=legacy -O2 gamma.f -lgfortran -lquadmath -o gamma.exe
C
C     Or compile with modern f2018 conformance.
C     g++ -x f77 -std=f2018 -O2 gamma.f -lgfortran -lquadmath -o gamma.exe
C
C     TGAMMA evaluates the Gamma function.
C
C     Parameters:
C
C     Input, REAL*16 X, the argument.
C     X must not be 0, or any negative integer.
C
C     Output, REAL*16 GA, the value of the Gamma function
C     (quad precision).
C
      MODULE GAMMA_MOD
      IMPLICIT NONE
      INTEGER, PARAMETER :: QP = SELECTED_REAL_KIND(32)
      CONTAINS
      SUBROUTINE TGAMMA (X, GA)
      REAL(KIND=QP) :: X, GA, G(48), GR, PI, R, Z
      INTEGER :: K, M, M1
C
C     N[Series[1/Gamma[z], {z, 0, 48}], 51]
C     Table[SeriesCoefficient[%, n], {n, 48}]
C     ... and the Series generation takes several minutes.
C     Don't concatenate these (potentially nested) operations,
C     as that did not end at all, at least not for me.
C
      DATA G/+1.0_QP,
     &  +5.77215664901532860606512090082402431042159335939924E-01_QP,
     &  -6.55878071520253881077019515145390481279766380478584E-01_QP,
     &  -4.20026350340952355290039348754298187113945004011061E-02_QP,
     &  +1.66538611382291489501700795102105235717781502247174E-01_QP,
     &  -4.21977345555443367482083012891873913016526841898225E-02_QP,
     &  -9.62197152787697356211492167234819897536294225211300E-03_QP,
     &  +7.21894324666309954239501034044657270990480088023832E-03_QP,
     &  -1.16516759185906511211397108401838866680933379538406E-03_QP,
     &  -2.15241674114950972815729963053647806478241923378339E-04_QP,
     &  +1.28050282388116186153198626328164323394892099693677E-04_QP,
     &  -2.01348547807882386556893914210218183822948332979791E-05_QP,
     &  -1.25049348214267065734535947383309224232265562115396E-06_QP,
     &  +1.13302723198169588237412962033074494332400483862108E-06_QP,
     &  -2.05633841697760710345015413002057283651257902629338E-07_QP,
     &  +6.11609510448141581786249868285534286727586571971232E-09_QP,
     &  +5.00200764446922293005566504805999130304461274249448E-09_QP,
     &  -1.18127457048702014458812656543650557773875950493259E-09_QP,
     &  +1.04342671169110051049154033231225019140070982312581E-10_QP,
     &  +7.78226343990507125404993731136077722606808618139294E-12_QP,
     &  -3.69680561864220570818781587808576623657096345136100E-12_QP,
     &  +5.10037028745447597901548132286323180272688606970763E-13_QP,
     &  -2.05832605356650678322242954485523741974609108081015E-14_QP,
     &  -5.34812253942301798237001731872793994898971547812068E-15_QP,
     &  +1.22677862823826079015889384662242242816545575045632E-15_QP,
     &  -1.18125930169745876951376458684229783121155729180485E-16_QP,
     &  +1.18669225475160033257977724292867407108849407966483E-18_QP,
     &  +1.41238065531803178155580394756670903708635075033453E-18_QP,
     &  -2.29874568443537020659247858063369926028450593141904E-19_QP,
     &  +1.71440632192733743338396337026725706681265606251743E-20_QP,
     &  +1.33735173049369311486478139512226802287505947176189E-22_QP,
     &  -2.05423355176667278932502535135573379668203793523874E-22_QP,
     &  +2.73603004860799984483150990433098201486531169583636E-23_QP,
     &  -1.73235644591051663905742845156477979906974910879500E-24_QP,
     &  -2.36061902449928728734345073542753100792641355214537E-26_QP,
     &  +1.86498294171729443071841316187866689894586842907367E-26_QP,
     &  -2.21809562420719720439971691362686037973177950067568E-27_QP,
     &  +1.29778197494799366882441448633059416561949986463913E-28_QP,
     &  +1.18069747496652840622274541550997151855968463784158E-30_QP,
     &  -1.12458434927708809029365467426143951211941179558301E-30_QP,
     &  +1.27708517514086620399020667775112464774877206560048E-31_QP,
     &  -7.39145116961514082346128933010855282371056899245153E-33_QP,
     &  +1.13475025755421576095416525946930639300861219592633E-35_QP,
     &  +4.63913464105872202994480490795222846305796867972715E-35_QP,
     &  -5.34733681843919887507741819670989332090488590577356E-36_QP,
     &  +3.20799592361335262286123727908279439109014635972616E-37_QP,
     &  -4.44582973655075688210159035212464363740143668574872E-39_QP,
     &  -1.31117451888198871290105849438992219023662544955743E-39 /

      PI = 3.14159265358979323846264338327950288419716939937511_QP

      IF(X.EQ.INT(X)) THEN
        IF(X.GT.0.0_QP) THEN
          GA = 1.0_QP
          M1 = INT(X) - 1
          DO K = 2, M1
            GA = GA * K
          END DO
        ELSE
          GA = 1.0E4000_QP
        END IF
      ELSE
        IF(ABS(x).GT.1.0_QP) THEN
          Z = ABS (X)
          M = INT (Z)
          R = 1.0_QP
          DO K = 1, M
            R = R * (Z - K)
          END DO
          Z = Z - M
        ELSE
          Z = X
        END IF

        GR = G(48)
        DO K = 47, 1, -1
          GR = GR * Z + G(K)
        END DO

        GA = 1.0_QP / (GR * Z)

        IF(ABS(X).GT.1.0_QP) THEN
          GA = GA * R
          IF(X.LT.0.0_QP) THEN
            GA = - PI / (X* GA * SIN (PI * X))
          END IF
        END IF
      END IF
      RETURN
      END SUBROUTINE TGAMMA
      END MODULE GAMMA_MOD

CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC80
C
C     Test program GAMMA used for testing GAMMA_MOD
C
      PROGRAM GAMMA
      USE GAMMA_MOD
      IMPLICIT NONE
      INTEGER :: N
      REAL(KIND=QP) :: X, GA
C
C     Table[N[Gamma[(100 n + 10 n + 1) / 100], 33], {n, 1, 9, 1}]
C
      DO N = 1, 9, 1
        X = (1.0E02_QP*N + 1.0E01_QP*N + 1.0_QP) / 1.0E02_QP
        CALL TGAMMA(X, GA)
        WRITE(6, "(E44.33)") GA
      END DO
C
C     N[Gamma[-456/100], 33]
C
      X = -4.56_QP
      CALL TGAMMA(X, GA)
      WRITE (6, "(E44.33)") GA
C
C     N[Factorial[30], 33]
C
      X = 31.0_QP
      CALL TGAMMA(X, GA)
      WRITE(6, "(E44.33)") GA

      END
C
C     Program Output:
C
C     0.947395504039301942134227647281424E+00
C     0.110784755653406415338349971053114E+01
C     0.271139823924390323650711692085896E+01
C     0.102754040920152050479188001843206E+02
C     0.531934282525008207389522379291889E+02
C     0.350998609824200588801455504140098E+03
C     0.282509453680418713613816084109635E+04
C     0.269036719467497675679082571845063E+05
C     0.296439082102472192334520537379648E+06
C    -0.554521067573633755529159865936434E-01
C     0.265252859812191058636308480000000E+33
