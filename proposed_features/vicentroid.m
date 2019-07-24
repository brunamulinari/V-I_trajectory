function [dc, angc, dbc] = vicentroid(Ws, Wt, splot)

% vicentroid - Features using centroid of V-I trajectory: 
% Calculates the distance of the centroid of the V-I trajectory in
% relation to the origin and the angle formed between these points. 
% In adittion, a distance metric is caculate between the centroids
% of trajectories in the steady and transient states.
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
% dc is the distance of the centroid of the V-I trajectory (steady state) 
% in relation to the origin. 
% angc is the angle, in degress, between the centroid of V-I trajectory 
% (steady state) and the origin. 
% dbc is the distance between of two centroids of the trajectoris, in the
% steady and transient states.
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

% Creates a polygon of the V-I trajectory in steady state
poly_ss = polyshape({Ws(:,1)}, {Ws(:,2)});

% V-I trajectory centroid steady state
[Vx_ss,Iy_ss] = centroid(poly_ss);

% Creates a polygon of the V-I trajectory in transient state
poly_ts = polyshape({Wt(:,1)}, {Wt(:,2)});

% V-I trajectory centroid steady state
[Vx_ts,Iy_ts] = centroid(poly_ts);

% Origin
Iyo = 0;
Vxo = 0;

% STEADY STATE
% Calculation of maximum distance from V-I centroid to origin 
dc = sqrt(abs(Vx_ss-Vxo).^2 + abs(Iy_ss-Iyo).^2);
% Vector angle calculation
angc = atand((Iy_ss/Vx_ss));

% DIFFENCE BETWEEN STATES
% Difference between centroids
dbc = sqrt(abs(Vx_ts-Vx_ss).^2 + abs(Iy_ts-Iy_ss).^2);

% Shows the features
if(splot.plot == 1)
   
    vetor = [Vx_ss Iy_ss;  Vx_ts Iy_ts; 0 0];
    
    figure()
    plot(Ws(:,1), Ws(:,2))
    hold on
    plot(vetor(1,1), vetor(1,2), 'ro')
    hold on  
    plot(vetor(3,1), vetor(3,2), 'x')
    legend('V-I trajectory','Centroid','Origin')
    xlabel('Voltage')
    ylabel('Current')
    title(sprintf('Centroid in steady state - Load %d', splot.load))

    figure()
    plot(Ws(:,1), Ws(:,2))
    hold on
    plot(Wt(:,1), Wt(:,2))
    hold on
    plot(vetor(1:2,1), vetor(1:2,2), '-o')
    legend('Steady state','Transient State')
    xlabel('Voltage')
    ylabel('Current')
    title(sprintf('Difference between centroids - Load %d', splot.load))
    
end

end