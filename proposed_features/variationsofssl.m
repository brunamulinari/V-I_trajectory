function [vss] = variationsofssl(Ws, tv)

% variationsofssl - Variations of the signal slope:
% Detects how many variations of the signal slope exist given a
% criterion for excluding small variations.
%
% IN:
% Ws is the matrix that presents one voltage cycle and one current cycle
% in steady state.
%                       Ws = [Vs11 Is12;
%                             Vs21 Is22;
%                             ...  ... ;
%                             VsN1 IsN2];
% tv is a threshold of variations.
%
% OUT:
% vss is the amount of signal variations.
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

V = Ws(:,1);
I = Ws(:,2);

% Variations of the signal slope
sample = ((V-V(1)).^2+(I-I(2)).^2).^0.5;
f=(sample(2:end-1)-sample(1:end-2)).*(sample(2:end-1)-sample(3:end));

% Number of variations
vss = sum(f>tv);

end