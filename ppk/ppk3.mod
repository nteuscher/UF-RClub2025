$PROBLEM PK model
;----------------------------------
$INPUT C ID TIME TAD DV MDV EVID AMT ADDL II WT HV CRCL AGE SEX FOOD RACE ALT AST ALB
;----------------------------------
$DATA poppk.csv IGNORE=@
;----------------------------------
$SUBROUTINES ADVAN4 TRANS4
;----------------------------------
$PK
;----------------------------------
CL = THETA(1) * EXP(ETA(1))
V2 = THETA(2) * EXP(ETA(2))
Q  = THETA(3) * EXP(ETA(3))
V3 = THETA(4) * EXP(ETA(4))
KA = THETA(5) * EXP(ETA(5))
S2 = V2
;----------------------------------
$THETA
(0, 44)   ; Clearance
(0, 21)   ; Volume central
(0, 19)    ; Q
(0, 1115)  ; Volume peripheral
(0, 0.2)  ; Ka
;----------------------------------
$OMEGA
0.1	   ; IIV CL
0.1	   ; IIV V2
0.1    ; IIV Q
0.1    ; IIV V3
0.1	   ; IIV KA
;----------------------------------
$SIGMA
0.1	   ;residual variability 
;----------------------------------
$ERROR
;----------------------------------
IPRED = F
IRES = DV-IPRED
W = IPRED
IF (W.EQ.0) W = 1
IWRES = IRES/W
Y= IPRED * (1 + ERR(1))
;----------------------------------

$EST METHOD=1 INTER
MAXEVAL=9999 PRINT=5 NOABORT POSTHOC
;----------------------------------
$COV PRINT=E
;----------------------------------
; OUTPUT
$TABLE ID TIME TAD DV MDV EVID  
       WT HV CRCL AGE SEX FOOD RACE ALT AST ALB 
       CL V2 Q V3 KA ETAS(1:LAST) 
	   IPRED IRES IWRES CWRES ONEHEADER NOPRINT	   
       FILE=ppk3.tab
;----------------------------------
