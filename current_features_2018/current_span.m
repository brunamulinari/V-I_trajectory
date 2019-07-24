function itc = current_span(Current)

% current_span - Current Span:
% This function calculates a metric of active power magnitude.
% It is our interpretation of the formulation presented in:
% A. L. Wang, B. X. Chen, C. G. Wang, and D. D. Hua, "Non-intrusive load 
% monitoring algorithm based on features of V–I trajectory" Electric Power 
% Systems Research, 2018.
%
% IN:
% Current is the one cycle of current in steady state
%
% OUT:
% itc is a metric of active power magnitude
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

Imax = max(Current);
Imin = min(Current);

itc = Imax - Imin;

end