function [sh] = smiddles(Wr, Wt)

% smiddles - Shape of middle segment:
% This function calculates standard deviations of middle segment. It is our 
% interpretation of the formulation presented in: A. L. Wang, B. X. Chen, 
% C. G. Wang, and D. D. Hua, "Non-intrusive load monitoring algorithm based 
% on features of V–I trajectory" Electric Power Systems Research, 2018
% 
% IN:
% Wr is middle segment in part A*
% Wt is middle segment in part B*
%
% *To obtain the middle segment in parts use the function "middleseg"
%
% OUT:
% sh is the sum of the standard deviations in parts A and B of the middle 
% segment of the V-I trajectory
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

Ir = Wr(:,2);
It = Wt(:,2);

sh = std(Ir) + std(It);

end