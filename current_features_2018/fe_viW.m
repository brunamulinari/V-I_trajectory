function [vetor_features] = fe_viW(Vs,Is,nload)

% fe_viW - V-I trajectory features in steady state:
% This function extract the features of V-I trajectory.
% It is our interpretation of the formulation presented in: 
% A. L. Wang, B. X. Chen, C. G. Wang, and D. D. Hua, "Non-intrusive load 
% monitoring algorithm based on features of V–I trajectory" Electric Power 
% Systems Research, 2018
%
% IN:
% Vs - vector with one voltage cycle in steady state
% Is - vector with one current cycle in steady state
% nload -  número da carga
%
% OUT:
% vetor_features -  vector with 10 features proposed in the article. 
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

% Scruct for plot figures: 
% load is the number of load
% plot is a variable to plot figures (1 - Yes, 0 - No)
splot = struct('load', nload, 'plot', 1);

% Thresroald to admittance function 
vl = 100e-3;

% Matrix of steady state 
Wss = [Vs Is];

% Division of V-I trajectory in two parts A and B
[partA , partB, partAam] = parts_division(Wss, splot);

% The bending points of V-I trajectory
bppoints = bp(partA, partB, splot);

% The middle segment of V-I trajectory
[Wr, Wt] = middleseg(partA , partB, bppoints, splot);

% Features:
itc = current_span(Is);                          % Current span 
ar = areaW(partAam, partB);                     % Area 
lpa = loopdirection(Wss);                       % Area with loop direction
asy = asymmetry(Wss, splot);                    % Asymmetry
r = curvature(partAam, partB, splot);           % Curvature of mean line
sc = selfintersec(partAam, partB, splot);       % Self - Intersection 
mi = peak(partA , partB, bppoints, Wr, Wt);     % Peak of middle segment
sh = smiddles(Wr, Wt);                          % Shape of middle segment
alr = arealar(partA , partB, bppoints, splot);  % Area of left and right seg
D = admittance(Wss, vl);                        % Variation of admitance

vetor_features = [itc ar lpa asy r sc mi sh alr D];


end