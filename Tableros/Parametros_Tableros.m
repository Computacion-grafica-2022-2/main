%function []=Parametros_Tableros()
clc;clear all

[num,txt,raw] = xlsread('C:\Users\David\Documents\unal\Computacion grafica\Projecto cajas\Modelado\FormularioWeb.xlsx');

Monofasicas=num(1);
bifasicas=num(2);
trifasicas=num(3);
bandejas=num(4);

Total=Monofasicas+bifasicas+trifasicas;
LongT=Monofasicas*15+(bifasicas+trifasicas)*30;
%% Vector de cuentas
%cuenta cualquiera [longitud, altura]
%selection=menu('Que opinas de este menu','Con esta opcion',' y esta otra obcion');
V=[];
for i=1:Monofasicas
    V=[V;[15,25]];
end
for i=1:bifasicas
    V=[V;[30,35]];
end
for i=1:trifasicas
    V=[V;[30,35]];
end
%% Calculo Longitud total por bandeja
Ncuentas=length(V(:,1));
j=1;        %Contador de bandejas
Long_bandeja=zeros(1,bandejas);
Altura_bandeja=zeros(1,bandejas);
AlturaMax=0;
SumaParcial=0;
for i=1:Ncuentas
    SumaParcial=SumaParcial+V(i,1);
    if SumaParcial>=(j-1)*LongT/bandejas &&  SumaParcial<=j*LongT/bandejas 
        Long_bandeja(j)=Long_bandeja(j)+V(i,1);
        if AlturaMax<V(i,2)
            AlturaMax=V(i,2);
            Altura_bandeja(j)=AlturaMax;
        end
            
    else
        j=j+1;
        AlturaMax=0;
        Long_bandeja(j)=Long_bandeja(j)+V(i,1);
    end
    
end
LongT
Long_bandeja
Altura_bandeja
LongTolerance=100;
AltuTolerance=50;
CompartimentoAcometidas=300;
CompartimentoBarraje=400;
LongMax=max(Long_bandeja)*10+LongTolerance;     %max(Long_bandeja)*10 toma la mayero distacion y la pasa a mm
AlturaTotal=sum(Altura_bandeja)*10+AltuTolerance;          % Suma las alturas y las pasa a mm cajon central
AlturaTotal=AlturaTotal+CompartimentoAcometidas+CompartimentoBarraje; % Altura Total del tablero
filename = 'C:\Users\David\Documents\unal\Computacion grafica\Projecto cajas\Modelado\datos.xlsx';
AB=zeros(7,1);          % Establecemos el numero maximo de bandejas
AB(1:bandejas,1)=transpose(10*Altura_bandeja);
A = {bandejas;AlturaTotal;LongMax;AB(1);AB(2);AB(3);AB(4);AB(5);AB(6);AB(7)};
sheet = 1;
xlRange = 'B1';
xlswrite(filename,A,sheet,xlRange)

AlturaTotal
LongMax
A
