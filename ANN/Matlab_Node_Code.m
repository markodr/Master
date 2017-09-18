ULAZ = [0.022119 ; 0.0217001 ; 0.0147911];

[Y,Xf,Af] = ANN_Function(ULAZ);
Round_Izlaz=round(Y);
IZLAZ = bi2de(Round_Izlaz')