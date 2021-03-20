function [ov] = overshoot(Ws, Wt, splot)

% overshoot - Overshoot of current:
% Calculates the current overshoot using the difference between the 
% maximum points of the trajectories V-I in the transient period Wt and 
% in the steady period Wp
% 
% IN:
% Ws is the matrix that presents one voltage cycle and one current cycle
% in steady state.
%                       Ws = [Vs11 Is12;
%                             Vs21 Is22;
%                             ...  ... ;
%                             VsN1 IsN2];
% Wt is the matrice that presents one voltage cycle and one current cycle
% in transient state.
%                       Wt = [Vt11 It12;
%                             Vt21 It22;
%                             ...  ... ;
%                             VtN1 ItN2];
% splot is a struct to plot the features. In this struct has a variable to
% plot (1 - Yes; 0 - No) and the number of load. 
%                       splot = struct('load', nload, ...
%                                       'splot', 0);
%
% OUT:
% ov is the overshoot of current.
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

% The maximum values of the trajectory in steady state and transitory
max_wt = max(Wt(:,2));
max_ws = max(Ws(:,2));

% Difference between the maximum points - Current overshoot
ov = max_wt - max_ws;

% Shows the feature
if(splot.plot == 1)
   
    [inVs, ~] = find(Ws(:,2)==max_ws);
    [inVt, ~] = find(Wt(:,2)==max_wt);
    
    figure()
    plot(Wt(:,1), Wt(:,2), 'Color', 'r')
    hold on 
    plot(Ws(:,1), Ws(:,2), 'Color', 'b')
    hold on 
    plot([Ws(inVs,1) Wt(inVt,1)], [max_ws max_wt], '-o')
    legend('Transient','Steady', 'Overshoot')
    xlabel('Voltage')
    ylabel('Current')
    title(sprintf('Current overshoot - Load %d', splot.load))
    
end

end
