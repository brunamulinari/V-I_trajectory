function [dpb, angp] = distangbp(W, splot)

% Distance and angle between points:
% Calculates the distance between the maximum and minimum points of the 
% V-I trajectory. It also, calculates the angle formed 
% by these points.
%
% IN:
% Ws is the matrix that presents one voltage cycle and one current cycle

%                       W = [V11 I12;
%                            V21 I22;
%                            ...  ... ;
%                            VN1 IN2];
% splot is a struct to plot the features. In this struct has a variable to
% plot (1 - Yes; 0 - No) and the number of load.
%                       splot = struct('load', nload, ...
%                                       'splot', 0);
%
% OUT:
% dpb is the distance between the maximum and minimum points of trajectory
% angp is the angle between the maximum and minimum points of trajectory
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

% Maximum and minimum points of V-I trajectory in steady state 
P_max = max(W);
P_min = min(W);

V1 = P_max(1,1);
I1 = P_max(1,2);

V2 = P_min(1,1);
I2 = P_min(1,2);

% Calculation of the distance between the two points
dpb = sqrt(abs(V1-V2).^2 + abs(I1-I2).^2);

% Angle calculation
angp =atand((I1-I2)/(V1-V2));

% Shows the feature
if(splot.plot == 1)
   
    vetor = [P_max(1,1) P_max(1,2);  P_min(1,1)  P_min(1,2)];
    figure()
    plot(W(:,1), W(:,2))
    hold on
    plot(vetor(:,1), vetor(:,2), '-o')
    xlabel('Voltage')
    ylabel('Current')
    title(sprintf('Distance between maximum and minimum points - Load %d', splot.load))
    
end

end
