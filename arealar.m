function [alr] = arealar(partA , partB, bppoints, splot)

% arealar - Area of left and right segments:
% This function calculates the areas of segments left and right of V-I
% trajectory. It is our interpretation of the formulation presented in:
% A. L. Wang, B. X. Chen, C. G. Wang, and D. D. Hua, "Non-intrusive 
% load monitoring algorithm based on features of V–I trajectory" 
% Electric Power Systems Research, 2018
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
% alr is the sum of areas left and rigth 
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

if(a1<b2)
    arright = [flip(partA(1:a1,:)); partB(1:a2,:)];
    arleft = [partA(b2:end,:); flip(partB(b1:end,:))];
else
    arright = [flip(partB(1:b1,:)); partA(1:b2,:)];
    arleft = [partB(a2:end,:); flip(partA(a1:end,:))];
end

% Right area
Vr = arright(:,1);
Ir = arright(:,2);
pgonr = polyshape({Vr},{Ir});
arright = area(pgonr);

% Left area
Vl = arleft(:,1);
Il = arleft(:,2);
pgonl = polyshape({Vl},{Il});
arleft = area(pgonl);

% Sum of areas
alr = arright + arleft;

% Shows the features
if(splot.plot == 1)
    figure()
    plot(partA(:,1), partA(:,2))
    hold on
    plot(partB(:,1), partB(:,2))
    hold on 
    plot(pgonr)
    hold on 
    plot(pgonl)
    xlabel('Voltage')
    ylabel('Current')
    title(sprintf('Area of left and right segments - Load %d', splot.load))
end

end