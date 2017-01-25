; extracreditasm.s
; Runs on TM4C123
; Andrew Lynch
; January 24, 2017
; Runs asm code for lab1 extra credit for run-time testing
; 16360
; Dylan
; January 24, 2017
; No hardware necessary

;**************Test3***************
;Runs floating point arithmatic for timing purposes. Does not time itself
        AREA    DATA, ALIGN=2
Tfloat  SPACE   4
Nfloat  SPACE   4
        AREA    |.text|, CODE, READONLY, ALIGN=2
        THUMB
        EXPORT Test3
Test3
      MOV R0,#0
      LDR R1,=Nfloat       ;pointer to N
      LDR R2,=Tfloat       ;pointer to T
      VLDR.F32 S1,=0.009768   
      VLDR.F32 S2,=10   
loop3 STR R0,[R1]          ; N is volatile
      VMOV.F32 S0,R0
      VCVT.F32.U32 S0,S0   ; S0 has N
      VMUL.F32 S0,S0,S1    ; N*0.09768
      VADD.F32 S0,S0,S2    ; 10+N*0.0968
      VSTR.F32 S0,[R2]     ; T=10+N*0.0968
      ADD R0,R0,#1
      CMP R0,#4096
      BNE loop3
      BX  LR

;**************Test3***************
;Runs fixed point arithmatic for timing purposes. Does not time itself
        AREA    DATA, ALIGN=2
Tfixed  SPACE   4
Nfixed  SPACE   4
        AREA    |.text|, CODE, READONLY, ALIGN=2
        THUMB
        EXPORT Test4
Test4 PUSH {R4,R5,R6,LR}
      MOV R0,#0
      LDR R1,=Nfixed       ;pointer to N
      LDR R2,=Tfixed       ;pointer to T
      MOV R3,#125   
      MOV R4,#64
      MOV R5,#1000   
loop4 STR R0,[R1]          ; N is volatile
      MUL R6,R0,R3         ; N*125
      ADD R6,R6,R4         ; N*125+64
      LSR R6,R6,#7         ; (N*125+64)/128
      ADD R6,R6,R5         ; 1000+(N*125+64)/128
      STR R6,[R2]          ; T = 1000+(N*125+64)/128
      ADD R0,R0,#1
      CMP R0,#4096
      BNE loop4
      POP {R4,R5,R6,PC}
