function D = admittance(Ws, vl)

% admittance - Variation of instantaneous admittance:
% This function calculates the instantaneous admittance standard deviation. 
% It is our interpretation of the formulation presented in:
% A. L. Wang, B. X. Chen, C. G. Wang, and D. D. Hua, 
% "Non-intrusive load monitoring algorithm based on features of V–I 
% trajectory" Electric Power Systems Research, 2018.
%
% IN:
% Ws is the matrix that presents one voltage cycle and one current cycle
% in steady state.
%                       Ws = [Vs11 Is12;
%                             Vs21 Is22;
%                             ...  ... ;
%                             VsN1 IsN2];
% vl is a threshold to exclude small voltages 
%
% OUT:
% D is the standard deviation of admittance
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019


V = Ws(:,1);
I = Ws(:,2);

% Eliminates small voltage
index = find(((V>vl) + (V<-vl)) == 1);
V = V(index,1);
I = I(index,1);

% Calculates the instantaneous admittance
s = I./V;

% Standard deviation
D = std(s);

end