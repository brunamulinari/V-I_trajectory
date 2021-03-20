function [asl] = averagesl(Ws, tasl)

% averagesl - Average slope value:
% Determine the average slope variation.
%
% IN:
% Ws is the matrix that presents one voltage cycle and one current cycle
% in steady state.
%                       Ws = [Vs11 Is12;
%                             Vs21 Is22;
%                             ...  ... ;
%                             VsN1 IsN2];
% tasl is a threshold to variations of voltage.
%
% OUT:
% len is the average slope variation.
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

% Variations in voltage and current 
dI = I(2:end)-I(1:end-1);
dV = V(2:end)-V(1:end-1);

% Given a criterion, it eliminates the smaller tensions of the vector.
[in,~]= find(abs(dV) <= tasl);

L = length(in);
for aux = 1:L
    if(in(aux) ~=1)
        dV(in(aux)) = dV(in(aux)-1);
    else
        dV(in(aux)) = dV(in(aux)+1);
    end    
end
N = length(dV);

% Slopes
slp = dI./dV;
slp_var = slp(2:end)-slp(1:end-1);

% Average slope variation
asl = sum(slp_var(isfinite(slp_var)))/N;

end
