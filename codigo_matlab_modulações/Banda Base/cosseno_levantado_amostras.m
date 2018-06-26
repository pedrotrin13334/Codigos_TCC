%{
 O código funciona da seguinte forma: 
    Parametriza-se o periodo de símbolo T , o fator de roll off
    ro_factor, a largura do sinal "fim"  e a frequencia da portadora f0
    na qual o sinal vai ser amostrado pra bater com a modulação que vai seguir.
    A forma de onda gerada então é quantizada. 
%}

bit_num = 8;    %número de bits de quantização
bit_qtd = 2^(bit_num) - 1 ; 


ro_factor = 0.75; %fator de roll-off
Ts = 0.005; %periodo de simbolo
tempo_final = 0.15; % tamanho do sinal (simétrico). 
c_sup = 100; % fator de sobreamostragem, que é mais um parâmetro que pode auxiliar no controle do número de amostras
F_max =  c_sup + ((ro_factor + 1)/(2*Ts)); 
T_sample = 1/(2*F_max);
F_sample = 1/T_sample; 

t = -tempo_final:T_sample:tempo_final; 
lenght_samples = size(t,2);
if ismember(Ts/(2*ro_factor),t)
    disp('escolha outro número');  % situação de singularidade
else
    
samples = (1/Ts).*sinc(t./Ts).*cos(pi.*ro_factor.*t/Ts)./(1-((2.*ro_factor.*t/Ts).^2)); %fórmula do cosseno levantado


samples = samples - min(samples); %garantir que não haja números negativos
samples = bit_qtd.*samples./max(samples);  %Normalizar

plot(t,samples);
figure;


 % Parte do código que quantiza efetivamente o sinal Cosseno Levantado tratado anteriormente
 % O código instancia algumas variáveis que definem o espaço de quantização.
 % se define a partição e o codebook
 
                    part = linspace(0, bit_qtd, bit_qtd + 1);
                    cook = zeros(1,length(part)+1); %vetor de zeros
                    cook(2:end)=part(1:end);

                    [index,quantized] = quantiz(samples,part,cook); %função que quantiza
                    

%função que abre o arquivo texto no qual as amostras serão colocadas.                    
            fileID = fopen('amostras_cosseno_levantado.txt','w');
%função que printa as amostras em um arquivo de texto para ser então usado
% No VIVADO.
             fprintf(fileID,', %d ',quantized);

             
 plot(t,samples,t,quantized,'x');
figure;

if ismember(Ts/(2*ro_factor),t)
    disp('escolha outro número');
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