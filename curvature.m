function r = curvature(partAam, partB, splot)

% curvature - Curvature of mean line:
% This function calculates a metric of curvature of mean line.
% It is our interpretation of the formulation presented in: A. L. Wang, 
% B. X. Chen, C. G. Wang, and D. D. Hua, "Non-intrusive load 
% monitoring algorithm based on features of V–I trajectory" Electric Power 
% Systems Research, 2018.
%
% IN:
% partAam is the part A of V-I trajectory considering the minimum argument 
% of (VB-VA)*
% partB is the part A of V-I trajectory* 
% splot is a struct to plot the features. In this struct has a variable to
% plot (1 - Yes; 0 - No) and the number of load.
%                       splot = struct('load', nload, ...
%                                       'splot', 0);
%
% *To obtain the parts(A and B) use the function "parts_division"
%
% OUT:
% r is the coefficient of linear correlation (Pearson coefficient)
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
VB = partB(:,1);
IB = partB(:,2);

% Mean line
Vmed = (VB+VA)/2;
Imed = (IB+IA)/2;

% Linear correlation coefficient (Pearson coefficient)
[r,~] = corr(Vmed,Imed);            

% Shows the features
if(splot.plot == 1)
    
    figure()
    plot(VA, IA, 'b')
    hold on
    plot(VB,IB, 'g')
    hold on
    plot(Vmed, Imed, 'r')
    legend('Part A - Considering arg min','Part B', 'Mean Line')
    title(sprintf('Curvature of mean line - Load %d', splot.load))

end

end