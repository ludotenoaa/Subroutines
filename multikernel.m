function [ker,T,F]=multikernel(t,f,bw,Fs,N,NFFT,Overlap)

ker=[];

for I=1:length(t)-1

    ker_tmp=ker1(f(I),f(I+1),t(I+1)-t(I),bw(I),Fs,N,NFFT,Overlap);

    if I==1
        ker=ker_tmp;
    else
        ker=cat(2,ker,ker_tmp);
        ker=cat(2,ker,ker(:,end)); % duplicate last column to keep time indices consistent
    end
end

d=t(end)-t(1);
dT=round(N*(1-Overlap))/Fs;
T=[0:dT:d]+dT; 
F=[0:Fs/NFFT:Fs/2];






