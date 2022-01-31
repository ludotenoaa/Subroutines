function [ker,T,F]=ker1(f0,f1,d,bw,Fs,N,NFFT,Overlap)

dT=round(N*(1-Overlap))/Fs;
T=[0:dT:d];
F=[0:Fs/NFFT:Fs/2];

for iT=1:length(T)
    x=F-(f0+(T(iT)/d)*(f1-f0));
    ker(:,iT)=(1-(x.^2)/bw^2).*exp((-x.^2)/(2*bw^2));
end
