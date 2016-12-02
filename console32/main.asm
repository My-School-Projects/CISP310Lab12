; general comments
; This version is compatible with Visual Studio 2012 and Visual C++ Express Edition 2012

; preprocessor directives
.586
.MODEL FLAT

; external files to link with

; stack configuration
.STACK 4096

; named memory allocation and initialization
.DATA
	
	; This is the number we will be trying to find the cube root of
	
	numberToBeCubeRooted	REAL4 1728.0
	
	; The accuracy threshold dictates how exact our answer will be.
	; Our algorithm will take logarithmically smaller steps as it approaches
	; the answer, and the accuracy threshold dictates how small those steps will
	; become before we are satisifed with our answer.
	; This should be a very small number. The smaller the number, the more steps
	; will be taken to converge on the answer. More steps = more time = more accurate answer.
	
	accuracyThreshold		REAL4 0.001

; procedure code
.CODE
main	PROC
	
	; -------------------------------------------------------------------
	; The algorithm for finding the cube root of a number x is as follows
	;
	; root := 1.0
	; repeat
	;	oldRoot := root
	;	root := (2.0 * root + x / (root * root) ) / 3.0
	; until ( |root - oldRoot| < accuracyThreshold)
	;
	; -------------------------------------------------------------------
	; The same algorithm implemented with a stack is as follows
	;
	; root := 1.0
	; 
	; loop
	;
	;	push root
	;	push root
	;
	;	----------
	;	ST(0) root
	;	ST(1) root
	;	----------
	;
	;	multiply
	;
	;	-----------------
	;	ST(0) root * root
	;	-----------------
	;
	;	push x
	;
	;	-----------------
	;	ST(0) x
	;	ST(1) root * root
	;	-----------------
	;
	;	divide
	;
	;	-----------------------
	;	ST(0) x / (root * root)
	;	-----------------------
	;
	;	push root
	;	push 2.0
	;
	;	-----------------------
	;	ST(0) 2.0
	;	ST(1) root
	;	ST(2) x / (root * root)
	;	-----------------------
	;	
	;	multiply
	;
	;	-----------------------
	;	ST(0) 2.0 * root
	;	ST(1) x / (root * root)
	;	-----------------------
	;	
	;	add
	;
	;	------------------------------------
	;	ST(0) 2.0 * root + x / (root * root)
	;	------------------------------------
	;
	;	push 3.0
	;
	;	------------------------------------
	;	ST(0) 3.0
	;	ST(1) 2.0 * root + x / (root * root)
	;	------------------------------------
	;
	;	divide
	;
	;	--------------------------------------------
	;	ST(0) (2.0 * root + x / (root * root)) / 3.0
	;	--------------------------------------------
	;
	;	oldRoot := root
	;	root := ST(0)
	;
	;	push oldRoot
	;	
	;	-------------
	;	ST(0) oldRoot
	;	ST(1) root
	;	-------------
	;
	;	subtract
	;
	;	--------------------
	;	ST(0) root - oldRoot
	;	--------------------
	;
	;	absolute value
	;
	;	------------------------
	;	ST(0) | root - oldRoot |
	;	------------------------
	;	
	;	push accuracyThreshold
	;
	;	------------------------
	;	ST(0) accuracyThreshold
	;	ST(1) | root - oldRoot |
	;	------------------------
	;
	;	compare ST(0) to ST(1)
	;
	; repeat if ST(0) >= ST(1)
	;
	; ------------------------------------------------
	; compressed version
	;
	; root := 1.0
	;
	; loop
	;
	;	push root
	;	push root
	;
	;	multiply
	;
	;	push x
	;
	;	divide
	;
	;	push root
	;	push 2.0
	;
	;	multiply
	;	add
	;
	;	push 3.0
	;
	;	divide
	;
	;	oldRoot := root
	;	root := ST(0)
	;
	;	push oldRoot
	;
	;	subtract
	;	absolute value
	;
	;	push accuracyThreshold
	;
	;	compare ST(0) to ST(1)
	;
	; repeat if ST(0) >= ST(1)


	mov eax, 0
	ret
main	ENDP

END
	