fileID = load("database\RECORDS");

file_name = int2str(fileID(15));
file_path = fullfile('database',file_name);
[signal,Fs,tm ]= rdsamp(file_path,1);

ipsignal = signal(1:length(signal)/2);
amp = 10;
ipsignal = amp*ipsignal;
N = length(ipsignal);

sn = 10;
ipsignalN = awgn(ipsignal,sn);

level = 3;


% --------------------------------------------------------


wt = 'db13';

[LoD,HiD,LoR,HiR] = wfilters(wt);
[C,L] = wavedec(ipsignalN,level,LoD,HiD);
cA3 = appcoef(C,L,wt,level);
[cD1,cD2,cD3] = detcoef(C,L,[1,2,3]);
A3 = wrcoef('a',C,L,LoR,HiR,level);
D1 = wrcoef('d',C,L,LoR,HiR,1);
D2 = wrcoef('D',C,L,LoR,HiR,2);
D3 = wrcoef('D',C,L,LoR,HiR,3);

% 1.Universal Thresholding
D = [D1 D2 D3];
th = zeros(1,length(D));
Dth = zeros(1,length(D));

% a.soft thresholding
for g = 1:length(D)
    th(g) = sqrt(2*log(numel(D(g))));
    Dth(g) = wthresh(D(g),'s',th(g));
end
denoised = A3;
for i=1:length(Dth)
    denoised = denoised+Dth(i);
end
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'db13 - universal soft thresholding');


% b.hard thresholding
for g = 1:length(D)
    th(g) = sqrt(2*log(numel(D(g))));
    Dth(g) = wthresh(D(g),'h',th(g));
end
denoised = A3;
for i=1:length(Dth)
    denoised = denoised+Dth(i);
end
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'db13 - universal hard thresholding');


% 2. MinMax Thresholding
tptr = 'minimaxi';
thr_D1 = thselect(D1,tptr);
thr_D2 = thselect(D2,tptr);
thr_D3 = thselect(D3,tptr);

% a.soft thresholding
tD1 = wthresh(D1,'s',thr_D1);
tD2 = wthresh(D2,'s',thr_D2);
tD3 = wthresh(D3,'s',thr_D3);
denoised = A3 + tD1 + tD2 + tD3;
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'db13 - minmax soft thresholding')


% b.hard thresholding
tD1 = wthresh(D1,'h',thr_D1);
tD2 = wthresh(D2,'h',thr_D2);
tD3 = wthresh(D3,'h',thr_D3);
denoised = A3 + tD1 + tD2 + tD3;
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'db13 - minmax hard thresholding')



% 3. Level Dependent
D = [D1 D2 D3];
th = zeros(1,length(D));
Dth = zeros(1,length(D));

% a. soft thresholding
for g =1:length(D)
    th(g) = sqrt(2*log(numel(D(g)))/pow2(i)); 
    Dth(g) = wthresh(D(g),'s',th(g));
end
denoised = A3;
for i=1:length(Dth)
    denoised = denoised+Dth(i);
end
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'db13 - leveldependent soft thresholding');


% b. hard thresholding
for g =1:length(D)
    th(g) = sqrt(2*log(numel(D(g)))/pow2(i)); 
    Dth(g) = wthresh(D(g),'h',th(g));
end
denoised = A3;
for i=1:length(Dth)
    denoised = denoised+Dth(i);
end
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'db13 - leveldependent hard thresholding');


%------------------------------------------------

wt = 'sym21';

[LoD,HiD,LoR,HiR] = wfilters(wt);
[C,L] = wavedec(ipsignalN,level,LoD,HiD);
cA3 = appcoef(C,L,wt,level);
[cD1,cD2,cD3] = detcoef(C,L,[1,2,3]);
A3 = wrcoef('a',C,L,LoR,HiR,level);
D1 = wrcoef('d',C,L,LoR,HiR,1);
D2 = wrcoef('D',C,L,LoR,HiR,2);
D3 = wrcoef('D',C,L,LoR,HiR,3);

% 1.Universal Thresholding
D = [D1 D2 D3];
th = zeros(1,length(D));
Dth = zeros(1,length(D));

% a.soft thresholding
for g = 1:length(D)
    th(g) = sqrt(2*log(numel(D(g))));
    Dth(g) = wthresh(D(g),'s',th(g));
end
denoised = A3;
for i=1:length(Dth)
    denoised = denoised+Dth(i);
end
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'sym21 - universal soft thresholding');


% b.hard thresholding
for g = 1:length(D)
    th(g) = sqrt(2*log(numel(D(g))));
    Dth(g) = wthresh(D(g),'h',th(g));
end
denoised = A3;
for i=1:length(Dth)
    denoised = denoised+Dth(i);
end
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'sym21 - universal hard thresholding');


% 2. MinMax Thresholding
tptr = 'minimaxi';
thr_D1 = thselect(D1,tptr);
thr_D2 = thselect(D2,tptr);
thr_D3 = thselect(D3,tptr);

% a.soft thresholding
tD1 = wthresh(D1,'s',thr_D1);
tD2 = wthresh(D2,'s',thr_D2);
tD3 = wthresh(D3,'s',thr_D3);
denoised = A3 + tD1 + tD2 + tD3;
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'sym21 - minmax soft thresholding')

% b.hard thresholding
tD1 = wthresh(D1,'h',thr_D1);
tD2 = wthresh(D2,'h',thr_D2);
tD3 = wthresh(D3,'h',thr_D3);
denoised = A3 + tD1 + tD2 + tD3;
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'sym21 - minmax hard thresholding')



% 3. Level Dependent
D = [D1 D2 D3];
th = zeros(1,length(D));
Dth = zeros(1,length(D));

% a. soft thresholding
for g =1:length(D)
    th(g) = sqrt(2*log(numel(D(g)))/pow2(i)); 
    Dth(g) = wthresh(D(g),'s',th(g));
end
denoised = A3;
for i=1:length(Dth)
    denoised = denoised+Dth(i);
end
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'sym21 - leveldependent soft thresholding');


% b. hard thresholding
for g =1:length(D)
    th(g) = sqrt(2*log(numel(D(g)))/pow2(i)); 
    Dth(g) = wthresh(D(g),'h',th(g));
end
denoised = A3;
for i=1:length(Dth)
    denoised = denoised+Dth(i);
end
customplot(ipsignal(3600:5400),ipsignalN(3600:5400),denoised(3600:5400),'sym21 - leveldependent hard thresholding');

%-----------------------------------------------

function customplot(ipsignal,ipsignalN,denoised,title_s)
    figure;
    subplot(3,1,1);
    plot(ipsignal);
    title('Original Speech Signal');
    xlabel('samples');
    ylabel('Amplitude');
    subplot(3,1,2);
    plot(ipsignalN);
    title('Noisy Speech Signal');
    xlabel('Samples');
    ylabel('Amplitude');
    subplot(3,1,3);
    plot(denoised);
    %ylim([-100 100]);
    title('Denoised Speech Signal');
    xlabel('Samples');
    ylabel('Amplitude');
    sgtitle(title_s)
    NoisySNR = snr(ipsignal,ipsignalN);
    DenoisedSNR = snr(ipsignal,denoised);
    disp('SNR of Noisy signal:')
    disp(NoisySNR)
    disp('SNR of Denoised signal:')
    disp(DenoisedSNR)
end
