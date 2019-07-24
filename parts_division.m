function [partA , partB, partAam] = parts_division(Ws, splot)

% parts_division - Division of V-I trajectory in part A and B. It is our 
% interpretation of the formulation presented in: This function divides 
% the V-I trajectory into two parts according to A. L. Wang, B. X. Chen, 
% C. G. Wang, and D. D. Hua, "Non-intrusive load monitoring algorithm 
% based on features of V–I trajectory" Electric Power Systems Research,
% 2018.
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
% partA is the part A of V-I trajectory 
% partB is the part A of V-I trajectory 
% partAam is the part A of V-I trajectory considering the minimum argument 
% of (VB-VA) 
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

% Find the indexes of voltage to reference
V = Ws(:,1);

vmax = max(V);
vmin = min(V);

Ivmax = find(V==vmax);                     
Ivmin = find(V==vmin);

if(Ivmax>Ivmin)
    auxi=Ivmax;
    Ivmax=Ivmin;
    Ivmin=auxi;
end

% Part A = [min, max] and part B = [1:min-1 + max+1:end]
partA = Ws(Ivmax:Ivmin,:);
partB = [Ws(1:Ivmax-1,:); Ws(Ivmin+1:end,:)];   

% It sort the vectors from the smallest to the largest
[VB,ind] = sort(partB(:,1));
IB = partB(ind,2);
partB = [VB IB];

[VA,inda] = sort(partA(:,1));
IA = partA(inda,2);
partA = [VA IA];

% Vectors with the same length 
if(length(partA)> length(partB))
    r = (length(partA) - length(partB));
    partA = partA(1: end - r,:);
elseif(length(partB) > length(partA))
    r = (length(partB) - length(partA));
    partB = partB(1: end - r,:);
end


% i' e j' are the indexes in part B, the indexes i and j are the minimum
% arguments of (VB - VA) 

L = length(partB(:,1));
indi = zeros(L,1);
for aux = 1:L
    
    [~ , indi(aux)] = min(abs(VB(aux)-VA));
    
end

VAam = VA(indi);
IAam = IA(indi);

% Part A with the  the indexes i
partAam = [VAam IAam];  

% Shows the features
if (splot.plot == 1)
  
    figure()
    plot(partA(:,1), partA(:,2), 'b')
    hold on
    plot(partB(:,1), partB(:,2), 'g')
    legend('Part A','Part B')
    title(sprintf('Division: Parts A and B - Load %d', splot.load))
    
end


end