%{
    O código funciona da seguinte forma: 
    parametriza-se o periodo de símbolo Ts, o fator de roll off (ro_factor)
    , a largura do sinal "fim"  e a frequencia da portadora f0.
    na qual o sinal vai ser amostrado pra bater com a modulação que vai à seguir, no código "modulacao_BPSK_amostras.m".

%}

ro_factor = 0.75;
Ts = 0.005; %periodo de bit
tempo_final = 0.15; % tamanho do sinal

f0 = 2000; %frequência da portadora.

F_max = f0 + ((ro_factor + 1)/(2*Ts)); 
T_sample = 1/(2*F_max);

t = -tempo_final:T_sample:tempo_final; 

lenght_samples = numel(t);


if ismember(Ts/(2*ro_factor),t)
    disp('escolha outro número');  % situação de singularidade.  
else
    
cos_samples = (1/Ts).*sinc(t./Ts).*cos(pi.*ro_factor.*t/Ts)./(1-((2.*ro_factor.*t/Ts).^2)); %função que define p pulso cosseno levantado.

cos_samples = cos_samples/max(cos_samples); %normalização para amplitude 1

fileID = fopen('samp_raised_cos.txt','w');

fprintf(fileID,'%d ',cos_samples);
plot(t,cos_samples);
figure;

                 
L = lenght_samples;             % Length of signal
t1 = (0:L-1)*T_sample;        % Time vector
F_sample = 1/T_sample;

Y = fft(cos_samples);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = F_sample*(0:(L/2))/L;
plot(f,P1) ;

end