%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                   %
%       Universidade Federal do Ceará                               %
%       Class: Inteligência Computacional                           %
%       Student: Julio Cesar Ferreira Lima                          %
%       Professor: CARLOS ALEXANDRE ROLIM FERNANDES                 %
%       Enrrollment: 393849                                         %
%       Homework: Characteristics Vector from ECG                   %
%                                                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function characteristics_vector_ecg
    % 1)
        % Default parameters
        load s0017lre.dat
        %load chirp.mat

        Fs=8192;
        samples = size(y,1);

        % The range of i, was changed and to newFs less than 1000 appear an error.
        % To frequencis below of Fs the tone sound like more bass.
        % TO frequencis below of fs the tone sound like more bass.
        %shakeFrequency(y,Fs);

    % 2) 
        %plotEverything(y,samples);


    % 3)
        % Was observed that the noise in the time and frequency, was
        % superimposed by the audio.

        %noiseY = addNoise(y,samples,Fs);
     
     % 4)
        % According with fft, the frequencies added by the noise was in whole
        % frequencies. But the major signal was in low frequencies, if just
        % maintain the lower frequencis que quality of signal could
        % improve. So I would choice LPF.
        Fc = 1200;
        order = 7;
        [b,a] = butter(order,Fc/(Fs/2));
        [z,p,k] = butter(order,Fc/(Fs/2));
        figure, freqz(b,a);
        figure, impz(b,a);
        
    % 5)
        % The Z plane show zeros and poles, so they are bilateral.
        % Until bileral he cannot be FIR, so they gonna be IIR.
        % Looking at the z plane you could determain the nature of filter.
        % The frequencies near zeros gonna be rejected ones near to poles,
        % gonna be accpected.
        figure,zplane(z,p);
        
    % 6)
        fvtool(b,a);
        
    % 7) 
        noise = 0 + 0.1*randn(samples,1);
        noiseY = y  + noise;
        filteredY = filter(b,a,noiseY);
        
    % 8)
        sound(filteredY,Fs)
        
    % 9) Not comprehended.
        
    % 10)
            % The main frequencies of signal are in high frequencies, so a
            % better filter for this signal would be a HPF or BPF.
    
end

function plotEverything(y,samples)
% Plot in time continously.
figure, plot(y);
% Plot in time discretly.
figure, stem(y);
% Plot in frequency the signal y.
x = linspace(-pi,pi,samples);
fourier = fftshift(fft(y));
figure, plot(x,abs(fourier),'r');
end

function shakeFrequency(y,Fs)
    for i=1:8
        newFs = Fs/i;
        sound(y,newFs);
        pause(3);
        disp('Right now frequency: ' + newFs);
    end
    for i=1:-.1:.1 
        newFs = Fs/i;
        sound(y,newFs);
        pause(3);
        disp('Right now frequency: ' + newFs);
    end
end

function noiseY = addNoise(y,samples,Fs)
    % Generating the White Noise, of mean 0 and deviation 0.1.
    noise = 0 + 0.1*randn(samples,1);
    newY = y  + noise;
    % Ploting;
    plotEverything(newY,samples);
    % Was observed that.
    sound(y,Fs);
    pause(3);
    sound(newY,Fs);
    noiseY = newY;
end
