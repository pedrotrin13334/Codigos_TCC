%{
   Este código deve ser utilizado apenas após o código
   "cosseno_levantado.m", em mesma pasta, com mesmo workspace.
   determine o número de bits de quantização.
%}

bit_num = 8;    %número de bits de quantização
bit_qtd = 2^(bit_num) - 1 ; 


samples_bpsk = cos_samples.*cos(2*pi*f0*t); %fórmula para o pulso BPSK

 plot(t,samples_bpsk); 
 figure; 

 
samples_bpsk = samples_bpsk - min(samples_bpsk); %garantir apenas números positivos.
samples_bpsk = (samples_bpsk/max(samples_bpsk))*bit_qtd; % normalização para garantir toda a faixa de quantização;


 % Parte do código que quantiza efetivamente o sinal BPSK tratado anteriormente
 % O código instancia algumas variáveis que definem o espaço de quantização.
 % se define a partição e o codebook
 
                    part = linspace(0, bit_qtd, bit_qtd + 1);
                    cook = zeros(1,length(part)+1); %vetor de zeros
                    cook(2:end)=part(1:end);

                    [index,quantized] = quantiz(samples_bpsk,part,cook); %função que quantiza
                    

%função que abre o arquivo texto no qual as amostras serão colocadas.
            fileID = fopen('amostras_bpsk.txt','w'); 
%função que printa as amostras em um arquivo de texto para ser então usado
% No VIVADO.
            fprintf(fileID,', %d ',quantized);    

            
plot(t,samples_bpsk,t,quantized,'x');
figure; 

plot(t,quantized);

%Variáveis para a realização da FFT.
        Y = fft(quantized);     
        P2 = abs(Y/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);   
        f = F_sample*(0:(L/2))/L;
        plot(f,P1) ;
