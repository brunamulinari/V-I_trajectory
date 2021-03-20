function[vetor_features] = fe_vi_f2d(Vs,Is,Vt,It, n_harmonics)

% IN:
% Vs - vector with one voltage cycle in steady state
% Is - vector with one current cycle in steady state
% Vt - vector with one voltage cycle in transient state
% It - vector with one current cycle in transient state
% n_harmonics - Number of harmonics 
%
% OUT:
% vetor_features -  vector with (4*n_harmonics+4) features proposed 
% in the article. 
%
% This code is explained and detailed in the paper 
% “Feature Extraction of V-I Trajectory using 2-D Fourier Series 
% for Electrical Load Classification". Submitted to Electric Power 
% Systems Research (ELSEVIER), 2021 (under review)
%
% (C) Bruna M. Mulinari, Federal University of Technology - Paraná. 
%
% Version: 1.0, 10 Dezember 2020
% 

% Power in steady state
Pot_s = single(mean(Vs.*Is));  

% Power in transient state
Pot_t = single(mean(Vt.*It));

% Average between the two measurements (stationary and transient)
Imed = (Is + It)./2;
Vmed = (Vs + Vt)./2;

Wmed = single([Vmed Imed]);

% Fourier descriptors 
[A, B, C, D, A0, C0] = fourier_2D(Wmed, n_harmonics);
    
vetor_features = [Pot_s Pot_t A B C D A0 C0];

end