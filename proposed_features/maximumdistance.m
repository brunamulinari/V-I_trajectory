function [md] = maximumdistance(Ws, splot)

% maximumdistance - Maximum distance:
% Calculates the maximum distance between all points in V-I trajectory and
% the origin (0,0)
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
% md is the maximum distance of V-I trajectory in steady state.
%
% This function is explain in "A New Set of Steady-State and Transient Features 
% for Power Signature Analysis Based on V-I Trajectory ". Accepted in: IEEE PES 
% Innovative Smart Grid Technology Latin America,2019. You are free to use, 
% change, or redistribute this code in any way you want for non-commercial 
% purposes. However, it is appreciated if you maintain the name of the original 
% author.
%
% (C) Bruna M. Mulinari, Federal University of Technology - Paraná. 
%
% Version: 1.0, 16 April 2019
% 

V = Ws(:,1);
I = Ws(:,2);

[md, index] = max(sqrt(V.*V +I.*I));

% Shows the feature
if(splot.plot == 1)
    
    figure()
    plot(Ws(:,1), Ws(:,2), 'Color', 'b')
    hold on
    plot([Ws(index,1) 0], [Ws(index,2) 0], '-o')
    xlabel('Voltage')
    ylabel('Current')
    title(sprintf('Maximum distance - Load %d', splot.load))
end

end