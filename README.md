# MO-ALU

Il Sistema Multi-Operation ALU (MOALU) è composto da una unità centrale (logico-aritmetica, ALU) che esegue le seguenti operazioni
su due numeri A e B di Nb bits (forniti dal bus di uscita (din) di un registro REG_IN):
1) Somma (A+B)
2) Complemento a 2 (C2) del numero A (o del numero B, a scelta)
3) Sottrazione (A-B, oppure B-A), dopo aver convertito il secondo operando in un numero intero negativo in C2
MOALU utilizza una interfaccia seriale per l’acquisizione sincrona (attraverso un'unica linea seriale (bin)) dei numeri A e B (che vengono
poi salvati nel registro REG_IN).
Il risultato dell’operazione scelta viene salvato in un registro REG_OUT.
Il sistema opera attraverso una Finite-State-Machine (FSM) Control Unit (CU) regolata dal segnale control_bits (di Mb bits).
Il sistema MOALU è dotato di:
• un segnale di reset globale, asincrono e attivo basso, che azzera il contenuto del registro REG_IN;
• un segnale di enable attivo alto e sincrono.
Obiettivi:
• Disegnare il diagramma a stati della CU.
• Progettare lo schema a blocchi di MOALU e implementarlo in VHDL, eseguendo le seguenti simulazioni di transizione di stato:
o RX →SOMMA→C2→RESET
o RX →SOTTRAZIONE→RESET
