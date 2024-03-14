clear;

% Load the signal, 1000 samples of a damped sinus with f=80Hz. f_s is 8kHz. 
load signal;

% Load the noise corrupted signal, 1000 samples of the damped sinusoid
% superimposed with a Gaussian distributed white noise.
load signal_noise;

% QUESTION 1
% First we do an 1024 point DFT (in Matlab this is done using the function
% FFT). You could also do a 1000-point FFT -- Matlab will accept any size.
% Although the sequence that we want to analyse is only 1000 samples, it is
% possible to do a 1024-point FFT by zero-padding.

spec_signal = fft(s, 1024);

% Next we calculate and plot the amplitude spectrum.
% First we create a frequency axis, which represents the spectrum from 0 to
% 2*pi
for i=1:1024
    f_axis(i)=(i-1)*(8000/1024);
end;

mag = abs(spec_signal);
%plot(f_axis, mag);


% QUESTION 2
% It is quite difficult to see the peak, so let's try to zoom in a bit...
% We now plot the spectrum from 0 to 200Hz, i.e., we plot the first 26
% samples
%plot(f_axis(1:26), mag(1:26))


% QUESTION 3
% With only 26 samples to represent the spectrum from 0 to 200Hz, we have a
% quite poor frequency resolution. Althoug we do not get a higher absolute 
% accuracy, we may want to increase the number of samples in the spectrum, 
% e.g., with a factor of 10.
% Basically, this can be done by zero-padding up to 10x1024=10240. In
% Matlab zero-padding is automatically done by specifying the FFT-size
% larger than the length of the sequence.

spec_signal = fft(s, 10240);

% Next we calculate and plot the amplitude spectrum.
% First we create a frequency axis, which represents the spectrum from 0 to
% 2*pi
for i=1:10240
    f_axis(i)=(i-1)*(8000/10240);
end;

mag = (abs(spec_signal));
% We now plot the spectrum from 0 to 200Hz which corresponds to the first
% 256 samples.
%plot(f_axis(1:256), mag(1:256))


% QUESTION 4
% In our next experiment we will window the input sequence using the
% Hamming window instead of the Rectangular window.

% First we derive the Hamming window and multiply it onto the signal.
window=hamming(1000);
for j=1:1000
    weighted_signal(j) = s(j)*window(j);
end

% Next we zero-pad to 10240 and calculate the spectrum.
spec_signal = fft(weighted_signal, 10240);
mag = (abs(spec_signal));
% Finally we plot the spectrum from 0 to 200Hz which corresponds to the first
% 256 samples.
%plot(f_axis(1:256), mag(1:256))


% QUESTION 5
% Basically what we do here is that we conduct a 1024-point FFT on the noise
% contaminated signal, calculate the magnitude in dB, and plot it.
clear f_axis; % Make a new freq-axis
for i=1:1024
    f_axis(i)=(i-1)*(8000/1024);
end;
% ...and then do the spectral analysis
spec_signal_noise = fft(s_n, 1024);
mag = 20*log10(abs(spec_signal_noise)); % Amplitude is in dB
%plot(f_axis(1:512), mag(1:512))


% QUESTION 6
% First we derive the Hamming window and multiply it onto the signal.
window=hamming(1000);
for j=1:1000
    weighted_signal_noise(j) = s_n(j)*window(j);
end

spec_signal_noise = fft(weighted_signal_noise, 1024);
mag = 20*log10(abs(spec_signal_noise)); % Amplitude is in dB
plot(f_axis(1:512), mag(1:512))

