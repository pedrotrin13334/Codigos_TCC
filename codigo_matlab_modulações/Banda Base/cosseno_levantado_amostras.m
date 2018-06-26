%{
 O c�digo funciona da seguinte forma: 
    Parametriza-se o periodo de s�mbolo T , o fator de roll off
    ro_factor, a largura do sinal "fim"  e a frequencia da portadora f0
    na qual o sinal vai ser amostrado pra bater com a modula��o que vai seguir.
    A forma de onda gerada ent�o � quantizada. 
%}

bit_num = 8;    %n�mero de bits de quantiza��o
bit_qtd = 2^(bit_num) - 1 ; 


ro_factor = 0.75; %fator de roll-off
Ts = 0.005; %periodo de simbolo
tempo_final = 0.15; % tamanho do sinal (sim�trico). 
c_sup = 100; % fator de sobreamostragem, que � mais um par�metro que pode auxiliar no controle do n�mero de amostras
F_max =  c_sup + ((ro_factor + 1)/(2*Ts)); 
T_sample = 1/(2*F_max);
F_sample = 1/T_sample; 

t = -tempo_final:T_sample:tempo_final; 
lenght_samples = size(t,2);
if ismember(Ts/(2*ro_factor),t)
    disp('escolha outro n�mero');  % situa��o de singularidade
else
    
samples = (1/Ts).*sinc(t./Ts).*cos(pi.*ro_factor.*t/Ts)./(1-((2.*ro_factor.*t/Ts).^2)); %f�rmula do cosseno levantado


samples = samples - min(samples); %garantir que n�o haja n�meros negativos
samples = bit_qtd.*samples./max(samples);  %Normalizar

plot(t,samples);
figure;


 % Parte do c�digo que quantiza efetivamente o sinal Cosseno Levantado tratado anteriormente
 % O c�digo instancia algumas vari�veis que definem o espa�o de quantiza��o.
 % se define a parti��o e o codebook
 
                    part = linspace(0, bit_qtd, bit_qtd + 1);
                    cook = zeros(1,length(part)+1); %vetor de zeros
                    cook(2:end)=part(1:end);

                    [index,quantized] = quantiz(samples,part,cook); %fun��o que quantiza
                    

%fun��o que abre o arquivo texto no qual as amostras ser�o colocadas.                    
            fileID = fopen('amostras_cosseno_levantado.txt','w');
%fun��o que printa as amostras em um arquivo de texto para ser ent�o usado
% No VIVADO.
             fprintf(fileID,', %d ',quantized);

             
 plot(t,samples,t,quantized,'x');
figure;

if ismember(Ts/(2*ro_factor),t)
    disp('escolha outro n�mero');
else
         % Sampling frequency                    
T_sample = 1/(2*F_max);             % Sampling period       
L = lenght_samples;             % Length of signal
t1 = (0:L-1)*T_sample;        % Time vector

Y = fft(samples);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = F_sample*(0:(L/2))/L;
plot(f,P1);
figure;

Y = fft(quantized);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = F_sample*(0:(L/2))/L;
plot(f,P1) 
end
end