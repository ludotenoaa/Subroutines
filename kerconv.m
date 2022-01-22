function [alpha,Ta]=kerconv(ker,Smag,Ts)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [alpha,Ta]=kerconv(ker,S,Ts)
% 
% Compute detection function based on: 
% Mellinger, DK & Clark CW (2000), "Recognizing transient low-frequency whale sounds 
% by spectrogram correlation", JASA, doi:10.1121/1.429434.
%
% ker and S should have the same height (same number of frequency bins).
% Time vector Ts should have the same length as S.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% kernel length
Nker=size(ker,2);

% spectrogram length
Ntot=size(Smag,2);    

% slide kernel window across spectrogram
for k=1:Ntot-Nker
    
    % window indices
    I=k:k+Nker-1;

    % window start time
    Ta(k)=Ts(I(1));

    % detection function (Eqn. 3 in Mellinger & Clark, 2000)
    alpha(k)=sum(sum(ker.*Smag(:,I)));
    % the following step is not clear in the paper
    % this normalization allows reducing false positives when loud noise is present
    alpha(k)=alpha(k)/(mean(mean(Smag(:,I)))); 
    if alpha(k)<0
        alpha(k)=0;
    end  
end