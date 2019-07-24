function ar = areaW(partAam, partB)

% areaW - Area:
% This function calculates the V-I trajectory area. It is our 
% interpretation of the formulation presented in: A. L. Wang, 
% B. X. Chen, C. G. Wang, and D. D. Hua, "Non-intrusive load monitoring 
% algorithm based on features of V–I trajectory" Electric Power Systems 
% Research, 2018.
%
% IN:
% partAam is the part A of V-I trajectory considering the minimum argument 
% of (VB-VA)*
% partB is the part A of V-I trajectory* 
%
% *To obtain the parts(A and B) use the function "parts_division"
%
% OUT:
% ar is the V-I trajectory area. 
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%


VA = partAam(:,1); 
IA = partAam(:,2);
IB = partB(:,2);

dV = abs(VA(2:end)- VA(1:end-1));
B =  abs(IB(2:end)-IA(2:end));
b = abs(IB(1:end-1)-IA(1:end-1));
at = 0.5*(dV.*(B+b));

ar = sum(at);

end