;ENCABEZADO
        #INCLUDE<P16F873A.INC>
        __CONFIG _XT_OSC & _WDT_OFF & _CP_OFF & _PWRTE_ON &_BODEN_OFF & _LVP_OFF & _CPD_OFF & _DEBUG_OFF
;DEFINICIONES
;REGISTROS
        CBLOCK  02H
        V0
        V1
        V2
        V3
        V5
        RESULTADO
        COMPARACIÓN
        ENDC
;INICIO
        ORG 00H
;CONFIGURACIÓN
CONF:       
            BSF     STATUS,RP0
            MOVLW   0FFH
            MOVWF   TRISA
            CLRF    TRISB
            CLRF    TRISC
            BSF TRISC,7
            MOVLW   07H
            MOVWF   OPTION_REG
            MOVLW   19H
            MOVWF   SPBRG
            CLRF    TXSTA
            BSF TXSTA,2
            BSF TXSTA,5
            BSF     TRISC,7
            CLRF    ADCON1
            BCF     STATUS,RP0
            CALL    T40US
            MOVLW   b'00000101'
            MOVWF   ADCON0
            CALL    T40US
            CLRF    RCSTA
            BSF     RCSTA,4
            BSF     RCSTA,7
            
            CLRF    PORTB
            CLRF    PORTC
CHECAR:     BTFSC   ADCON0,2   
            GOTO    $-1   
            MOVF    ADRESH,W
            MOVWF   RESULTADO
            MOVF    ADRESH,W
            CALL    COMPARA
            CALL    T5MS
            BSF     ADCON0,2
            GOTO    CHECAR

Send_Serial:    MOVWF   TXREG
                CALL    T1MS
                NOP
                RETURN

T1MS:           CLRF    V0
                MOVLW   d'248'
                MOVWF   V0
                DECF    V0,1
                BTFSS   STATUS,Z
                GOTO    $-2
                RETURN

            #INCLUDE<TIEMPOS.INC>
            #INCLUDE<TEXTOS.INC>
            #INCLUDE<COMPAR.INC>
            END