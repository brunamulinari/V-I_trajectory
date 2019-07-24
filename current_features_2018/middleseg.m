function [Wr, Wt] = middleseg(partA , partB, bppoints, splot)

% smiddles - Middle segment:
% This function defines the middle segment. It is our interpretation of the 
% formulation presented in: A. L. Wang, B. X. Chen, C. G. Wang, and D. D. 
% Hua, "Non-intrusive load monitoring algorithm based on features of V–I 
% trajectory" Electric Power Systems Research,2018
% 
% IN:
% partA is the part A of V-I trajectory* 
% partB is the part A of V-I trajectory* 
% bppoints are the bending points of V-I trajectory**
% splot is a struct to plot the features. In this struct has a variable to
% plot (1 - Yes; 0 - No) and the number of load.
%                       splot = struct('load', nload, ...
%                                       'splot', 0);
%
% *To obtain the parts(A and B) use the function "parts_division"
% **To obtain the bending points use the function "bp"
%
% OUT:
% Wr is middle segment in part A
% Wt is middle segment in part B
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

a1 = bppoints(1);
a2 = bppoints(2);
b1 = bppoints(3);
b2 = bppoints(4);

if(b2>a1)
    Ir = partA(a1:b2,2);
    Vr = partA(a1:b2,1);
else
    Ir = partA(b2:a1,2);
    Vr = partA(b2:a1,1);
end

% Middle segment of part A
Wr = [Vr  Ir];

if(b1>a2)
    It = partB(a2:b1,2);
    Vt = partB(a2:b1,1);
else
    It = partB(b1:a2,2);
    Vt = partB(b1:a2,1);
end

% Middle segment of part B
Wt = [Vt  It];

% Shows the features
if(splot.plot == 1)
    
    figure()   
    plot(partA(:,1), partA(:,2), 'b')
    hold on
    plot(partB(:,1), partB(:,2), 'g')
    hold on
    plot(Wr(:,1),Wr(:,2), 'c')
    hold on 
    plot(Wt(:,1),Wt(:,2), 'm')
    legend('part A', 'part B', 'middle segment - partA', 'middle segment - partB')       
    title(sprintf('Middle segment - Load %d', splot.load))

end

end