function sc = selfintersec(partAam, partB, splot)

% selfintersec - Self-intersection:
% This function calculates the number of self-intersection of V-I
% trajectory. It is our interpretation of the formulation presented in:
% A. L. Wang, B. X. Chen, C. G. Wang, and D. D. Hua, "Non-intrusive 
% load monitoring algorithm based on features of V–I trajectory" 
% Electric Power Systems Research, 2018
%
% IN:
% partAam is the part A of V-I trajectory considering the minimum argument* 
% partB is the part A of V-I trajectory* 
% splot is a struct to plot the features. In this struct has a variable to
% plot (1 - Yes; 0 - No) and the number of load.
%                       splot = struct('load', nload, ...
%                                       'splot', 0);
% *To obtain the parts(A and B) use the function "parts_division"
%
% OUT:
% sc is the number of self-intersection
%
% If you use this function cite " A New Set of Steady-State and Transient
% Features for Power Signature Analysis Based on V-I Trajectory". Accepted 
% in: IEEE PES Innovative Smart Grid Technology Latin America, 2019.
%
%   Author: Bruna Machado Mulinari
%   Version: 1.0, 16 April 2019
%

L = length(partAam);
pe = zeros(L,1); 
for k = 1:L -1
    ij = partAam(k+1,:) - partAam(k,:);
    iil = partB(k,:) - partAam(k,:);
    ijl =  partB(k+1,:) - partAam(k,:);
    ij = [ij 0];
    iil = [iil 0];
    ijl = [ijl 0];
    pv1 = cross(ij,iil);
    pv2 = cross(ij,ijl);
    pe(k,1) = dot(pv1,pv2);
end

sc = sum(pe<0);

% Shows the features
if(splot.plot == 1)
    
    [ind,~] = find(pe<0);
    si = partB(ind,:);
    
    figure()
    plot(partAam(:,1), partAam(:,2))
    hold on
    plot(partB(:,1), partB(:,2))
    hold on
    plot(si(:,1), si(:,2), 'ro')
    title(sprintf('Self - Intersection - Load %d', splot.load))
    
end

end