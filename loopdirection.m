function lpa = loopdirection(Ws)

% loopdirection - Area with loop direction:
% Calculates the area with loop direction. It is our interpretation of the 
% formulation presented in: A. L. Wang, B. X. Chen, C. G. Wang, and D. D. 
% Hua, "Non-intrusive load monitoring algorithm based on features of V–I 
% trajectory" Electric Power Systems Research,2018
%
% IN:
% Ws is the matrix that presents one voltage cycle and one current cycle
% in steady state.
%                       Ws = [Vs11 Is12;
%                             Vs21 Is22;
%                             ...  ... ;
%                             VsN1 IsN2];
%
% OUT:
% lpa is the area with loop direction
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

V = Ws(:,1);
I = Ws(:,2);

lpa = sum(0.5*((V(2:end)-V(1:end-1)).*(I(2:end)-I(1:end-1))));
 
end