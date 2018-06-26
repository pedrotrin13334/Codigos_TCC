%{
   Este c�digo deve ser utilizado apenas ap�s o c�digo
   "cosseno_levantado.m", em mesma pasta, com mesmo workspace.
   determine o n�mero de bits de quantiza��o.
%}

bit_num = 8;    %n�mero de bits de quantiza��o
bit_qtd = 2^(bit_num) - 1 ; 


samples_bpsk = cos_samples.*cos(2*pi*f0*t); %f�rmula para o pulso BPSK

 plot(t,samples_bpsk); 
 figure; 

 
samples_bpsk = samples_bpsk - min(samples_bpsk); %garantir apenas n�meros positivos.
samples_bpsk = (samples_bpsk/max(samples_bpsk))*bit_qtd; % normaliza��o para garantir toda a faixa de quantiza��o;


 % Parte do c�digo que quantiza efetivamente o sinal BPSK tratado anteriormente
 % O c�digo instancia algumas vari�veis que definem o espa�o de quantiza��o.
 % se define a parti��o e o codebook
 
                    part = linspace(0, bit_qtd, bit_qtd + 1);
                    cook = zeros(1,length(part)+1); %vetor de zeros
                    cook(2:end)=part(1:end);

                    [index,quantized] = quantiz(samples_bpsk,part,cook); %fun��o que quantiza
                    

%fun��o que abre o arquivo texto no qual as amostras ser�o colocadas.
            fileID = fopen('amostras_bpsk.txt','w'); 
%fun��o que printa as amostras em um arquivo de texto para ser ent�o usado
% No VIVADO.
            fprintf(fileID,', %d ',quantized);    

            
plot(t,samples_bpsk,t,quantized,'x');
figure; 

plot(t,quantized);

%Vari�veis para a realiza��o da FFT.
        Y = fft(quantized);     
        P2 = abs(Y/L);
        P1 = P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);   
        f = F_sample*(0:(L/2))/L;
        plot(f,P1) ;
