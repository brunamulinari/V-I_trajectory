function [vetor_features] = fe_vi_STS(Vs,Is,Vt,It,nload)

% fe_vi_STS - V-I trajectory features in steady and transient states:
% This function extract the features of V-I trajectory according with 
% the article "A New Set of Steady-State and Transient Features for 
% Power Signature Analysis Based on V-I Trajectory".
%
% IN:
% Vs - vector with one voltage cycle in steady state
% Is - vector with one current cycle in steady state
% Vt - vector with one voltage cycle in transient state
% It - vector with one current cycle in transient state
% nload -  number of load (to plot)
%
% OUT:
% vetor_features -  vector with 12 features proposed in the article. 
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

% Scruct for plot figures: 
% load is the number of load
% plot is a variable to plot figures (1 - Yes, 0 - No)
splot = struct('load', nload, 'plot', 1);

% Thresroalds 
tv = 600e-3;                % For 'variationsofssl'
tasl= 5e-3;                 % For 'averagesl'

% Matrix of steady state
Wss = [Vs Is];

% Matrix of transient state
Wts = [Vt It];

[dpb, angp] = distangbp(Wss, splot);           
[len] = vilentgh(Wss, splot);                  
[md] = maximumdistance(Wss, splot);            
[vss] = variationsofssl(Wss, tv);              
[asl] = averagesl(Wss, tasl);                  
[dc, angc, dbc] = vicentroid(Wss, Wts, splot);                                                  
[dbd, dbang] = difbdistangbp(Wss, Wts, splot); 
[ov] = overshoot(Wss, Wts, splot);             

vetor_features = [dpb angp len md vss asl dc angc dbc dbd dbang ov];

end
