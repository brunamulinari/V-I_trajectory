function [len] = vilentgh(Ws, splot)


% vilength - Length of V-I trajectory:
% Calculates the lentgh of V-I trajectory in steady state.
%
% IN:
% Ws is the matrix that presents one voltage cycle and one current cycle
% in steady state.
%                       Ws = [Vs11 Is12;
%                             Vs21 Is22;
%                             ...  ... ;
%                             VsN1 IsN2];
% splot is a struct to plot the features. In this struct has a variable to
% plot (1 - Yes; 0 - No) and the number of load.
%                       splot = struct('load', nload, ...
%                                       'splot', 0);
%
% OUT:
% len is the length of the V-I trajectory in steady state.
%
% This function is explain in "A New Set of Steady-State and Transient Features 
% for Power Signature Analysis Based on V-I Trajectory ". Accepted in: IEEE PES 
% Innovative Smart Grid Technology Latin America,2019. You are free to use, 
% change, or redistribute this code in any way you want for non-commercial 
% purposes. However, it is appreciated if you maintain the name of the original 
% author.
%
% (C) Bruna M. Mulinari, Federal University of Technology - Paraná. 
%
% Version: 1.0, 16 April 2019
% 

N=length(Ws)-1;
len=0;

% Sum the "pieces"
for k=2:N
    len = len + norm(Ws(k,:) - Ws(k-1,:));
end

% Shows the features
if(splot.plot == 1)
    
    figure()
    plot(Ws(:,1), Ws(:,2), '-o')
    xlabel('Voltage')
    ylabel('Current')
    title(sprintf('Length of V-I trajectory - Load %d', splot.load))
    
end

end
