function [dbd, dbang] = difbdistangbp(Wt, Ws, splot)

% difbdistangbp - Difference between points distance:
% Calculate difference between distances, maximum point to minimum, in the
% state stationary and transient. Also, the difference between the angles.
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
% dbd is the difference between the two distances, in steady and transient 
% states 
% dbang is the difference between angles in steady and transient states 
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

% Transient state distance and angle
[distts, angts] = distangbp(Wt,splot);

% Steady state distance and angle
[distss, angss] = distangbp(Ws, splot);

% Differences
dbd = distts - distss; 
dbang = angts - angss;


end