function asy = asymmetry(Ws, splot)

% asymmetry - Asymmetry:
% This function calculates the V-I trajectory asymmetry 
% It is our interpretation of the formulation presented in: A. L.
% Wang, B. X. Chen, C. G. Wang, and D. D. Hua, "Non-intrusive load 
% monitoring algorithm based on features of V–I trajectory" Electric Power 
% Systems Research, 2018.
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
% asy is defined by the Hausdorff distance 
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

% 180° in trajectory
VI180 = (-1)*Ws;

% Hausdorff distance
asy = ModHausdorffDist(Ws,VI180);

% Shows the features
if(splot.plot == 1)
    
    figure()
    plot(Ws(:,1), Ws(:,2), 'b')
    hold on
    plot(VI180(:,1),VI180(:,2), 'g')
    xlabel('Voltage(V)')
    ylabel('Current(A)')
    legend('Original trajectory','180° trajectory')
    title(sprintf('Asymmetry - Load %d', splot.load))

end

end